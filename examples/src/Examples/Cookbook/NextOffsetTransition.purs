-- | Cookbook: Next offset transition in a time zone
-- | https://tc39.es/proposal-temporal/docs/cookbook.html#next-offset-transition-in-a-time-zone
module Examples.Cookbook.NextOffsetTransition where

import Prelude

import Data.Maybe (maybe)
import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.ZonedDateTime as ZonedDateTime

main :: Effect Unit
main = do
  Console.log "TODO: Fix"
-- nycTime <- ZonedDateTime.from_ "2019-04-16T21:01Z[America/New_York]"
-- maybe
--   (Console.log "No known future DST transition")
--   (\nextTransition -> Console.log ("Next DST transition: " <> ZonedDateTime.toString_ nextTransition))
--   (ZonedDateTime.getTimeZoneTransition "next" nycTime)
