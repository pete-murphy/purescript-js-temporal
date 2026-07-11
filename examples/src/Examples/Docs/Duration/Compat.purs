-- | Compilable doc examples for JS.Temporal.Duration.Compat.
module Examples.Docs.Duration.Compat where

import Prelude

import Data.Maybe (Maybe(..))
import Data.Time.Duration (Milliseconds(..))
import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.Duration as Duration
import JS.Temporal.Duration.Compat as Duration.Compat

-- | Creates a Temporal `Duration` from purescript-datetime `Milliseconds`.
exampleFromMilliseconds :: Effect Unit
exampleFromMilliseconds = do
  duration <- Duration.Compat.fromMilliseconds (Milliseconds 5000.0)
  Console.log (Duration.toString duration)

-- | Converts a Temporal `Duration` to purescript-datetime `Milliseconds`. Returns
-- | `Nothing` if the duration contains calendar units (years, months, weeks).
-- | Microseconds and nanoseconds are dropped.
exampleToMilliseconds :: Effect Unit
exampleToMilliseconds = do
  duration <- Duration.from { seconds: 5 }
  case Duration.Compat.toMilliseconds duration of
    Just (Milliseconds ms) -> Console.log ("Milliseconds: " <> show ms)
    Nothing -> Console.log "Cannot convert (has calendar units)"
