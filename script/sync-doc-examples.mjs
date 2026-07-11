#!/usr/bin/env node
/**
 * Syncs compilable doc examples from examples/src/Examples/Docs/*.purs
 * into the -- | doc comments of src/JS/Temporal/*.purs.
 *
 * Convention: each Examples.Docs.<Foo> module has exampleBar for every
 * function bar exported from JS.Temporal.<Foo>. The qualified name is
 * derived automatically (e.g. Examples.Docs.Instant.exampleFromString
 * maps to JS.Temporal.Instant.fromString).
 *
 * Runs Examples.Docs.Main to capture stdout, then injects both code and
 * output blocks into source docs. The docs runner is executed with the
 * dev Temporal polyfill preloaded.
 *
 * Run from repo root: node script/sync-doc-examples.mjs
 */

import { execSync } from "child_process";
import { readFileSync, readdirSync, writeFileSync } from "fs";
import { join } from "path";
import { pathToFileURL } from "url";

const ROOT = new URL("..", import.meta.url).pathname;
const DOCS_DIR = join(ROOT, "examples", "src", "Examples", "Docs");
const SRC_DIR = join(ROOT, "src");
const TEMPORAL_POLYFILL_LOADER = join(ROOT, "script", "register-temporal-polyfill.mjs");

function withTemporalPolyfillNodeOptions(existingNodeOptions = "") {
  const temporalPolyfillImport = `--import=${TEMPORAL_POLYFILL_LOADER}`;
  if (existingNodeOptions.includes(temporalPolyfillImport)) {
    return existingNodeOptions;
  }
  return existingNodeOptions.trim().length === 0
    ? temporalPolyfillImport
    : `${existingNodeOptions} ${temporalPolyfillImport}`;
}

/**
 * Runs Examples.Docs.Main and parses stdout for --- OUTPUT <qualifiedName> --- ... --- /OUTPUT ---
 * @returns Map<qualifiedName, outputText>
 */
function runDocsRunnerAndParseOutput() {
  const outputMap = new Map();
  try {
    const stdout = execSync(
      "spago run -p js-temporal-examples -m Examples.Docs.Main 2>/dev/null",
      {
        encoding: "utf-8",
        cwd: ROOT,
        env: {
          ...process.env,
          NODE_OPTIONS: withTemporalPolyfillNodeOptions(process.env.NODE_OPTIONS),
        },
      }
    );
    const outputRegex = /--- OUTPUT (.+?) ---\n([\s\S]*?)\n--- \/OUTPUT ---/g;
    let m;
    while ((m = outputRegex.exec(stdout)) !== null) {
      const qualifiedName = m[1].trim();
      const output = m[2].trimEnd();
      if (output.startsWith("[[EXAMPLE ERROR]] ")) {
        console.warn(`Warning: Example ${qualifiedName} failed while capturing output: ${output}`);
        continue;
      }
      outputMap.set(qualifiedName, output);
    }
  } catch (err) {
    console.warn(
      "Warning: Docs runner failed even with the Temporal polyfill preloaded. Output blocks will be omitted."
    );
  }
  return outputMap;
}

/**
 * Derives the JS.Temporal module name from a docs file path.
 * e.g. .../Examples/Docs/Instant.purs -> "JS.Temporal.Instant"
 */
function docsFileToModule(filePath) {
  const name = filePath
    .slice(DOCS_DIR.length + 1)
    .replace(/\.purs$/, "")
    .replaceAll("/", ".");
  return `JS.Temporal.${name}`;
}

/**
 * Converts an example function name to the target export name.
 * "exampleFromString" -> "fromString"
 */
function exampleNameToExport(name) {
  const withoutPrefix = name.slice("example".length);
  return withoutPrefix.charAt(0).toLowerCase() + withoutPrefix.slice(1);
}

/**
 * Checks if a line is a top-level declaration start (non-indented, non-comment, non-blank).
 */
function isTopLevelDeclarationStart(line) {
  if (line.trim() === "") return false;
  if (line.startsWith(" ") || line.startsWith("\t")) return false;
  if (line.startsWith("--")) return false;
  return true;
}

/**
 * Extracts all example functions from a docs file using naming convention.
 * @returns Array of { qualifiedName: string, code: string, prose: string | null }
 */
