-- | Cookbook: How many days until a future date
-- | https://tc39.es/proposal-temporal/docs/cookbook.html#how-many-days-until-a-future-date
module Examples.Cookbook.DaysUntilFutureDate where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.Duration as Duration
import JS.Temporal.Now as Now
import JS.Temporal.PlainDate as PlainDate
import JS.Temporal.TemporalUnit as TemporalUnit

main :: Effect Unit
main = do
  today <- Now.plainDateISO
  futureDate <- PlainDate.from_ "2026-12-25"
  untilDuration <- PlainDate.until { largestUnit: TemporalUnit.Day } futureDate today
  Console.log ("Days until Christmas 2026: " <> show (Duration.days untilDuration))
