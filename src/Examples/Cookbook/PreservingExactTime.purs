-- | Cookbook: Preserving exact time (time zone conversion)
-- | https://tc39.es/proposal-temporal/docs/cookbook.html#preserving-exact-time
module Examples.Cookbook.PreservingExactTime where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.ZonedDateTime as ZonedDateTime

main :: Effect Unit
main = do
  source <- ZonedDateTime.from_ "2020-01-09T00:00[America/Chicago]"
  result <- ZonedDateTime.withTimeZone "America/Los_Angeles" source
  Console.log ("Midnight Chicago in LA: " <> ZonedDateTime.toString {} result)
