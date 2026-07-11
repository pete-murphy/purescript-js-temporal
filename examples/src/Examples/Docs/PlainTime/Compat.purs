-- | Compilable doc examples for JS.Temporal.PlainTime.Compat.
module Examples.Docs.PlainTime.Compat where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.PlainTime as PlainTime
import JS.Temporal.PlainTime.Compat as PlainTime.Compat

-- | Converts a purescript-datetime `Time` to a `PlainTime`. Microsecond and
-- | nanosecond components are set to zero.
exampleFromTime :: Effect Unit
exampleFromTime = do
  time <- PlainTime.fromString "14:30:00"
  roundTripped <- PlainTime.Compat.fromTime (PlainTime.Compat.toTime time)
  Console.log (PlainTime.toString roundTripped)

-- | Converts a `PlainTime` to a purescript-datetime `Time`.
-- | Microsecond and nanosecond are dropped (treated as zero).
exampleToTime :: Effect Unit
exampleToTime = do
  time <- PlainTime.fromString "14:30:00"
  Console.log (show (PlainTime.Compat.toTime time))
