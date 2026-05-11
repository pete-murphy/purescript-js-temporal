-- | Property-based tests for the rename function.
module Test.Properties where

import Prelude

import Effect (Effect)
import Effect.Console as Console
import Test.QuickCheck (Result, quickCheck, (<?>))
import Test.QuickCheck.Gen (Gen)
import Test.QuickCheck.Gen as Gen

import Data.Array as Array
import Data.Array.NonEmpty as NEA
import Data.Maybe (Maybe(..))
import Data.String.CodeUnits as SCU
import Rename (RenameEntry, renamePurs)

run :: Effect Unit
run = do
  Console.log "=== Property Tests ==="

  Console.log "prop_emptyRenamesIsIdentity"
  quickCheck prop_emptyRenamesIsIdentity

  Console.log "prop_idempotent"
  quickCheck prop_idempotent

  Console.log "prop_parseSurvives"
  quickCheck prop_parseSurvives

-- | Renaming with an empty rename list is identity.
prop_emptyRenamesIsIdentity :: Gen Result
prop_emptyRenamesIsIdentity = do
  body <- genSimpleBody
  let
    input = wrapModule body
    result = renamePurs [] input
  pure (result == input <?> "Expected identity but got: " <> result)

-- | Applying the same rename twice gives the same result as once (idempotent).
-- | This holds when no rename entry's `new` value is another entry's `old` value
-- | (i.e., non-chaining renames).
prop_idempotent :: Gen Result
prop_idempotent = do
  { renames, body } <- genNonChainingScenario
  let
    input = wrapModule body
    once = renamePurs renames input
    twice = renamePurs renames once
  pure (once == twice <?> "Not idempotent.\nOnce:  " <> once <> "\nTwice: " <> twice)

-- | The result of renamePurs should still be valid PureScript (parseable).
-- | We test this indirectly: renamePurs with empty renames should return
-- | input unchanged (which we know parses since we constructed it).
prop_parseSurvives :: Gen Result
prop_parseSurvives = do
  { renames, body } <- genNonChainingScenario
  let
    input = wrapModule body
    result = renamePurs renames input
    -- Roundtrip: parse the result and re-print with empty renames
    reparsed = renamePurs [] result
  pure (result == reparsed <?> "Reparse changed output.\nResult:   " <> result <> "\nReparsed: " <> reparsed)

-- Generators

genIdent :: Gen String
genIdent = do
  first <- Gen.elements (NEA.cons' 'a' ['b', 'c', 'd', 'e', 'f'])
  rest <- Gen.arrayOf (Gen.elements (NEA.cons' 'a' ['b', 'c', '1', '2']))
  pure (SCU.singleton first <> SCU.fromCharArray rest)

genSimpleBody :: Gen String
genSimpleBody = do
  n <- Gen.chooseInt 1 4
  lines <- Gen.vectorOf n genBinding
  pure (Array.intercalate "\n" lines <> "\n")

genBinding :: Gen String
genBinding = do
  name <- genIdent
  val <- Gen.chooseInt 0 100
  pure (name <> " = " <> show val)

-- | Generate a scenario where no new name equals any old name,
-- | so applying the rename twice is idempotent.
genNonChainingScenario :: Gen { renames :: Array RenameEntry, body :: String }
genNonChainingScenario = do
  n <- Gen.chooseInt 0 3
  pairs <- Gen.vectorOf n do
    base <- genIdent
    suffix <- Gen.elements (NEA.cons' "X" ["Y", "Z", "W"])
    pure { old: base, new: base <> suffix }
  -- Generate a body that uses some of the old names
  bindings <- Gen.vectorOf (n + 1) do
    name <- genIdent
    -- Sometimes use an old name on the RHS
    useOld <- (\x -> x < 0.5) <$> Gen.uniform
    rhs <-
      if useOld && not (Array.null pairs) then do
        idx <- Gen.chooseInt 0 (Array.length pairs - 1)
        case Array.index pairs idx of
          Just p -> pure p.old
          Nothing -> pure (show 42)
      else
        pure (show 42)
    pure (name <> " = " <> rhs)
  let body = Array.intercalate "\n" bindings <> "\n"
  pure { renames: pairs, body }

wrapModule :: String -> String
wrapModule body = "module Test where\n\n" <> body
