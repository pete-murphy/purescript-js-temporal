-- | Compilable doc examples for JS.Temporal.PlainMonthDay.
module Examples.Docs.PlainMonthDay where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Intl.DateTimeFormat as JS.Intl.DateTimeFormat
import JS.Intl.Locale as Locale
import JS.Temporal.PlainMonthDay as PlainMonthDay

exampleToPlainDate :: Effect Unit
exampleToPlainDate = do
  -- [EXAMPLE JS.Temporal.PlainMonthDay.toPlainDate]
  locale <- Locale.new_ "en-US"
  birthday <- PlainMonthDay.from_ "12-15"
  birthdayIn2030 <- PlainMonthDay.toPlainDate { year: 2030 } birthday
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log ("Birthday in 2030: " <> JS.Intl.DateTimeFormat.format formatter birthdayIn2030)
  -- [/EXAMPLE]
