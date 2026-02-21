-- | Cookbook: Round a date to the nearest start of the month
-- | https://tc39.es/proposal-temporal/docs/cookbook.html#round-a-date-to-the-nearest-start-of-the-month
module Examples.Cookbook.RoundDateToMonth where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.Duration as Duration
import JS.Temporal.PlainDate as PlainDate

main :: Effect Unit
main = do
  date <- PlainDate.from_ "2018-09-16"
  firstOfCurrentMonth <- PlainDate.with_ { day: 1 } date
  oneMonth <- Duration.new { months: 1 }
  firstOfNextMonth <- PlainDate.add_ oneMonth firstOfCurrentMonth

  sinceCurrent <- PlainDate.since_ date firstOfCurrentMonth
  untilNext <- PlainDate.until_ firstOfNextMonth date

  ordering <- Duration.compare sinceCurrent untilNext
  let isCloserToNextMonth = ordering == GT || ordering == EQ
  let nearestMonth = if isCloserToNextMonth then firstOfNextMonth else firstOfCurrentMonth

  Console.log ("Nearest month start: " <> PlainDate.toString_ nearestMonth)
