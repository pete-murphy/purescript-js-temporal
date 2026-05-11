-- | Unit tests for the rename tool.
module Test.Unit where

import Prelude

import Effect (Effect)
import Effect.Console as Console
import Rename (renamePurs, renameJs)

assert :: String -> Boolean -> Effect Unit
assert label b
  | b = Console.log ("  ✓ " <> label)
  | otherwise = do
      Console.log ("  ✗ " <> label)
      unsafeCrashWith ("Assertion failed: " <> label)

foreign import unsafeCrashWith :: String -> Effect Unit

run :: Effect Unit
run = do
  Console.log "=== Unit Tests ==="
  testIdentifierRename
  testSwapRename
  testStringLiteralRename
  testCommentRename
  testQualifiedIdentifierRename
  testExportListRename
  testForeignImportRename
  testNoFalsePositives
  testDocCommentRename
  testTypeSignatureRename
  testMultipleRenames
  testRenameJs
  testDerivedNameRename
  testStringSwapRename
  testTrailingComments
  testRealisticPurs
  testRealisticJs
  testWordBoundary
  testInternalNamesUntouched

-- | Simple identifier rename: foo_ -> foo
testIdentifierRename :: Effect Unit
testIdentifierRename = do
  Console.log "testIdentifierRename"
  let
    renames = [ { old: "foo_", new: "foo" } ]
    input = "module Test where\n\nbar = foo_ 42\n"
    expected = "module Test where\n\nbar = foo 42\n"
    result = renamePurs renames input
  assert "foo_ -> foo in expression" (result == expected)

-- | Simultaneous swap: foo_ -> foo AND foo -> fooWithOptions
testSwapRename :: Effect Unit
testSwapRename = do
  Console.log "testSwapRename"
  let
    renames =
      [ { old: "foo_", new: "foo" }
      , { old: "foo", new: "fooWithOptions" }
      ]
    input = "module Test where\n\nx = foo_ 1\ny = foo opts 1\n"
    expected = "module Test where\n\nx = foo 1\ny = fooWithOptions opts 1\n"
    result = renamePurs renames input
  assert "simultaneous swap" (result == expected)

-- | String literal rename
testStringLiteralRename :: Effect Unit
testStringLiteralRename = do
  Console.log "testStringLiteralRename"
  let
    renames = [ { old: "foo_", new: "foo" } ]
    input = "module Test where\n\nx = \"something.foo_\"\n"
    expected = "module Test where\n\nx = \"something.foo\"\n"
    result = renamePurs renames input
  assert "rename inside string literal" (result == expected)

-- | Comment rename
testCommentRename :: Effect Unit
testCommentRename = do
  Console.log "testCommentRename"
  let
    renames = [ { old: "foo_", new: "foo" } ]
    input = "module Test where\n\n-- [EXAMPLE Mod.foo_]\nx = 1\n-- [/EXAMPLE]\n"
    expected = "module Test where\n\n-- [EXAMPLE Mod.foo]\nx = 1\n-- [/EXAMPLE]\n"
    result = renamePurs renames input
  assert "rename inside comment" (result == expected)

-- | Qualified identifier rename
testQualifiedIdentifierRename :: Effect Unit
testQualifiedIdentifierRename = do
  Console.log "testQualifiedIdentifierRename"
  let
    renames = [ { old: "foo_", new: "foo" } ]
    input = "module Test where\n\nx = Mod.foo_ 42\n"
    expected = "module Test where\n\nx = Mod.foo 42\n"
    result = renamePurs renames input
  assert "qualified foo_ -> foo" (result == expected)

-- | Export list rename
testExportListRename :: Effect Unit
testExportListRename = do
  Console.log "testExportListRename"
  let
    renames =
      [ { old: "foo_", new: "foo" }
      , { old: "foo", new: "fooWithOptions" }
      ]
    input = "module Test\n  ( foo_\n  , foo\n  ) where\n\nfoo_ = 1\nfoo = 2\n"
    expected = "module Test\n  ( foo\n  , fooWithOptions\n  ) where\n\nfoo = 1\nfooWithOptions = 2\n"
    result = renamePurs renames input
  assert "export list rename" (result == expected)

-- | Foreign import rename
testForeignImportRename :: Effect Unit
testForeignImportRename = do
  Console.log "testForeignImportRename"
  let
    renames = [ { old: "toString_", new: "toString" } ]
    input = "module Test where\n\nforeign import toString_ :: Foo -> String\n"
    expected = "module Test where\n\nforeign import toString :: Foo -> String\n"
    result = renamePurs renames input
  assert "foreign import rename" (result == expected)

