-- | Cookbook: Unit-constrained duration between now and a past/future zoned event
-- | https://tc39.es/proposal-temporal/docs/cookbook.html#unit-constrained-duration-between-now-and-a-pastfuture-zoned-event
module Examples.Cookbook.UnitConstrainedDuration where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.Duration as Duration
import JS.Temporal.Instant as Instant
import JS.Temporal.Options.TemporalUnit as TemporalUnit

main :: Effect Unit
main = do
  earlier <- Instant.from "2020-01-09T00:00Z"
  later <- Instant.from "2020-01-09T04:00Z"

  result <- Instant.since { largestUnit: TemporalUnit.Hour } later earlier
  Console.log ("4 hours as PT4H: " <> Duration.toString_ result)

  result2 <- Instant.until { largestUnit: TemporalUnit.Minute } later earlier
  Console.log ("4 hours as PT240M: " <> Duration.toString_ result2)
