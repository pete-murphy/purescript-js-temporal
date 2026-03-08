#!/usr/bin/env node
/**
 * Syncs compilable doc examples from examples/src/Examples/Docs/*.purs
 * into the -- | doc comments of src/JS/Temporal/*.purs.
 *
 * Examples are delimited by:
 *   -- [EXAMPLE Qualified.Module.Name.functionName]
 *   ... code ...
 *   -- [/EXAMPLE]
 *
 * Runs Examples.Docs.Main to capture stdout, then injects both code and
 * output blocks into source docs. Requires Temporal (e.g. nix develop).
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

/**
 * Runs Examples.Docs.Main and parses stdout for --- OUTPUT <qualifiedName> --- ... --- /OUTPUT ---
 * @returns Map<qualifiedName, outputText>
 */
function runDocsRunnerAndParseOutput() {
  const outputMap = new Map();
  try {
    const stdout = execSync(
      "spago run -p js-temporal-examples -m Examples.Docs.Main 2>/dev/null",
      { encoding: "utf-8", cwd: ROOT }
    );
    const outputRegex = /--- OUTPUT (.+?) ---\n([\s\S]*?)\n--- \/OUTPUT ---/g;
    let m;
    while ((m = outputRegex.exec(stdout)) !== null) {
      outputMap.set(m[1].trim(), m[2].trimEnd());
    }
  } catch (err) {
    console.warn(
      "Warning: Docs runner failed (Temporal required, try nix develop). Output blocks will be omitted."
    );
  }
  return outputMap;
}

/**
 * Extracts all [EXAMPLE ...] blocks from a file.
 * @returns Array of { qualifiedName: string, code: string }
 */
function extractExamples(filePath) {
  const content = readFileSync(filePath, "utf-8");
  const lines = content.split("\n");
  const examples = [];

  for (let i = 0; i < lines.length; i++) {
    const startMatch = lines[i].match(/^\s*--\s*\[EXAMPLE\s+(.+?)\]\s*$/);
    if (startMatch) {
      const qualifiedName = startMatch[1].trim();
      const startLine = i + 1;
      let endLine = -1;

      for (let j = i + 1; j < lines.length; j++) {
        if (lines[j].match(/^\s*--\s*\[\/EXAMPLE\]\s*$/)) {
          endLine = j;
          break;
        }
      }

      if (endLine === -1) {
        console.warn(`Warning: No [/EXAMPLE] found for ${qualifiedName} in ${filePath}`);
        continue;
      }

      const codeLines = lines.slice(startLine, endLine);
      const code = dedent(codeLines.join("\n"));
      examples.push({ qualifiedName, code });
    }
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
  return codeBlock + "\n-- |\n" + outputBlock;
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

  for (let lineIndex = 0; lineIndex < lines.length; lineIndex++) {
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
 */
function updateSourceContent(content, functionName, exampleCode, exampleOutput) {
  const lines = splitLines(content);
  const block = findFunctionDocBlock(lines, functionName);
  if (!block) {
    return null;
  }

  let newDocLines;
  if (block.hasDoc) {
    newDocLines = replaceManagedExampleRegion(
      block.docLines,
      exampleCode,
      exampleOutput
    );
  } else {
    newDocLines = formatExampleBlocks(exampleCode, exampleOutput).split("\n");
  }

  const beforeDocBlock = lines.slice(0, block.docStartIndex);
  const declarationAndAfter = lines.slice(block.functionLineIndex);

  return [...beforeDocBlock, ...newDocLines, "", ...declarationAndAfter].join("\n");
}

/**
 * Updates the source file with the new doc comment.
 */
function updateSourceFile(filePath, functionName, exampleCode, exampleOutput) {
  const content = readFileSync(filePath, "utf-8");
  const newContent = updateSourceContent(
    content,
    functionName,
    exampleCode,
    exampleOutput
  );

  if (newContent === null) {
    console.warn(`Warning: Could not find function ${functionName} in ${filePath}`);
    return false;
  }

  writeFileSync(filePath, newContent, "utf-8");
  return true;
}

function main() {
  const outputMap = runDocsRunnerAndParseOutput();
  const docFiles = readdirSync(DOCS_DIR).filter((fileName) => fileName.endsWith(".purs"));
  let syncedCount = 0;

  for (const fileName of docFiles) {
    const docFilePath = join(DOCS_DIR, fileName);
    const examples = extractExamples(docFilePath);

    for (const { qualifiedName, code } of examples) {
      const { filePath, functionName } = qualifiedNameToPath(qualifiedName);
      const output = outputMap.get(qualifiedName) ?? null;
      try {
        const didUpdate = updateSourceFile(filePath, functionName, code, output);
        if (didUpdate) {
          console.log(`Synced ${qualifiedName} -> ${filePath}${output ? " (with output)" : ""}`);
          syncedCount++;
        }
      } catch (err) {
        console.error(`Error syncing ${qualifiedName}:`, err.message);
      }
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
