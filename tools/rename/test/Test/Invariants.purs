-- | Codebase invariant checks.
-- | These verify structural properties of the js-temporal source files.
module Test.Invariants where

import Prelude

import Data.Array as Array
import Data.Array.NonEmpty as NEA
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.Foldable (for_)
import Effect.Ref as Ref
import Data.String as String
import Data.String.CodeUnits as SCU
import Data.String.Regex as Regex
import Data.String.Regex.Flags as RegexFlags
import Effect (Effect)
import Effect.Console as Console
import Node.Encoding (Encoding(..))
import Node.FS.Sync as FS

run :: Effect Unit
run = do
  Console.log "=== Codebase Invariant Checks ==="
  failures <- collectFailures
  when (failures > 0) do
    Console.log ("\n  " <> show failures <> " invariant violation(s) found.")
    unsafeCrashWith (show failures <> " invariant violation(s)")

collectFailures :: Effect Int
collectFailures = do
  n1 <- checkExampleBlockConsistency
  n2 <- checkRunExampleConsistency
  n3 <- checkNoUnderscoreExports
  pure (n1 + n2 + n3)

-- | Returns 0 on success, 1 on failure
assert :: String -> Boolean -> Effect Int
assert label b
  | b = Console.log ("  ✓ " <> label) $> 0
  | otherwise = do
      Console.log ("  ✗ " <> label)
      pure 1

foreign import unsafeCrashWith :: String -> Effect Unit

-- --------------------------------------------------------------------------
-- Property 1: EXAMPLE block ↔ declaration name consistency
-- --------------------------------------------------------------------------

