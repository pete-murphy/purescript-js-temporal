-- | Compilable doc examples for JS.Temporal.PlainYearMonth.
module Examples.Docs.PlainYearMonth where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Intl.DateTimeFormat as JS.Intl.DateTimeFormat
import JS.Intl.Locale as Locale
import JS.Temporal.PlainYearMonth as PlainYearMonth

exampleToPlainDate :: Effect Unit
exampleToPlainDate = do
  -- [EXAMPLE JS.Temporal.PlainYearMonth.toPlainDate]
  locale <- Locale.new_ "en-US"
  yearMonth <- PlainYearMonth.from_ "2024-01"
  firstDay <- PlainYearMonth.toPlainDate { day: 1 } yearMonth
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter firstDay)
  -- [/EXAMPLE]
