-- | Cookbook: Sort PlainDateTime values
-- | https://tc39.es/proposal-temporal/docs/cookbook.html#sort-plaindatetime-values
module Examples.Cookbook.SortPlainDateTime where

import Prelude

import Data.Array (reverse, sort)
import Data.Foldable (intercalate)
import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.PlainDateTime as PlainDateTime

getSortedLocalDateTimes
  :: Array PlainDateTime.PlainDateTime -> Boolean -> Array PlainDateTime.PlainDateTime
getSortedLocalDateTimes dateTimes rev =
  if rev then
    (reverse <<< sort) dateTimes
  else
    sort dateTimes

main :: Effect Unit
main = do
  a <- PlainDateTime.from_ "2020-02-20T08:45:00"
  b <- PlainDateTime.from_ "2020-02-21T13:10:00"
  c <- PlainDateTime.from_ "2020-02-20T15:30:00"
  let results = getSortedLocalDateTimes [ a, b, c ] false
  let strings = map (PlainDateTime.toString {}) results
  Console.log ("Sorted: " <> intercalate ", " strings)
