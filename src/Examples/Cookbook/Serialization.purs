-- | Cookbook: Zoned instant from instant and time zone
-- | https://tc39.es/proposal-temporal/docs/cookbook.html#zoned-instant-from-instant-and-time-zone
module Examples.Cookbook.Serialization where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.Instant as Instant
import JS.Temporal.ZonedDateTime as ZonedDateTime

main :: Effect Unit
main = do
  instant <- Instant.from "2020-01-03T10:41:51Z"
  let result = Instant.toString {} instant
  Console.log ("UTC string: " <> result)

  let result2 = Instant.toString { timeZone: "America/Yellowknife" } instant
  Console.log ("America/Yellowknife: " <> result2)

  let zoned = Instant.toZonedDateTimeISO "Asia/Seoul" instant
  let result3 = ZonedDateTime.toString {} zoned
  Console.log ("With time zone name: " <> result3)
