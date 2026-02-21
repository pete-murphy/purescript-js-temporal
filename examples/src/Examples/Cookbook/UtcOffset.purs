-- | Cookbook: UTC offset for a zoned event
-- | https://tc39.es/proposal-temporal/docs/cookbook.html#utc-offset-for-a-zoned-event-as-a-string
module Examples.Cookbook.UtcOffset where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.Instant as Instant
import JS.Temporal.ZonedDateTime as ZonedDateTime

getUtcOffsetDifferenceSeconds
  :: Instant.Instant -> String -> String -> Int
getUtcOffsetDifferenceSeconds instant sourceTimeZone targetTimeZone =
  let
    sourceOffsetNs = ZonedDateTime.offsetNanoseconds (Instant.toZonedDateTimeISO sourceTimeZone instant)
    targetOffsetNs = ZonedDateTime.offsetNanoseconds (Instant.toZonedDateTimeISO targetTimeZone instant)
  in
    (targetOffsetNs - sourceOffsetNs) `div` 1000000000

main :: Effect Unit
main = do
  instant <- Instant.from "2020-01-09T00:00Z"
  let zoned = Instant.toZonedDateTimeISO "America/New_York" instant
  Console.log ("UTC offset (string): " <> ZonedDateTime.offset zoned)
  Console.log ("UTC offset (seconds): " <> show (ZonedDateTime.offsetNanoseconds zoned `div` 1000000000))

  let diff = getUtcOffsetDifferenceSeconds instant "America/New_York" "America/Chicago"
  Console.log ("NY to Chicago diff (seconds): " <> show diff)
