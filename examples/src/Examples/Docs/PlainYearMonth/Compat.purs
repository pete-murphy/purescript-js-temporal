-- | Compilable doc examples for JS.Temporal.PlainYearMonth.Compat.
module Examples.Docs.PlainYearMonth.Compat where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.PlainYearMonth as PlainYearMonth
import JS.Temporal.PlainYearMonth.Compat as PlainYearMonth.Compat

-- | Creates a `PlainYearMonth` from purescript-datetime `Year` and `Month`
-- | components.
exampleFromComponents :: Effect Unit
exampleFromComponents = do
  yearMonth <- PlainYearMonth.fromString "2024-06"
  roundTripped <- PlainYearMonth.Compat.fromComponents (PlainYearMonth.Compat.toComponents yearMonth)
  Console.log (PlainYearMonth.toString roundTripped)

-- | Converts a `PlainYearMonth` to its purescript-datetime `Year` and `Month`
-- | components.
exampleToComponents :: Effect Unit
exampleToComponents = do
  yearMonth <- PlainYearMonth.fromString "2024-06"
  let components = PlainYearMonth.Compat.toComponents yearMonth
  Console.log (show components.year <> ", " <> show components.month)
