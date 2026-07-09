-- | Cookbook: Get all dates in a month that fall on a given weekday
-- | https://tc39.es/proposal-temporal/docs/cookbook.html#nth-weekday-of-the-month
module Examples.Cookbook.GetWeeklyDaysInMonth where

import Prelude

import Data.Array as Array
import Data.Foldable (intercalate)
import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.Duration as Duration
import JS.Temporal.PlainDate (PlainDate)
import JS.Temporal.PlainDate as PlainDate
import JS.Temporal.PlainYearMonth (PlainYearMonth)
import JS.Temporal.PlainYearMonth as PlainYearMonth
import TryPureScript (render, withConsole)

getWeeklyDaysInMonth
  :: PlainYearMonth -> Int -> Effect (Array PlainDate)
getWeeklyDaysInMonth yearMonth dayNumberOfTheWeek = do
  firstOfMonth <- PlainYearMonth.toPlainDate { day: 1 } yearMonth
  let daysToFirst = (7 + dayNumberOfTheWeek - PlainDate.dayOfWeek firstOfMonth) `mod` 7
  daysDuration <- Duration.from { days: daysToFirst }
  firstWeekday <- PlainDate.add daysDuration firstOfMonth
  go firstWeekday []
  where
  go nextWeekday result = do
    if PlainDate.month nextWeekday /= PlainYearMonth.month yearMonth then
      pure (Array.reverse result)
    else do
      weekDuration <- Duration.from { days: 7 }
      next <- PlainDate.add weekDuration nextWeekday
      go next ([ nextWeekday ] <> result)

main :: Effect Unit
main = render =<< withConsole do
  feb2020 <- PlainYearMonth.fromString "2020-02"
  mondays <- getWeeklyDaysInMonth feb2020 1
  saturdays <- getWeeklyDaysInMonth feb2020 6

  let mondayStrs = map PlainDate.toString mondays
  let saturdayStrs = map PlainDate.toString saturdays

  Console.log ("Mondays in Feb 2020: " <> intercalate " " mondayStrs)
  Console.log ("Saturdays in Feb 2020: " <> intercalate " " saturdayStrs)
