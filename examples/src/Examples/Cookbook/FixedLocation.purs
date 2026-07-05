-- | Cookbook: Dealing with dates and times in a fixed location
-- | https://tc39.es/proposal-temporal/docs/cookbook.html#dealing-with-dates-and-times-in-a-fixed-location
module Examples.Cookbook.FixedLocation where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.ZonedDateTime as ZonedDateTime
import TryPureScript (render, withConsole)

-- | When working with a location that has a fixed UTC offset (no DST),
-- | you can use the offset directly as the time zone identifier.
main :: Effect Unit
main = render =<< withConsole do
  -- Kathmandu is UTC+05:45
  kathmandu <- ZonedDateTime.fromString "2020-01-09T12:00+05:45[+05:45]"
  Console.log ("Time in Kathmandu: " <> ZonedDateTime.toString kathmandu)
  Console.log ("UTC offset: " <> ZonedDateTime.offset kathmandu)

  -- You can also use the IANA time zone for the same result with DST awareness
  namedZone <- ZonedDateTime.fromString "2020-01-09T12:00[Asia/Kathmandu]"
  Console.log ("Using IANA zone: " <> ZonedDateTime.toString namedZone)
  Console.log ("UTC offset: " <> ZonedDateTime.offset namedZone)
