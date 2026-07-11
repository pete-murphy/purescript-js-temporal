-- | Compilable doc examples for JS.Temporal.PlainDateTime.Compat.
module Examples.Docs.PlainDateTime.Compat where

import Prelude

import Data.DateTime.Gen (genDateTime)
import Effect (Effect)
import Effect.Class.Console as Console
import Examples.Docs.GenState (genState)
import JS.Temporal.PlainDateTime as PlainDateTime
import JS.Temporal.PlainDateTime.Compat as PlainDateTime.Compat
import Test.QuickCheck.Gen as Gen

-- | Converts a purescript-datetime `DateTime` to a `PlainDateTime`.
exampleFromDateTime :: Effect Unit
exampleFromDateTime = do
  let dateTime = Gen.evalGen genDateTime genState
  plainDateTime <- PlainDateTime.Compat.fromDateTime dateTime
  Console.log (PlainDateTime.toString plainDateTime)

-- | Converts a `PlainDateTime` to a purescript-datetime `DateTime`.
exampleToDateTime :: Effect Unit
exampleToDateTime = do
  dt <- PlainDateTime.fromString "2024-07-01T12:00:00"
  Console.log (show (PlainDateTime.Compat.toDateTime dt))
