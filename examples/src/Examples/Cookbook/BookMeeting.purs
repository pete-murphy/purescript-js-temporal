-- | Cookbook: Book a meeting across time zones
-- | https://tc39.es/proposal-temporal/docs/cookbook.html#book-a-meeting-across-time-zones
module Examples.Cookbook.BookMeeting where

import Prelude

import Data.Foldable (traverse_)
import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.ZonedDateTime as ZonedDateTime

-- | Book a meeting at a specific time in one time zone and show what time
-- | that meeting is in other participants' time zones.
main :: Effect Unit
main = do
  -- The meeting organizer schedules at 10am in Tokyo
  meeting <- ZonedDateTime.fromString "2020-01-09T10:00[Asia/Tokyo]"
  Console.log ("Meeting in Tokyo:     " <> ZonedDateTime.toString meeting)

  let
    participantTimeZones =
      [ "America/New_York"
      , "Europe/London"
      , "Asia/Shanghai"
      ]

  traverse_
    ( \tz -> do
        local <- ZonedDateTime.withTimeZone tz meeting
        Console.log ("Meeting in " <> tz <> ": " <> ZonedDateTime.toString local)
    )
    participantTimeZones
