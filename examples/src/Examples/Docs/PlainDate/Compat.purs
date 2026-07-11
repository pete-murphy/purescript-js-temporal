-- | Compilable doc examples for JS.Temporal.PlainDate.Compat.
module Examples.Docs.PlainDate.Compat where

import Prelude

import Data.Date as Date
import Data.Date.Gen (genDate)
import Data.Enum (fromEnum)
import Effect (Effect)
import Effect.Class.Console as Console
import Examples.Docs.GenState (genState)
import JS.Temporal.PlainDate as PlainDate
import JS.Temporal.PlainDate.Compat as PlainDate.Compat
import Test.QuickCheck.Gen as Gen

-- | Converts a purescript-datetime `Date` to a `PlainDate`.
exampleFromDate :: Effect Unit
exampleFromDate = do
  let date = Gen.evalGen genDate genState
  plainDate <- PlainDate.Compat.fromDate date
  Console.log (PlainDate.toString plainDate)

-- | Converts a `PlainDate` to a purescript-datetime `Date`.
exampleToDate :: Effect Unit
exampleToDate = do
  date <- PlainDate.fromString "2024-07-01"
  let d = PlainDate.Compat.toDate date
  Console.log ("PureScript Date year: " <> show (fromEnum (Date.year d)))
