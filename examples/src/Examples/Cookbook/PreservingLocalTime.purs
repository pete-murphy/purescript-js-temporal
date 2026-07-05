-- | Cookbook: Preserving local time (time zone conversion)
-- | https://tc39.es/proposal-temporal/docs/cookbook.html#preserving-local-time
module Examples.Cookbook.PreservingLocalTime where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.PlainDateTime as PlainDateTime
import JS.Temporal.ZonedDateTime as ZonedDateTime
import TryPureScript (render, withConsole)

-- | "Preserving local time" means keeping the wall-clock time the same
-- | while changing the time zone. For example, scheduling a 9:00 AM
-- | meeting in Chicago, then seeing what 9:00 AM is in Los Angeles.
main :: Effect Unit
main = render =<< withConsole do
  source <- ZonedDateTime.fromString "2020-01-09T00:00[America/Chicago]"
  let plainDateTime = ZonedDateTime.toPlainDateTime source
  result <- PlainDateTime.toZonedDateTime "America/Los_Angeles" plainDateTime
  Console.log ("Midnight wall-clock time, in Chicago: " <> ZonedDateTime.toString source)
  Console.log ("Midnight wall-clock time, in LA:      " <> ZonedDateTime.toString result)
