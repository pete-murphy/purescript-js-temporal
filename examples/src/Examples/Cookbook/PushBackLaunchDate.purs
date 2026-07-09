-- | Cookbook: Push back a launch date
-- | https://tc39.es/proposal-temporal/docs/cookbook.html#push-back-a-launch-date
module Examples.Cookbook.PushBackLaunchDate where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.Duration as Duration
import JS.Temporal.PlainDate (PlainDate)
import JS.Temporal.PlainDate as PlainDate
import TryPureScript (render, withConsole)

plusAndRoundToMonthStart :: PlainDate -> Int -> Effect PlainDate
plusAndRoundToMonthStart date delayDays = do
  daysDuration <- Duration.from { days: delayDays }
  monthsDuration <- Duration.from { months: 1 }
  afterDelay <- PlainDate.add daysDuration date
  nextMonth <- PlainDate.add monthsDuration afterDelay
  PlainDate.with { day: 1 } nextMonth

main :: Effect Unit
main = render =<< withConsole do
  oldLaunchDate <- PlainDate.fromString "2019-06-01"

  fifteenDaysDelay <- plusAndRoundToMonthStart oldLaunchDate 15
  Console.log ("15 days delay: " <> PlainDate.toString fifteenDaysDelay)

  sixtyDaysDelay <- plusAndRoundToMonthStart oldLaunchDate 60
  Console.log ("60 days delay: " <> PlainDate.toString sixtyDaysDelay)