-- | Don't rename things that aren't in the map
testNoFalsePositives :: Effect Unit
testNoFalsePositives = do
  Console.log "testNoFalsePositives"
  let
    renames = [ { old: "foo_", new: "foo" } ]
    input = "module Test where\n\nx = bar_ 42\ny = baz 1\n"
    result = renamePurs renames input
  assert "no false positives" (result == input)

-- | Doc comment with function reference
testDocCommentRename :: Effect Unit
testDocCommentRename = do
  Console.log "testDocCommentRename"
  let
    renames = [ { old: "toString_", new: "toString" } ]
    input = "module Test where\n\n-- | Same as [`toString`](#tostring) with default options.\ntoString_ :: Foo -> String\ntoString_ = bar\n"
    expected = "module Test where\n\n-- | Same as [`toString`](#tostring) with default options.\ntoString :: Foo -> String\ntoString = bar\n"
    result = renamePurs renames input
  assert "doc comment preserved, identifier renamed" (result == expected)

-- | Type signature with rename
testTypeSignatureRename :: Effect Unit
testTypeSignatureRename = do
  Console.log "testTypeSignatureRename"
  let
    renames =
      [ { old: "until_", new: "until" }
      , { old: "until", new: "untilWithOptions" }
      ]
    input = "module Test\n  ( until_\n  , until\n  ) where\n\nuntil_ :: A -> A -> Effect B\nuntil_ = runEffectFn2 _untilNoOpts\n\nuntil :: Options -> A -> A -> Effect B\nuntil opts a b = runEffectFn3 _until opts a b\n"
    expected = "module Test\n  ( until\n  , untilWithOptions\n  ) where\n\nuntil :: A -> A -> Effect B\nuntil = runEffectFn2 _untilNoOpts\n\nuntilWithOptions :: Options -> A -> A -> Effect B\nuntilWithOptions opts a b = runEffectFn3 _until opts a b\n"
    result = renamePurs renames input
  assert "type sig + export list swap" (result == expected)

-- | Multiple renames in one pass
testMultipleRenames :: Effect Unit
testMultipleRenames = do
  Console.log "testMultipleRenames"
  let
    renames =
      [ { old: "add_", new: "add" }
      , { old: "add", new: "addWithOptions" }
      , { old: "subtract_", new: "subtract" }
      , { old: "subtract", new: "subtractWithOptions" }
      ]
    input = "module Test where\n\nx = add_ dur pd\ny = add opts dur pd\nz = subtract_ dur pd\nw = subtract opts dur pd\n"
    expected = "module Test where\n\nx = add dur pd\ny = addWithOptions opts dur pd\nz = subtract dur pd\nw = subtractWithOptions opts dur pd\n"
    result = renamePurs renames input
  assert "multiple renames" (result == expected)

-- | JS FFI file rename
testRenameJs :: Effect Unit
testRenameJs = do
  Console.log "testRenameJs"
  let
    renames =
      [ { old: "toString_", new: "toString" }
      , { old: "_untilNoOpts", new: "_until" }
      , { old: "_until", new: "_untilWithOptions" }
      ]
    input = "export const toString_ = (d) => d.toString();\nexport function _untilNoOpts(other, x) { return x.until(other); }\nexport function _until(opts, other, x) { return x.until(other, opts); }\n"
    expected = "export const toString = (d) => d.toString();\nexport function _until(other, x) { return x.until(other); }\nexport function _untilWithOptions(opts, other, x) { return x.until(other, opts); }\n"
    result = renameJs renames input
  assert "JS FFI rename" (result == expected)

-- | Derived names like exampleFoo_ -> exampleFoo
testDerivedNameRename :: Effect Unit
testDerivedNameRename = do
  Console.log "testDerivedNameRename"
  let
    renames =
      [ { old: "exampleFoo_", new: "exampleFoo" }
      , { old: "exampleFoo", new: "exampleFooWithOptions" }
      , { old: "foo_", new: "foo" }
      , { old: "foo", new: "fooWithOptions" }
      ]
    input = "module Test where\n\nexampleFoo_ = Mod.foo_ 1\nexampleFoo = Mod.foo opts 1\n"
    expected = "module Test where\n\nexampleFoo = Mod.foo 1\nexampleFooWithOptions = Mod.fooWithOptions opts 1\n"
    result = renamePurs renames input
  assert "derived name rename" (result == expected)

-- | String literal swap must be simultaneous too
testStringSwapRename :: Effect Unit
testStringSwapRename = do
  Console.log "testStringSwapRename"
  let
    renames =
      [ { old: "until_", new: "until" }
      , { old: "until", new: "untilWithOptions" }
      ]
    input = "module Test where\n\nx = runExample \"Mod.until_\" until_\ny = runExample \"Mod.until\" until\n"
    expected = "module Test where\n\nx = runExample \"Mod.until\" until\ny = runExample \"Mod.untilWithOptions\" untilWithOptions\n"
    result = renamePurs renames input
  assert "string literal swap simultaneous" (result == expected)

