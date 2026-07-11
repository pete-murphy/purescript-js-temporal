-- | Compilable doc examples for JS.Temporal.PlainYearMonth.Compat.
module Examples.Docs.PlainYearMonth.Compat where

import Prelude

import Data.Date as Date
import Data.Date.Gen (genDate)
import Effect (Effect)
import Effect.Class.Console as Console
import Examples.Docs.GenState (genState)
import JS.Temporal.PlainYearMonth as PlainYearMonth
import JS.Temporal.PlainYearMonth.Compat as PlainYearMonth.Compat
import Test.QuickCheck.Gen as Gen

-- | Creates a `PlainYearMonth` from purescript-datetime `Year` and `Month`
-- | components.
exampleFromYearAndMonth :: Effect Unit
exampleFromYearAndMonth = do
  let date = Gen.evalGen genDate genState
  yearMonth <- PlainYearMonth.Compat.fromYearAndMonth (Date.year date) (Date.month date)
  Console.log (PlainYearMonth.toString yearMonth)

-- | Converts a `PlainYearMonth` to its purescript-datetime `Year` and `Month`
-- | components.
exampleToYearAndMonth :: Effect Unit
exampleToYearAndMonth = do
  yearMonth <- PlainYearMonth.fromString "2024-06"
  let yearAndMonth = PlainYearMonth.Compat.toYearAndMonth yearMonth
  Console.logShow yearAndMonth
