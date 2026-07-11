-- | Compilable doc examples for JS.Temporal.PlainTime.Compat.
module Examples.Docs.PlainTime.Compat where

import Prelude

import Data.Time.Gen (genTime)
import Effect (Effect)
import Effect.Class.Console as Console
import Examples.Docs.GenState (genState)
import JS.Temporal.PlainTime as PlainTime
import JS.Temporal.PlainTime.Compat as PlainTime.Compat
import Test.QuickCheck.Gen as Gen

-- | Converts a purescript-datetime `Time` to a `PlainTime`. Microsecond and
-- | nanosecond components are set to zero.
exampleFromTime :: Effect Unit
exampleFromTime = do
  let time = Gen.evalGen genTime genState
  plainTime <- PlainTime.Compat.fromTime time
  Console.log (PlainTime.toString plainTime)

-- | Converts a `PlainTime` to a purescript-datetime `Time`.
-- | Microsecond and nanosecond are dropped (treated as zero).
exampleToTime :: Effect Unit
exampleToTime = do
  time <- PlainTime.fromString "14:30:00"
  Console.logShow (PlainTime.Compat.toTime time)
