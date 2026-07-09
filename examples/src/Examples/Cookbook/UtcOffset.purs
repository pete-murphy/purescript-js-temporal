-- | Cookbook: UTC offset for a zoned event
-- | https://tc39.es/proposal-temporal/docs/cookbook.html#utc-offset-for-a-zoned-event-as-a-string
module Examples.Cookbook.UtcOffset where

import Prelude

import Data.Int as Int
import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.Instant (Instant)
import JS.Temporal.Instant as Instant
import JS.Temporal.ZonedDateTime as ZonedDateTime
import TryPureScript (render, withConsole)

getUtcOffsetDifferenceSeconds
  :: Instant -> String -> String -> Number
getUtcOffsetDifferenceSeconds instant sourceTimeZone targetTimeZone =
  let
    sourceOffsetNs = ZonedDateTime.offsetNanoseconds (Instant.toZonedDateTimeISO sourceTimeZone instant)
    targetOffsetNs = ZonedDateTime.offsetNanoseconds (Instant.toZonedDateTimeISO targetTimeZone instant)
  in
    (targetOffsetNs - sourceOffsetNs) / 1000000000.0

main :: Effect Unit
main = render =<< withConsole do
  instant <- Instant.fromString "2020-01-09T00:00Z"
  let zoned = Instant.toZonedDateTimeISO "America/New_York" instant
  Console.log ("UTC offset (string): " <> ZonedDateTime.offset zoned)
  Console.log ("UTC offset (seconds): " <> show (Int.floor (ZonedDateTime.offsetNanoseconds zoned / 1000000000.0)))

  let diff = getUtcOffsetDifferenceSeconds instant "America/New_York" "America/Chicago"
  Console.log ("NY to Chicago diff (seconds): " <> show (Int.floor diff))
