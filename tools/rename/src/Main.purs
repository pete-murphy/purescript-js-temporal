module Main where

import Prelude

import Data.Array as Array
import Data.Foldable (for_)
import Data.Maybe (Maybe(..))
import Data.String as String
import Effect (Effect)
import Effect.Console as Console
import Node.Encoding (Encoding(..))
import Node.FS.Sync as FS
import Node.Process as Process
import Rename (RenameEntry, renamePurs, renameJs)

main :: Effect Unit
main = do
  args <- Process.argv
  -- Skip first two args (node, script)
  let effectiveArgs = Array.drop 2 args
  case effectiveArgs of
    [ "--config", configPath ] ->
      runWithConfig configPath false
    [ "--config", configPath, "--dry-run" ] ->
      runWithConfig configPath true
    [ "--dry-run", "--config", configPath ] ->
      runWithConfig configPath true
    _ -> do
      Console.error "Usage: rename-tool --config <config-file> [--dry-run]"
      Console.error ""
      Console.error "Config file format (one entry per line):"
      Console.error "  RENAME <old> <new>"
      Console.error "  FILE <path>"
      Console.error ""
      Console.error "Example:"
      Console.error "  RENAME until_ until"
      Console.error "  RENAME until untilWithOptions"
      Console.error "  FILE src/JS/Temporal/Instant.purs"
      Console.error "  FILE src/JS/Temporal/Instant.js"
      Process.exit' 1

runWithConfig :: String -> Boolean -> Effect Unit
runWithConfig configPath dryRun = do
  configText <- FS.readTextFile UTF8 configPath
  let config = parseConfig configText
  Console.log ("Loaded " <> show (Array.length config.renames) <> " renames, " <> show (Array.length config.files) <> " files")
  when dryRun $ Console.log "(dry run — no files will be written)"
  processFiles config.renames config.files dryRun

type Config =
  { renames :: Array RenameEntry
  , files :: Array String
  }

parseConfig :: String -> Config
parseConfig text =
  let
    lines = String.split (String.Pattern "\n") text
    go acc line =
      let trimmed = String.trim line
      in
        if String.null trimmed || String.take 1 trimmed == "#" then
          acc
        else case String.split (String.Pattern " ") trimmed of
          [ "RENAME", old, new ] ->
            acc { renames = Array.snoc acc.renames { old, new } }
          [ "FILE", path ] ->
            acc { files = Array.snoc acc.files path }
          _ -> acc
  in
    Array.foldl go { renames: [], files: [] } lines

processFiles :: Array RenameEntry -> Array String -> Boolean -> Effect Unit
processFiles renames files dryRun = do
  for_ files \path -> do
    content <- FS.readTextFile UTF8 path
    let
      result
        | isPursFile path = renamePurs renames content
        | isJsFile path = renameJs renames content
        | otherwise = content
    if result == content then
      Console.log ("  (unchanged) " <> path)
    else do
      Console.log ("  ✏️  " <> path)
      unless dryRun $ FS.writeTextFile UTF8 path result

isPursFile :: String -> Boolean
isPursFile path = endsWith ".purs" path

isJsFile :: String -> Boolean
isJsFile path = endsWith ".js" path

endsWith :: String -> String -> Boolean
endsWith suffix str =
  case String.lastIndexOf (String.Pattern suffix) str of
    Just idx -> idx + String.length suffix == String.length str
    Nothing -> false
