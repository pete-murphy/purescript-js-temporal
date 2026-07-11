-- | Compilable doc examples for JS.Temporal.PlainMonthDay.Compat.
module Examples.Docs.PlainMonthDay.Compat where

import Prelude

import Data.Date as Date
import Data.Date.Gen (genDate)
import Effect (Effect)
import Effect.Class.Console as Console
import Examples.Docs.GenState (genState)
import JS.Temporal.PlainMonthDay as PlainMonthDay
import JS.Temporal.PlainMonthDay.Compat as PlainMonthDay.Compat
import Test.QuickCheck.Gen as Gen

-- | Creates a `PlainMonthDay` from purescript-datetime `Month` and `Day`
-- | components.
exampleFromMonthAndDay :: Effect Unit
exampleFromMonthAndDay = do
  let date = Gen.evalGen genDate genState
  monthDay <- PlainMonthDay.Compat.fromMonthAndDay (Date.month date) (Date.day date)
  Console.log (PlainMonthDay.toString monthDay)

-- | Converts a `PlainMonthDay` to its purescript-datetime `Month` and `Day`
-- | components.
exampleToMonthAndDay :: Effect Unit
exampleToMonthAndDay = do
  monthDay <- PlainMonthDay.fromString "12-15"
  let monthAndDay = PlainMonthDay.Compat.toMonthAndDay monthDay
  Console.logShow monthAndDay
