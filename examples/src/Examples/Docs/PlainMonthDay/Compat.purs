-- | Compilable doc examples for JS.Temporal.PlainMonthDay.Compat.
module Examples.Docs.PlainMonthDay.Compat where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.PlainMonthDay as PlainMonthDay
import JS.Temporal.PlainMonthDay.Compat as PlainMonthDay.Compat

-- | Creates a `PlainMonthDay` from purescript-datetime `Month` and `Day`
-- | components.
exampleFromComponents :: Effect Unit
exampleFromComponents = do
  monthDay <- PlainMonthDay.fromString "12-15"
  roundTripped <- PlainMonthDay.Compat.fromComponents (PlainMonthDay.Compat.toComponents monthDay)
  Console.log (PlainMonthDay.toString roundTripped)

-- | Converts a `PlainMonthDay` to its purescript-datetime `Month` and `Day`
-- | components.
exampleToComponents :: Effect Unit
exampleToComponents = do
  monthDay <- PlainMonthDay.fromString "12-15"
  let components = PlainMonthDay.Compat.toComponents monthDay
  Console.log (show components.month <> " " <> show components.day)
