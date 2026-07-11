-- | Compilable doc examples for JS.Temporal.PlainDateTime.Compat.
module Examples.Docs.PlainDateTime.Compat where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.PlainDateTime as PlainDateTime
import JS.Temporal.PlainDateTime.Compat as PlainDateTime.Compat

-- | Converts a purescript-datetime `DateTime` to a `PlainDateTime`.
exampleFromDateTime :: Effect Unit
exampleFromDateTime = do
  dt <- PlainDateTime.fromString "2024-07-01T12:00:00"
  roundTripped <- PlainDateTime.Compat.fromDateTime (PlainDateTime.Compat.toDateTime dt)
  Console.log (PlainDateTime.toString roundTripped)

-- | Converts a `PlainDateTime` to a purescript-datetime `DateTime`.
exampleToDateTime :: Effect Unit
exampleToDateTime = do
  dt <- PlainDateTime.fromString "2024-07-01T12:00:00"
  Console.log (show (PlainDateTime.Compat.toDateTime dt))
