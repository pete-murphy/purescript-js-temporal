-- | Cookbook: Sort ISO date/time strings
-- | https://tc39.es/proposal-temporal/docs/cookbook.html#sort-iso-datetime-strings
module Examples.Cookbook.SortInstantStrings where

import Prelude

import Data.Array (reverse, sortBy)
import Data.Foldable (intercalate)
import Data.Traversable (traverse)
import Data.Tuple (Tuple(..), snd)
import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.Instant as Instant

sortInstantStrings :: Array String -> Boolean -> Effect (Array String)
sortInstantStrings strings reverseOrder = do
  pairs <- traverse (\s -> Tuple s <$> Instant.from s) strings
  let sorted = sortBy (comparing snd) pairs
  let result = map (\(Tuple str _) -> str) sorted
  pure if reverseOrder then reverse result else result

main :: Effect Unit
main = do
  let
    strings =
      [ "2020-01-23T17:04:36.491865121-08:00"
      , "2020-02-10T17:04:36.491865121-08:00"
      , "2020-04-01T05:01:00-04:00[America/New_York]"
      , "2020-04-01T10:00:00+01:00[Europe/London]"
      , "2020-04-01T11:02:00+02:00[Europe/Berlin]"
      ]
  result <- sortInstantStrings strings false
  Console.log ("Sorted: " <> intercalate ", " result)
