-- | Compilable doc examples for JS.Temporal.PlainDate.Compat.
module Examples.Docs.PlainDate.Compat where

import Prelude

import Data.Date as Date
import Data.Enum (fromEnum)
import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.PlainDate as PlainDate
import JS.Temporal.PlainDate.Compat as PlainDate.Compat

-- | Converts a purescript-datetime `Date` to a `PlainDate`.
exampleFromDate :: Effect Unit
exampleFromDate = do
  date <- PlainDate.fromString "2024-07-01"
  roundTripped <- PlainDate.Compat.fromDate (PlainDate.Compat.toDate date)
  Console.log (PlainDate.toString roundTripped)

-- | Converts a `PlainDate` to a purescript-datetime `Date`.
exampleToDate :: Effect Unit
exampleToDate = do
  date <- PlainDate.fromString "2024-07-01"
  let d = PlainDate.Compat.toDate date
  Console.log ("PureScript Date year: " <> show (fromEnum (Date.year d)))
