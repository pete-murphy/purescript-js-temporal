module Rename
  ( RenameEntry
  , renamePurs
  , renameJs
  ) where

import Prelude

import Data.Array as Array
import Data.Foldable (foldMap)
import Data.Maybe (Maybe(..))
import Data.Newtype (unwrap)
import Data.String as String
import Data.String.Regex as Regex
import Data.String.Regex.Flags as RegexFlags
import Data.Either (Either(..))
import PureScript.CST (RecoveredParserResult(..), parseModule)
import PureScript.CST.Print as Print
import PureScript.CST.Range (class TokensOf, tokensOf)
import PureScript.CST.Range.TokenList as TokenList
import PureScript.CST.Types (Comment(..), LineFeed, Module(..), ModuleBody(..), SourceToken, Token(..))

type RenameEntry = { old :: String, new :: String }

-- | Rename identifiers, string contents, and comment contents in PureScript source.
-- | Applies all renames simultaneously on the original token stream (no collision on swaps).
renamePurs :: Array RenameEntry -> String -> String
renamePurs renames input =
  case parseModule input of
    ParseSucceeded mod ->
      printModuleRenamed renames mod
    ParseSucceededWithErrors mod _ ->
      printModuleRenamed renames mod
    ParseFailed _ ->
      -- Fall back to text-based replacement if parse fails
      input

printModuleRenamed :: forall e. TokensOf e => Array RenameEntry -> Module e -> String
printModuleRenamed renames mod =
  foldMap (Print.printSourceToken <<< renameSourceToken renames)
    (TokenList.toArray (tokensOf mod))
    <> foldMap (Print.printComment Print.printLineFeed)
         (unwrap (unwrap mod).body).trailingComments

renameSourceToken :: Array RenameEntry -> SourceToken -> SourceToken
renameSourceToken renames tok = tok
  { value = renameToken renames tok.value
  , leadingComments = map (renameComment renames) tok.leadingComments
  , trailingComments = map (renameComment renames) tok.trailingComments
  }

renameToken :: Array RenameEntry -> Token -> Token
renameToken renames = case _ of
  TokLowerName qual name ->
    case Array.find (\r -> r.old == name) renames of
      Just entry -> TokLowerName qual entry.new
      Nothing -> TokLowerName qual name
  TokString raw cooked ->
    TokString (replaceInText renames raw) (replaceInText renames cooked)
  other -> other

renameComment :: forall l. Array RenameEntry -> Comment l -> Comment l
renameComment renames = case _ of
  Comment str -> Comment (replaceInText renames str)
  other -> other

-- | Replace all occurrences of rename entries in a text string.
-- | Uses simultaneous replacement to avoid swap collisions.
replaceInText :: Array RenameEntry -> String -> String
replaceInText = replaceAllSimultaneous

replaceAll :: String -> String -> String -> String
replaceAll old new text =
  case Regex.regex (escapeRegex old) RegexFlags.global of
    Right re -> Regex.replace re new text
    Left _ -> text

-- Escape special regex characters
escapeRegex :: String -> String
escapeRegex s =
  case Regex.regex "[.*+?^${}()|\\[\\]\\\\]" RegexFlags.global of
    Right re -> Regex.replace re "\\$&" s
    Left _ -> s

-- | Replace all entries simultaneously to avoid swap collisions.
-- | Builds a single regex (longest-first) and dispatches via lookup.
replaceAllSimultaneous :: Array RenameEntry -> String -> String
replaceAllSimultaneous renames text
  | Array.null renames = text
  | otherwise =
      let
        -- Sort longest-first so "_untilNoOpts" matches before "_until"
        sorted = Array.sortBy (\a b -> compare (String.length b.old) (String.length a.old)) renames
        -- Word-boundary pattern: match whole identifiers
        pattern = String.joinWith "|" (map (\r -> escapeRegex r.old <> "(?![a-zA-Z0-9_])") sorted)
      in
        case Regex.regex pattern RegexFlags.global of
          Right re -> Regex.replace' re (\match _ -> lookupNew sorted match) text
          Left _ -> text

lookupNew :: Array RenameEntry -> String -> String
lookupNew renames match =
  case Array.find (\r -> r.old == match) renames of
    Just entry -> entry.new
    Nothing -> match

-- | Rename exported function names in a JavaScript FFI file.
-- | Uses simultaneous replacement to avoid swap collisions.
renameJs :: Array RenameEntry -> String -> String
renameJs renames input = replaceAllSimultaneous renames input
