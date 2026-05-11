-- | Cookbook: Manipulating the day of the month
-- | https://tc39.es/proposal-temporal/docs/cookbook.html#manipulating-the-day-of-the-month
module Examples.Cookbook.ManipulatingDayOfMonth where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.Duration as Duration
import JS.Temporal.PlainDate as PlainDate
import JS.Temporal.PlainDateTime as PlainDateTime
import JS.Temporal.PlainTime as PlainTime

main :: Effect Unit
main = do
  date <- PlainDate.fromString "2020-04-14"

  monthsDuration <- Duration.from { months: 1 }
  nextMonth <- PlainDate.add monthsDuration date
  thirdOfNextMonth <- PlainDate.with { day: 3 } nextMonth
  Console.log ("Third day of next month: " <> PlainDate.toString thirdOfNextMonth)

  lastOfThisMonth <- PlainDate.with { day: PlainDate.daysInMonth date } date
  Console.log ("Last day of this month: " <> PlainDate.toString lastOfThisMonth)

  eighteenth <- PlainDate.with { day: 18 } date
  eightPM <- PlainTime.fromString "20:00"
  let thisMonth18thAt8PM = PlainDate.toPlainDateTime eightPM eighteenth
  Console.log ("18th at 8 PM: " <> PlainDateTime.toString thisMonth18thAt8PM)
