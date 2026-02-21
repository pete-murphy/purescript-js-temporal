-- | Cookbook: Round a time down to whole hours
-- | https://tc39.es/proposal-temporal/docs/cookbook.html#round-a-time-down-to-whole-hours
module Examples.Cookbook.RoundTimeDown where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.PlainTime as PlainTime
import JS.Temporal.RoundingMode as RoundingMode
import JS.Temporal.TemporalUnit as TemporalUnit

main :: Effect Unit
main = do
  time <- PlainTime.from_ "12:38:28.138818731"
  wholeHour <- PlainTime.round { smallestUnit: TemporalUnit.Hour, roundingMode: RoundingMode.Floor } time
  Console.log ("Rounded down to hour: " <> PlainTime.toString_ wholeHour)
