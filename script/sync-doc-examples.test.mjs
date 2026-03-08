import assert from "node:assert/strict";

import { updateSourceContent } from "./sync-doc-examples.mjs";

function testReplacesDuplicateManagedBlocksAndPreservesProse() {
  const originalContent = [
    "module Example where",
    "",
    "-- | Computes something useful.",
    "-- |",
    "-- | ```purescript",
    "-- | oldExample <- pure unit",
    "-- | ```",
    "-- |",
    "-- | Options: alpha, beta.",
    "-- |",
    "-- | ```text",
    "-- | stale output",
    "-- | ```",
    "-- |",
    "-- | ```purescript",
    "-- | duplicatedExample <- pure unit",
    "-- | ```",
    "",
    "example",
    "  :: Effect Unit",
    "example = pure unit",
    "",
  ].join("\n");

  const updatedContent = updateSourceContent(
    originalContent,
    "example",
    'freshExample <- log "hello"',
    "hello"
  );

  const expectedContent = [
    "module Example where",
    "",
    "-- | Computes something useful.",
    "-- |",
    "-- | ```purescript",
    '-- | freshExample <- log "hello"',
    "-- | ```",
    "-- |",
    "-- | ```text",
    "-- | hello",
    "-- | ```",
    "-- |",
    "-- | Options: alpha, beta.",
    "-- |",
    "",
    "example",
    "  :: Effect Unit",
    "example = pure unit",
    "",
  ].join("\n");

  assert.equal(updatedContent, expectedContent);
}

function testAppendsExampleToExistingDocWithoutManagedRegion() {
  const originalContent = [
    "module Example where",
    "",
    "-- | Parses input.",
    "-- |",
    "-- | Throws on invalid values.",
    "",
    "fromValue :: String -> Effect Unit",
    "fromValue _ = pure unit",
    "",
  ].join("\n");

  const updatedContent = updateSourceContent(
    originalContent,
    "fromValue",
    'parsed <- pure "ok"',
    null
  );

  const expectedContent = [
    "module Example where",
    "",
    "-- | Parses input.",
    "-- |",
    "-- | Throws on invalid values.",
    "-- |",
    "-- | ```purescript",
    '-- | parsed <- pure "ok"',
    "-- | ```",
    "",
    "fromValue :: String -> Effect Unit",
    "fromValue _ = pure unit",
    "",
  ].join("\n");

  assert.equal(updatedContent, expectedContent);
}

function testInsertsDocCommentWhenNoDocBlockExists() {
  const originalContent = [
    "module Example where",
    "",
    "withoutDocs :: Effect Unit",
    "withoutDocs = pure unit",
    "",
  ].join("\n");

  const updatedContent = updateSourceContent(
    originalContent,
    "withoutDocs",
    "pure unit",
    null
  );

  const expectedContent = [
    "module Example where",
    "",
    "-- | ```purescript",
    "-- | pure unit",
    "-- | ```",
    "",
    "withoutDocs :: Effect Unit",
    "withoutDocs = pure unit",
    "",
  ].join("\n");

  assert.equal(updatedContent, expectedContent);
}

function testSupportsForeignImportDeclarations() {
  const originalContent = [
    "module Example where",
    "",
    'foreign import instant :: Effect Instant',
    "",
  ].join("\n");

  const updatedContent = updateSourceContent(
    originalContent,
    "instant",
    "now <- Now.instant",
    "March 8, 2026 at 4:22:02 AM"
  );

  const expectedContent = [
    "module Example where",
    "",
    "-- | ```purescript",
    "-- | now <- Now.instant",
    "-- | ```",
    "-- |",
    "-- | ```text",
    "-- | March 8, 2026 at 4:22:02 AM",
    "-- | ```",
    "",
    'foreign import instant :: Effect Instant',
    "",
  ].join("\n");

  assert.equal(updatedContent, expectedContent);
}

function testSecondRunIsIdempotent() {
  const originalContent = [
    "module Example where",
    "",
    "-- | Description.",
    "-- |",
    "-- | ```purescript",
    "-- | old <- pure unit",
    "-- | ```",
    "-- |",
    "-- | ```purescript",
    "-- | duplicated <- pure unit",
    "-- | ```",
    "",
    "thing :: Effect Unit",
    "thing = pure unit",
    "",
  ].join("\n");

  const firstPassContent = updateSourceContent(
    originalContent,
    "thing",
    'fresh <- log "ok"',
    "ok"
  );

  const secondPassContent = updateSourceContent(
    firstPassContent,
    "thing",
    'fresh <- log "ok"',
    "ok"
  );

  assert.equal(firstPassContent, secondPassContent);
}

function runTests() {
  testReplacesDuplicateManagedBlocksAndPreservesProse();
  testAppendsExampleToExistingDocWithoutManagedRegion();
  testInsertsDocCommentWhenNoDocBlockExists();
  testSupportsForeignImportDeclarations();
  testSecondRunIsIdempotent();
  console.log("sync-doc-examples tests passed");
}

runTests();
