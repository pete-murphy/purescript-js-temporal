-- | Cookbook: Unix timestamp
-- | https://tc39.es/proposal-temporal/docs/cookbook.html#unix-timestamp
module Examples.Cookbook.UnixTimestamp where

import Prelude

import Data.Int as Int
import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.Instant as Instant
import JS.Temporal.Now as Now

main :: Effect Unit
main = do
  timeStamp <- Now.instant
  let ms = Instant.epochMilliseconds timeStamp
  let seconds = Int.floor (ms / 1000.0)
  Console.log ("Timestamp in milliseconds: " <> show ms)
  Console.log ("Timestamp in seconds: " <> show seconds)