-- | In each examples/src/Examples/Docs/*.purs file, each
-- | `-- [EXAMPLE Qual.Name.func]` block should be immediately followed by
-- | a declaration named `example` + capitalize(func).
checkExampleBlockConsistency :: Effect Int
checkExampleBlockConsistency = do
  Console.log "checkExampleBlockConsistency"
  ref <- Ref.new 0
  files <- listExampleDocFiles
  for_ files \path -> do
    content <- FS.readTextFile UTF8 path
    let blocks = extractExampleBlocks content
    for_ blocks \block -> do
      let
        funcName = lastSegment block.tag
        expectedDecl = "example" <> capitalize funcName
      n <- assert
        ( path <> ": [EXAMPLE " <> block.tag <> "] → "
            <> expectedDecl
            <> " (got: "
            <> show block.declName
            <> ")"
        )
        (block.declName == Just expectedDecl)
      Ref.modify_ (_ + n) ref
  Ref.read ref

type ExampleBlock =
  { tag :: String -- e.g. "JS.Temporal.Instant.fromString"
  , declName :: Maybe String -- the top-level decl name found inside the block
  }

extractExampleBlocks :: String -> Array ExampleBlock
extractExampleBlocks content =
  let
    lines = String.split (String.Pattern "\n") content
  in
    go [] Nothing lines
  where
  go acc _ arr | Array.null arr = acc
  go acc currentTag arr =
    case Array.uncons arr of
      Nothing -> acc
      Just { head: line, tail: rest } ->
        case parseExampleOpen line of
          Just tag ->
            let declName = findDeclInBlock rest
            in go (Array.snoc acc { tag, declName }) (Just tag) rest
          Nothing ->
            go acc currentTag rest

parseExampleOpen :: String -> Maybe String
parseExampleOpen line =
  let trimmed = String.trim line
  in
    if String.take 12 trimmed == "-- [EXAMPLE " then
      let inner = String.drop 12 trimmed
      in Just (SCU.take (SCU.length inner - 1) inner)
    else
      Nothing

findDeclInBlock :: Array String -> Maybe String
findDeclInBlock arr =
  case Array.uncons arr of
    Nothing -> Nothing
    Just { head: line, tail: rest } ->
      let trimmed = String.trim line
      in
        if String.take 13 trimmed == "-- [/EXAMPLE]" then
          Nothing
        else if String.take 2 trimmed == "--" || String.null trimmed then
          findDeclInBlock rest
        else
          extractDeclName trimmed

extractDeclName :: String -> Maybe String
extractDeclName line =
  -- Match pattern: identifier followed by space and :: or =
  case Regex.regex "^([a-zA-Z][a-zA-Z0-9_']*)" RegexFlags.noFlags of
    Right re -> do
      match <- Regex.match re line
      firstGroup <- NEA.index match 1
      firstGroup
    Left _ -> Nothing

-- --------------------------------------------------------------------------
-- Property 2: runExample calls ↔ EXAMPLE blocks
-- --------------------------------------------------------------------------

-- | Each `runExample "Qual.Name.func" Mod.exampleFunc` call should satisfy:
-- | the function ref is "example" + capitalize(lastSegment(label))
checkRunExampleConsistency :: Effect Int
checkRunExampleConsistency = do
  Console.log "checkRunExampleConsistency"
  ref <- Ref.new 0
  content <- FS.readTextFile UTF8 "../../examples/src/Examples/Docs/Main.purs"
  let calls = extractRunExampleCalls content
  for_ calls \call -> do
    let
      funcName = lastSegment call.label
      expectedRef = "example" <> capitalize funcName
    n <- assert
      ( "runExample \"" <> call.label <> "\" → "
          <> expectedRef
          <> " (got: "
          <> call.funcRef
          <> ")"
      )
      (call.funcRef == expectedRef)
    Ref.modify_ (_ + n) ref
  Ref.read ref

type RunExampleCall =
  { label :: String -- e.g. "JS.Temporal.Instant.fromString"
  , funcRef :: String -- e.g. "exampleFromString" (without module qualifier)
  }

extractRunExampleCalls :: String -> Array RunExampleCall
extractRunExampleCalls content =
  let lines = String.split (String.Pattern "\n") content
  in Array.mapMaybe parseRunExampleLine lines

parseRunExampleLine :: String -> Maybe RunExampleCall
parseRunExampleLine line =
  case Regex.regex "runExample\\s+\"([^\"]+)\"\\s+\\S+\\.([a-zA-Z][a-zA-Z0-9_']*)" RegexFlags.noFlags of
    Right re -> do
      m <- Regex.match re line
      label <- join (NEA.index m 1)
      funcRef <- join (NEA.index m 2)
      Just { label, funcRef }
    Left _ -> Nothing
  where
  join = case _ of
    Just (Just x) -> Just x
    _ -> Nothing

-- --------------------------------------------------------------------------
-- Property 3: No underscored public API exports
-- --------------------------------------------------------------------------

-- | After rename, no module in src/JS/Temporal/ should export a function
-- | ending with `_` (except things like `new_` which are a different convention).
checkNoUnderscoreExports :: Effect Int
checkNoUnderscoreExports = do
  Console.log "checkNoUnderscoreExports"
  ref <- Ref.new 0
  files <- listLibraryFiles
  for_ files \path -> do
    content <- FS.readTextFile UTF8 path
    let underscored = findUnderscoredExports content
    for_ underscored \name -> do
      n <- assert (path <> ": export '" <> name <> "' ends with _") false
      Ref.modify_ (_ + n) ref
  Ref.read ref

findUnderscoredExports :: String -> Array String
findUnderscoredExports content =
  let lines = String.split (String.Pattern "\n") content
  in Array.mapMaybe checkExportLine lines
  where
  checkExportLine line =
    let trimmed = String.trim line
    in
      -- Look for export list entries like "  , foo_" or "  ( foo_"
      case Regex.regex "^[,(]\\s+([a-z][a-zA-Z0-9]*_)\\s*$" RegexFlags.noFlags of
        Right re -> do
          m <- Regex.match re trimmed
          name <- join (NEA.index m 1)
          -- Exclude known exceptions
          if name == "new_" then Nothing
          else Just name
        Left _ -> Nothing

  join = case _ of
    Just (Just x) -> Just x
    _ -> Nothing

-- --------------------------------------------------------------------------
-- Helpers
-- --------------------------------------------------------------------------

listExampleDocFiles :: Effect (Array String)
listExampleDocFiles = do
  let dir = "../../examples/src/Examples/Docs"
  entries <- FS.readdir dir
  pure $ map (\f -> dir <> "/" <> f) $
    Array.filter (\f -> endsWith ".purs" f && f /= "Main.purs") entries

listLibraryFiles :: Effect (Array String)
listLibraryFiles = do
  let dir = "../../src/JS/Temporal"
  entries <- FS.readdir dir
  pure $ map (\f -> dir <> "/" <> f) $
    Array.filter (endsWith ".purs") entries

endsWith :: String -> String -> Boolean
endsWith suffix str =
  case String.lastIndexOf (String.Pattern suffix) str of
    Just idx -> idx + String.length suffix == String.length str
    Nothing -> false

lastSegment :: String -> String
lastSegment s =
  case Array.last (String.split (String.Pattern ".") s) of
    Just seg -> seg
    Nothing -> s

capitalize :: String -> String
capitalize s =
  case SCU.uncons s of
    Just { head, tail } -> SCU.singleton (toUpper head) <> tail
    Nothing -> s

foreign import toUpper :: Char -> Char