function extractExamples(filePath) {
  const content = readFileSync(filePath, "utf-8");
  const lines = content.split("\n");
  const moduleName = docsFileToModule(filePath);
  const examples = [];

  // First pass: find all exampleFoo declaration start lines
  const exampleStarts = [];
  for (let i = 0; i < lines.length; i++) {
    const match = lines[i].match(/^(example[A-Z][A-Za-z0-9_']*)\s/);
    if (match) {
      const fnName = match[1];
      // Only record the first occurrence (type signature line)
      if (!exampleStarts.some((e) => e.fnName === fnName)) {
        exampleStarts.push({ fnName, startLine: i });
      }
    }
  }

  // Second pass: extract code and prose for each example
  for (let idx = 0; idx < exampleStarts.length; idx++) {
    const { fnName, startLine } = exampleStarts[idx];
    const exportName = exampleNameToExport(fnName);
    const qualifiedName = `${moduleName}.${exportName}`;

    // Look backwards from startLine for -- | doc comment prose
    let proseStart = startLine;
    while (proseStart > 0 && lines[proseStart - 1].trimStart().startsWith("-- |")) {
      proseStart--;
    }
    const proseLines = lines.slice(proseStart, startLine);
    const prose = proseLines.length > 0
      ? proseLines.map((l) => l.replace(/^\s*-- \| ?/, "")).join("\n").trim() || null
      : null;

    // Find the end: next example start, or next unrelated top-level decl, or EOF
    let endLine = lines.length;
    for (let j = startLine + 1; j < lines.length; j++) {
      if (isTopLevelDeclarationStart(lines[j]) && !new RegExp(`^${escapeRegex(fnName)}(?:\\s|$)`).test(lines[j])) {
        endLine = j;
        break;
      }
    }

    // Trim trailing blank lines
    while (endLine > startLine && lines[endLine - 1].trim() === "") {
      endLine--;
    }

    // Trim trailing doc comment lines (-- |) that belong to the next example
    while (endLine > startLine && lines[endLine - 1].trimStart().startsWith("-- |")) {
      endLine--;
    }

    // Trim any additional blank lines after removing doc comments
    while (endLine > startLine && lines[endLine - 1].trim() === "") {
      endLine--;
    }

    const codeLines = lines.slice(startLine, endLine);
    const code = dedent(codeLines.join("\n"));
    examples.push({ qualifiedName, code, prose });
  }

  return examples;
}

function dedent(str) {
  const lines = str.split("\n");
  const nonEmpty = lines.filter((l) => l.trim().length > 0);
  if (nonEmpty.length === 0) return str;

  const minIndent = Math.min(
    ...nonEmpty.map((l) => {
      const m = l.match(/^(\s*)/);
      return m ? m[1].length : 0;
    })
  );

  return lines
    .map((l) => (l.length >= minIndent ? l.slice(minIndent) : l))
    .join("\n")
    .trimEnd();
}

/**
 * Maps qualified name to source file path.
 * e.g. JS.Temporal.PlainDateTime.until -> src/JS/Temporal/PlainDateTime.purs
 */
function qualifiedNameToPath(qualifiedName) {
  const lastDot = qualifiedName.lastIndexOf(".");
  const modulePath = qualifiedName.slice(0, lastDot);
  const functionName = qualifiedName.slice(lastDot + 1);
  const filePath = join(
    SRC_DIR,
    modulePath.replace(/\./g, "/") + ".purs"
  );
  return { filePath, functionName };
}

/**
 * Formats example code (and optional output) as doc comment blocks.
 */
function formatExampleBlocks(code, output) {
  const codeFence = "```purescript";
  const codeLines = code.split("\n");
  const codeBlock = [codeFence, ...codeLines, "```"].map((l) => `-- | ${l}`).join("\n");
  if (!output) return codeBlock;
  const outputFence = "```text";
  const outputLines = output.split("\n");
  const outputBlock = [outputFence, ...outputLines, "```"].map((l) => `-- | ${l}`).join("\n");
  return codeBlock + "\n-- | ---\n" + outputBlock;
}

// Opening fence - match "```purescript" in a doc line
const FENCE_START = /-- \| ```purescript/;
const FENCE_END = /-- \| ```\s*$/;
const FENCE_OUTPUT_START = /-- \| ```text/;

function splitLines(content) {
  return content.split("\n");
}

function isDocCommentLine(line) {
  return line.trimStart().startsWith("-- |");
}

function isBlankLine(line) {
  return line.trim() === "";
}

function stripDocCommentPrefix(line) {
  return line.replace(/^\s*-- \| ?/, "");
}

function normalizeDocCommentLine(line) {
  return line.replace(/^(\s*)-- \| ?/, (_, spaces) => spaces + "-- | ");
}

function isBlankDocCommentLine(line) {
  return stripDocCommentPrefix(line).trim() === "";
}

function isManagedFenceStart(content) {
  return content === "```purescript" || content === "```text";
}

function isFenceEnd(content) {
  return content === "```";
}

function trimTrailingBlankDocCommentLines(lines) {
  const trimmedLines = lines.slice();
  while (trimmedLines.length > 0 && isBlankDocCommentLine(trimmedLines[trimmedLines.length - 1])) {
    trimmedLines.pop();
  }
  return trimmedLines;
}

function trimLeadingBlankDocCommentLines(lines) {
  const trimmedLines = lines.slice();
  while (trimmedLines.length > 0 && isBlankDocCommentLine(trimmedLines[0])) {
    trimmedLines.shift();
  }
  return trimmedLines;
}

function collapseRepeatedBlankDocCommentLines(lines) {
  const collapsedLines = [];
  let previousLineWasBlank = false;

  for (const line of lines) {
    const lineIsBlank = isBlankDocCommentLine(line);
    if (lineIsBlank && previousLineWasBlank) {
      continue;
    }

    collapsedLines.push(lineIsBlank ? "-- |" : line);
    previousLineWasBlank = lineIsBlank;
  }

  return collapsedLines;
}

/**
 * Finds the line where the function definition starts (function name at column 0).
 * Matches both multi-line (name on own line, next line has ::) and single-line (name :: ...).
 */
function findFunctionLineIndex(lines, functionName) {
  const escapedFunctionName = escapeRegex(functionName);
  const functionNameRegex = new RegExp(
    `^${escapedFunctionName}(?:\\s*$|\\s+::|\\s+=|\\s+=>)`
  );
  const foreignImportRegex = new RegExp(
    `^foreign\\s+import\\s+${escapedFunctionName}\\s+::`
  );

  for (let lineIndex = 0; lineIndex < lines.length; lineIndex++) {
    if (foreignImportRegex.test(lines[lineIndex])) {
      return lineIndex;
    }

    if (!functionNameRegex.test(lines[lineIndex])) {
      continue;
    }

    const nextLine = lines[lineIndex + 1]?.trimStart() ?? "";
    const hasNextLineSignature =
      nextLine.startsWith("::") ||
      nextLine.startsWith("=>") ||
      nextLine.startsWith("=");
    const hasInlineSignature =
      lines[lineIndex].includes("::") ||
      lines[lineIndex].includes("=");

    if (hasInlineSignature || hasNextLineSignature) {
      return lineIndex;
    }
  }

  return -1;
}

/**
 * Finds the function's contiguous doc comment block immediately above the declaration.
 * Only `-- |` lines belong to the doc block; plain `--` comments do not.
 */
function findFunctionDocBlock(lines, functionName) {
  const functionLineIndex = findFunctionLineIndex(lines, functionName);

  if (functionLineIndex === -1) {
    return null;
  }

  let docEndIndex = functionLineIndex - 1;
  while (docEndIndex >= 0 && isBlankLine(lines[docEndIndex])) {
    docEndIndex--;
  }

  if (docEndIndex < 0 || !isDocCommentLine(lines[docEndIndex])) {
    return {
      functionLineIndex,
      docStartIndex: functionLineIndex,
      docEndIndex: functionLineIndex - 1,
      docLines: [],
      hasDoc: false,
    };
  }

  let docStartIndex = docEndIndex;
  while (docStartIndex > 0 && isDocCommentLine(lines[docStartIndex - 1])) {
    docStartIndex--;
  }

  return {
    functionLineIndex,
    docStartIndex,
    docEndIndex,
    docLines: lines
      .slice(docStartIndex, docEndIndex + 1)
      .map(normalizeDocCommentLine),
    hasDoc: true,
  };
}

function escapeRegex(s) {
  return s.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
}

function findFenceBlockEndIndex(docLines, startIndex) {
  for (let lineIndex = startIndex + 1; lineIndex < docLines.length; lineIndex++) {
    const content = stripDocCommentPrefix(docLines[lineIndex]).trim();
    if (isFenceEnd(content)) {
      return lineIndex;
    }
  }

  throw new Error(`Unclosed fenced doc block starting at doc line ${startIndex + 1}`);
}

/**
 * Inserts or replaces the managed example region (code block + optional output block).
 * Removes all managed fenced blocks, preserves surrounding prose, and inserts the
 * canonical block where the first managed block appeared. If no managed block exists,
 * appends the block at the end of the doc comment.
 */
function replaceManagedExampleRegion(docLines, exampleCode, exampleOutput) {
  const newBlockLines = formatExampleBlocks(exampleCode, exampleOutput).split("\n");
  const remainingDocLines = [];
  let insertionIndex = null;

  for (let lineIndex = 0; lineIndex < docLines.length; lineIndex++) {
    const content = stripDocCommentPrefix(docLines[lineIndex]).trim();

    if (isManagedFenceStart(content)) {
      if (insertionIndex === null) {
        insertionIndex = remainingDocLines.length;
      }

      lineIndex = findFenceBlockEndIndex(docLines, lineIndex);
      continue;
    }

    // Skip --- separator lines between managed fence blocks
    if (content === "---" && insertionIndex !== null) {
      continue;
    }

    remainingDocLines.push(normalizeDocCommentLine(docLines[lineIndex]));
  }

  if (insertionIndex === null) {
    insertionIndex = remainingDocLines.length;
  }

  const beforeManagedRegion = trimTrailingBlankDocCommentLines(
    remainingDocLines.slice(0, insertionIndex)
  );
  const afterManagedRegion = trimLeadingBlankDocCommentLines(
    remainingDocLines.slice(insertionIndex)
  );

  const replacedDocLines = [...beforeManagedRegion];
  if (replacedDocLines.length > 0) {
    replacedDocLines.push("-- |");
  }
  replacedDocLines.push(...newBlockLines);
  if (afterManagedRegion.length > 0) {
    replacedDocLines.push("-- |");
  }
  replacedDocLines.push(...afterManagedRegion);

  return collapseRepeatedBlankDocCommentLines(replacedDocLines);
}

/**
 * Updates the source content with the new doc comment.
 * When `prose` is provided (from the example file), it replaces any existing
 * non-fenced prose in the source doc comment. When `prose` is null, existing
 * prose is preserved.
 */
function updateSourceContent(content, functionName, exampleCode, exampleOutput, prose) {
  const lines = splitLines(content);
  const block = findFunctionDocBlock(lines, functionName);
  if (!block) {
    return null;
  }

  let newDocLines;
  if (prose != null) {
    // Prose comes from the example file — build the full doc comment from scratch
    const proseDocLines = prose.split("\n").map((l) => (l.trim() === "" ? "-- |" : `-- | ${l}`));
    const exampleBlockLines = formatExampleBlocks(exampleCode, exampleOutput).split("\n");
    newDocLines = [...proseDocLines, "-- |", ...exampleBlockLines];
    newDocLines = collapseRepeatedBlankDocCommentLines(newDocLines);
  } else if (block.hasDoc) {
    newDocLines = replaceManagedExampleRegion(
      block.docLines,
      exampleCode,
      exampleOutput
    );
  } else {
    newDocLines = formatExampleBlocks(exampleCode, exampleOutput).split("\n");
  }

  newDocLines = trimTrailingBlankDocCommentLines(newDocLines);

  const beforeDocBlock = lines.slice(0, block.docStartIndex);
  const declarationAndAfter = lines.slice(block.functionLineIndex);

  // Ensure a blank line separates the preceding code from the doc comment
  if (beforeDocBlock.length > 0 && beforeDocBlock[beforeDocBlock.length - 1].trim() !== "") {
    beforeDocBlock.push("");
  }

  return [...beforeDocBlock, ...newDocLines, ...declarationAndAfter].join("\n");
}

/**
 * Updates the source file with the new doc comment.
 */
function updateSourceFile(filePath, functionName, exampleCode, exampleOutput, prose) {
  const content = readFileSync(filePath, "utf-8");
  const newContent = updateSourceContent(
    content,
    functionName,
    exampleCode,
    exampleOutput,
    prose
  );

  if (newContent === null) {
    console.warn(`Warning: Could not find function ${functionName} in ${filePath}`);
    return false;
  }

  writeFileSync(filePath, newContent, "utf-8");
  return true;
}

/**
 * Generates Examples.Docs.Main from discovered example functions.
 * @returns Array of all { qualifiedName, code, prose, docsModuleName, exampleFnName }
 */
function generateMainModule(docFiles) {
  const allExamples = [];

  for (const fileName of docFiles) {
    const docFilePath = join(DOCS_DIR, fileName);
    const docsModuleName = fileName.replace(/\.purs$/, "").replaceAll("/", "."); // e.g. "Duration", "Duration.Compat"
    const examples = extractExamples(docFilePath);

    for (const example of examples) {
      const { filePath, functionName } = qualifiedNameToPath(example.qualifiedName);
      const exampleFnName = "example" + functionName.charAt(0).toUpperCase() + functionName.slice(1);
      allExamples.push({
        ...example,
        docsModuleName,
        exampleFnName,
      });
    }
  }

  // Group by module for imports
  const moduleGroups = new Map();
  for (const ex of allExamples) {
    if (!moduleGroups.has(ex.docsModuleName)) {
      moduleGroups.set(ex.docsModuleName, []);
    }
    moduleGroups.get(ex.docsModuleName).push(ex);
  }

  const sortedModuleNames = [...moduleGroups.keys()].sort();

  const importLines = sortedModuleNames.map(
    (mod) => `import Examples.Docs.${mod} as ${mod}`
  );

  const runExampleLines = [];
  for (const mod of sortedModuleNames) {
    const examples = moduleGroups.get(mod);
    for (const ex of examples) {
      runExampleLines.push(
        `  runExample ${JSON.stringify(ex.qualifiedName)} ${mod}.${ex.exampleFnName}`
      );
    }
  }

  const mainContent = [
    "-- | Runs all doc examples in a stable order, emitting machine-parsable markers",
    "-- | around each example's output for the sync script to capture.",
    "-- |",
    "-- | Run with: spago run -p js-temporal-examples -m Examples.Docs.Main",
    "-- | The sync script invokes this and parses stdout for --- OUTPUT <qualifiedName> --- ... --- /OUTPUT ---",
    "-- |",
    "-- | THIS FILE IS AUTO-GENERATED by sync-doc-examples.mjs. Do not edit manually.",
    "module Examples.Docs.Main where",
    "",
    "import Prelude",
    "",
    "import Data.Either (Either(..))",
    "import Effect (Effect)",
    "import Effect.Class.Console as Console",
    "import Effect.Exception as Effect.Exception",
    ...importLines,
    "",
    "runExample :: String -> Effect Unit -> Effect Unit",
    "runExample qualifiedName eff = do",
    '  Console.log (\"--- OUTPUT \" <> qualifiedName <> \" ---\")',
    "  result <- Effect.Exception.try eff",
    "  case result of",
    "    Left error ->",
    '      Console.log (\"[[EXAMPLE ERROR]] \" <> Effect.Exception.message error)',
    "    Right _ ->",
    "      pure unit",
    '  Console.log \"--- /OUTPUT ---\"',
    "",
    "main :: Effect Unit",
    "main = do",
    ...runExampleLines,
    "",
  ].join("\n");

  const mainPath = join(DOCS_DIR, "Main.purs");
  writeFileSync(mainPath, mainContent, "utf-8");
  console.log(`Generated ${mainPath} (${allExamples.length} examples)`);

  return allExamples;
}

function main() {
  const docFiles = readdirSync(DOCS_DIR, { recursive: true })
    .filter((fileName) => fileName.endsWith(".purs") && fileName !== "Main.purs");

  // Step 1: Generate Main.purs from discovered examples
  const allExamples = generateMainModule(docFiles);

  // Step 2: Run the examples to capture output
  const outputMap = runDocsRunnerAndParseOutput();

  // Step 3: Sync doc comments into source files
  let syncedCount = 0;
  for (const { qualifiedName, code, prose } of allExamples) {
    const { filePath, functionName } = qualifiedNameToPath(qualifiedName);
    const output = outputMap.get(qualifiedName) ?? null;
    try {
      const didUpdate = updateSourceFile(filePath, functionName, code, output, prose);
      if (didUpdate) {
        console.log(`Synced ${qualifiedName} -> ${filePath}${output ? " (with output)" : ""}`);
        syncedCount++;
      }
    } catch (err) {
      console.error(`Error syncing ${qualifiedName}:`, err.message);
    }
  }

  console.log(`Done. Synced ${syncedCount} example(s).`);
}

const isMainModule =
  process.argv[1] != null &&
  pathToFileURL(process.argv[1]).href === import.meta.url;

if (isMainModule) {
  main();
}

export {
  findFunctionDocBlock,
  formatExampleBlocks,
  replaceManagedExampleRegion,
  updateSourceContent,
};