-- | Trailing module comments are preserved
testTrailingComments :: Effect Unit
testTrailingComments = do
  Console.log "testTrailingComments"
  let
    renames = [ { old: "foo_", new: "foo" } ]
    input = "module Test where\n\nfoo_ = 1\n-- trailing comment\n"
    expected = "module Test where\n\nfoo = 1\n-- trailing comment\n"
    result = renamePurs renames input
  assert "trailing comments preserved" (result == expected)

-- | Realistic PureScript snippet
testRealisticPurs :: Effect Unit
testRealisticPurs = do
  Console.log "testRealisticPurs"
  let
    renames =
      [ { old: "until_", new: "until" }
      , { old: "until", new: "untilWithOptions" }
      ]
    input = "module JS.Temporal.Instant\n  ( until_\n  , until\n  ) where\n\n-- | Same as [`until`](#until) with default options.\nuntil_ :: Instant -> Instant -> Effect Duration\nuntil_ = Effect.Uncurried.runEffectFn2 _untilNoOpts\n\nuntil\n  :: forall provided\n   . ConvertOptionsWithDefaults\n       ToDifferenceOptions\n       { | DifferenceOptions }\n       { | provided }\n       { | DifferenceOptions }\n  => { | provided }\n  -> Instant\n  -> Instant\n  -> Effect Duration\nuntil providedOptions other instant =\n  Effect.Uncurried.runEffectFn3\n    _until\n    other\n    instant\n"
    expected = "module JS.Temporal.Instant\n  ( until\n  , untilWithOptions\n  ) where\n\n-- | Same as [`untilWithOptions`](#untilWithOptions) with default options.\nuntil :: Instant -> Instant -> Effect Duration\nuntil = Effect.Uncurried.runEffectFn2 _untilNoOpts\n\nuntilWithOptions\n  :: forall provided\n   . ConvertOptionsWithDefaults\n       ToDifferenceOptions\n       { | DifferenceOptions }\n       { | provided }\n       { | DifferenceOptions }\n  => { | provided }\n  -> Instant\n  -> Instant\n  -> Effect Duration\nuntilWithOptions providedOptions other instant =\n  Effect.Uncurried.runEffectFn3\n    _until\n    other\n    instant\n"
    result = renamePurs renames input
  assert "realistic purs rename" (result == expected)

-- | Realistic JS FFI snippet
testRealisticJs :: Effect Unit
testRealisticJs = do
  Console.log "testRealisticJs"
  let
    renames =
      [ { old: "_untilNoOpts", new: "_until" }
      , { old: "_until", new: "_untilWithOptions" }
      ]
    input = "export function _untilNoOpts(other, x) {\n  return x.until(other);\n}\n\nexport function _until(opts, other, x) {\n  return x.until(other, opts);\n}\n"
    expected = "export function _until(other, x) {\n  return x.until(other);\n}\n\nexport function _untilWithOptions(opts, other, x) {\n  return x.until(other, opts);\n}\n"
    result = renameJs renames input
  assert "realistic js rename" (result == expected)

-- | Word boundary: don't rename partial matches
testWordBoundary :: Effect Unit
testWordBoundary = do
  Console.log "testWordBoundary"
  let
    renames = [ { old: "add_", new: "add" } ]
    -- "added" should NOT be touched even though it starts with "add"
    input = "module Test where\n\nx = add_ dur pd\ny = added 1\n"
    expected = "module Test where\n\nx = add dur pd\ny = added 1\n"
    result = renamePurs renames input
  assert "word boundary respected" (result == expected)

-- | Internal FFI bindings (_until, _untilNoOpts) left alone unless in rename map
testInternalNamesUntouched :: Effect Unit
testInternalNamesUntouched = do
  Console.log "testInternalNamesUntouched"
  let
    renames =
      [ { old: "until_", new: "until" }
      , { old: "until", new: "untilWithOptions" }
      ]
    input = "module Test where\n\nforeign import _untilNoOpts :: EffectFn2 A A B\nforeign import _until :: forall r. EffectFn3 { | r } A A B\n\nuntil_ = runEffectFn2 _untilNoOpts\nuntil opts = runEffectFn3 _until opts\n"
    expected = "module Test where\n\nforeign import _untilNoOpts :: EffectFn2 A A B\nforeign import _until :: forall r. EffectFn3 { | r } A A B\n\nuntil = runEffectFn2 _untilNoOpts\nuntilWithOptions opts = runEffectFn3 _until opts\n"
    result = renamePurs renames input
  assert "internal _names untouched" (result == expected)
