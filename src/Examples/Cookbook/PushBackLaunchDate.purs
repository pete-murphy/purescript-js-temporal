-- | Cookbook: Push back a launch date
-- | https://tc39.es/proposal-temporal/docs/cookbook.html#push-back-a-launch-date
module Examples.Cookbook.PushBackLaunchDate where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.Duration as Duration
import JS.Temporal.PlainDate as PlainDate

plusAndRoundToMonthStart :: PlainDate.PlainDate -> Int -> Effect PlainDate.PlainDate
plusAndRoundToMonthStart date delayDays = do
  daysDuration <- Duration.new { days: delayDays }
  monthsDuration <- Duration.new { months: 1 }
  afterDelay <- PlainDate.add_ daysDuration date
  nextMonth <- PlainDate.add_ monthsDuration afterDelay
  PlainDate.with_ { day: 1 } nextMonth

main :: Effect Unit
main = do
  oldLaunchDate <- PlainDate.from_ "2019-06-01"

  fifteenDaysDelay <- plusAndRoundToMonthStart oldLaunchDate 15
  Console.log ("15 days delay: " <> PlainDate.toString_ fifteenDaysDelay)

  sixtyDaysDelay <- plusAndRoundToMonthStart oldLaunchDate 60
  Console.log ("60 days delay: " <> PlainDate.toString_ sixtyDaysDelay)
