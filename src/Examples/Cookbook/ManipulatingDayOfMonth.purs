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
  date <- PlainDate.from_ "2020-04-14"

  monthsDuration <- Duration.new { months: 1 }
  nextMonth <- PlainDate.add_ monthsDuration date
  thirdOfNextMonth <- PlainDate.with_ { day: 3 } nextMonth
  Console.log ("Third day of next month: " <> PlainDate.toString_ thirdOfNextMonth)

  lastOfThisMonth <- PlainDate.with_ { day: PlainDate.daysInMonth date } date
  Console.log ("Last day of this month: " <> PlainDate.toString_ lastOfThisMonth)

  eighteenth <- PlainDate.with_ { day: 18 } date
  eightPM <- PlainTime.from_ "20:00"
  let thisMonth18thAt8PM = PlainDate.toPlainDateTime eightPM eighteenth
  Console.log ("18th at 8 PM: " <> PlainDateTime.toString_ thisMonth18thAt8PM)
