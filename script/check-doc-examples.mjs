#!/usr/bin/env node
/**
 * Checks that every lowercase function exported from JS.Temporal.<Foo>
 * has a corresponding example<Bar> function in Examples.Docs.<Foo>,
 * and vice-versa (no orphan examples).
 *
 * Convention:
 *   export "bar"       → exampleBar
 *   export "fooBar"    → exampleFooBar
 *   export "fromString"→ exampleFromString
 *
 * Skips:
 *   - Uppercase exports (types, classes, module re-exports)
 *   - Internal.purs and Options/ modules
 *
 * Exit code 0 = all good, 1 = violations found.
 */

import { readFileSync, readdirSync } from "fs";
import { join } from "path";

const ROOT = new URL("..", import.meta.url).pathname;
const SRC_DIR = join(ROOT, "src", "JS", "Temporal");
const DOCS_DIR = join(ROOT, "examples", "src", "Examples", "Docs");

/**
 * Parse the module export list from a PureScript source file.
 * Returns only lowercase-starting identifiers (functions/values).
 */
export function parseExports(content) {
  // Extract the text between "module <Name> (" and ") where"
  // Handle multi-line export lists
  const moduleMatch = content.match(
    /^module\s+\S+\s*\(\s*([\s\S]*?)\)\s*where/m
  );
  if (!moduleMatch) {
    return [];
  }

  const exportBlock = moduleMatch[1];
  const exports = [];

  // Match each exported identifier, skipping:
  // - "module X" re-exports
  // - comment lines (-- ...)
  // - uppercase-starting names (types/classes)
  // - record field labels inside { ... } (e.g. option record types)
  //
  // We need to be careful about record syntax in type exports like:
  //   , DurationRoundOptions
  //   , ToDurationRoundOptions
  // and also things like:
  //   , smallestUnit :: String
  // which are record fields inside a type export's (..) or { }

  // Strategy: walk line by line, track brace depth to skip record fields
  const lines = exportBlock.split("\n");
  let braceDepth = 0;

  for (const line of lines) {
    // Update brace depth
    for (const ch of line) {
      if (ch === "{" || ch === "(") braceDepth++;
      if (ch === "}" || ch === ")") braceDepth--;
    }

    // Skip if inside braces (record fields, type constructor lists)
    if (braceDepth > 0) continue;

    // Skip comment-only lines
    const trimmed = line.replace(/--.*$/, "").trim();
    if (!trimmed) continue;

    // Skip "module ..." re-exports
    if (/\bmodule\b/.test(trimmed)) continue;

    // Extract identifiers: after a comma or at start, possibly with "class" or "type" keyword
    // We want bare identifiers that start lowercase
    const identMatch = trimmed.match(/^,?\s*([a-z][a-zA-Z0-9_']*)/);
    if (identMatch) {
      exports.push(identMatch[1]);
    }
  }

  return [...new Set(exports)];
}

/**
 * Parse example function names from an Examples.Docs.<Foo> module.
 * Looks for top-level declarations matching /^example[A-Z]/.
 */
export function parseExampleFunctions(content) {
  const examples = [];
  const seen = new Set();

  for (const line of content.split("\n")) {
    const match = line.match(/^(example[A-Za-z0-9_']*)\s*/);
    if (match && !seen.has(match[1])) {
      seen.add(match[1]);
      examples.push(match[1]);
    }
  }

  return examples;
}

/**
 * Convert an export name to the expected example function name.
 * "bar" → "exampleBar", "fooBar" → "exampleFooBar"
 */
export function exportToExampleName(exportName) {
  return "example" + exportName.charAt(0).toUpperCase() + exportName.slice(1);
}

/**
 * Convert an example function name back to the export name.
 * "exampleBar" → "bar", "exampleFooBar" → "fooBar"
 */
export function exampleNameToExport(exampleName) {
  const withoutPrefix = exampleName.slice("example".length);
  return withoutPrefix.charAt(0).toLowerCase() + withoutPrefix.slice(1);
}

/**
 * Find all module pairs: { name, srcPath, docsPath }
 */
function discoverModulePairs() {
  const srcFiles = readdirSync(SRC_DIR, { recursive: true })
    .filter((f) => f.endsWith(".purs"))
    .filter((f) => !f.includes("Internal"))
    .filter((f) => !f.startsWith("Options"));

  const docsFiles = new Set(
    readdirSync(DOCS_DIR, { recursive: true }).filter((f) => f.endsWith(".purs"))
  );

  const pairs = [];
  for (const srcFile of srcFiles) {
    const name = srcFile.replace(/\.purs$/, "").replaceAll("/", ".");
    const docsFile = srcFile;
    if (docsFiles.has(docsFile)) {
      pairs.push({
        name,
        qualifiedModule: `JS.Temporal.${name}`,
        srcPath: join(SRC_DIR, srcFile),
        docsPath: join(DOCS_DIR, docsFile),
      });
    }
  }

  return pairs;
}

function main() {
  const pairs = discoverModulePairs();
  let totalMissing = 0;
  let totalOrphans = 0;

  for (const { name, qualifiedModule, srcPath, docsPath } of pairs) {
    const srcContent = readFileSync(srcPath, "utf-8");
    const docsContent = readFileSync(docsPath, "utf-8");

    const exports = parseExports(srcContent);
    const exampleFns = parseExampleFunctions(docsContent);

    const exampleSet = new Set(exampleFns);
    const exportSet = new Set(exports);

    // Check completeness: every export should have an example
    const missing = exports.filter((e) => !exampleSet.has(exportToExampleName(e)));

    // Check no orphans: every example should map to an export
    const orphans = exampleFns.filter((e) => !exportSet.has(exampleNameToExport(e)));

    if (missing.length > 0) {
      console.log(`\n${qualifiedModule} — missing examples:`);
      for (const m of missing) {
        console.log(`  ${exportToExampleName(m)}  (for export: ${m})`);
      }
      totalMissing += missing.length;
    }

    if (orphans.length > 0) {
      console.log(`\n${qualifiedModule} — orphan examples (no matching export):`);
      for (const o of orphans) {
        console.log(`  ${o}  (would map to: ${exampleNameToExport(o)})`);
      }
      totalOrphans += orphans.length;
    }

    if (missing.length === 0 && orphans.length === 0) {
      console.log(`${qualifiedModule} — ✓ (${exports.length} exports, ${exampleFns.length} examples)`);
    }
  }

  console.log(`\n---`);
  console.log(`Total: ${totalMissing} missing, ${totalOrphans} orphans`);

  if (totalMissing > 0 || totalOrphans > 0) {
    process.exit(1);
  }

  console.log("All checks passed.");
}

main();
