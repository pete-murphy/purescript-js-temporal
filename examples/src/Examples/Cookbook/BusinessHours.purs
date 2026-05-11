-- | Cookbook: Comparison of an exact time to business hours
-- | https://tc39.es/proposal-temporal/docs/cookbook.html#comparison-of-an-exact-time-to-business-hours
module Examples.Cookbook.BusinessHours where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.Instant as Instant
import JS.Temporal.PlainTime as PlainTime
import JS.Temporal.ZonedDateTime as ZonedDateTime

isBusinessHours :: String -> Instant.Instant -> Effect Boolean
isBusinessHours timeZone instant = do
  let zoned = Instant.toZonedDateTimeISO timeZone instant
  let localTime = ZonedDateTime.toPlainTime zoned
  open <- PlainTime.fromString "08:00"
  close <- PlainTime.fromString "17:00"
  pure (localTime >= open && localTime < close)

main :: Effect Unit
main = do
  -- Is it currently business hours in New York?
  instant <- Instant.fromString "2020-01-09T12:00Z"

  nyOpen <- isBusinessHours "America/New_York" instant
  Console.log ("Business hours in New York: " <> show nyOpen)

  tokyoOpen <- isBusinessHours "Asia/Tokyo" instant
  Console.log ("Business hours in Tokyo:    " <> show tokyoOpen)

  londonOpen <- isBusinessHours "Europe/London" instant
  Console.log ("Business hours in London:   " <> show londonOpen)
