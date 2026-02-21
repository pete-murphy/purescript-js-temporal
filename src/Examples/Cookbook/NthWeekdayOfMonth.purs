-- | Cookbook: Nth weekday of the month
-- | https://tc39.es/proposal-temporal/docs/cookbook.html#nth-weekday-of-the-month
module Examples.Cookbook.NthWeekdayOfMonth where

import Prelude

import Data.Array ((!!))
import Data.Maybe (fromMaybe)
import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.Duration as Duration
import JS.Temporal.PlainDate as PlainDate
import JS.Temporal.PlainYearMonth as PlainYearMonth

getFirstTuesday :: PlainYearMonth.PlainYearMonth -> Effect PlainDate.PlainDate
getFirstTuesday queriedMonth = do
  firstOfMonth <- PlainYearMonth.toPlainDate { day: 1 } queriedMonth
  let lookupTable = [ 1, 0, 6, 5, 4, 3, 2 ]
  let daysToAdd = fromMaybe 0 (lookupTable !! (PlainDate.dayOfWeek firstOfMonth - 1))
  daysDuration <- Duration.new { days: daysToAdd }
  PlainDate.add_ daysDuration firstOfMonth

main :: Effect Unit
main = do
  myMonth <- PlainYearMonth.from_ "2020-02"
  firstTuesday <- getFirstTuesday myMonth
  Console.log ("First Tuesday of Feb 2020: " <> PlainDate.toString {} firstTuesday)
  Console.log ("Day of week: " <> show (PlainDate.dayOfWeek firstTuesday))
