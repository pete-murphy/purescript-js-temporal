-- | Compilable doc examples for JS.Temporal.PlainMonthDay.
module Examples.Docs.PlainMonthDay where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Intl.DateTimeFormat as JS.Intl.DateTimeFormat
import JS.Intl.Locale as JS.Intl.Locale
import JS.Temporal.Options.Overflow as Overflow
import JS.Temporal.PlainMonthDay as PlainMonthDay

exampleFrom_ :: Effect Unit
exampleFrom_ = do
  -- [EXAMPLE JS.Temporal.PlainMonthDay.from_]
  locale <- JS.Intl.Locale.new_ "en-US"
  holiday <- PlainMonthDay.from_ { month: 7, day: 4 }
  holidayIn2024 <- PlainMonthDay.toPlainDate { year: 2024 } holiday
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter holidayIn2024)
  -- [/EXAMPLE]

exampleFromString :: Effect Unit
exampleFromString = do
  -- [EXAMPLE JS.Temporal.PlainMonthDay.fromString]
  locale <- JS.Intl.Locale.new_ "en-US"
  birthday <- PlainMonthDay.fromString { overflow: Overflow.Constrain } "12-15"
  birthdayIn2024 <- PlainMonthDay.toPlainDate { year: 2024 } birthday
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log ("Birthday: " <> JS.Intl.DateTimeFormat.format formatter birthdayIn2024)
  -- [/EXAMPLE]

exampleWith :: Effect Unit
exampleWith = do
  -- [EXAMPLE JS.Temporal.PlainMonthDay.with]
  locale <- JS.Intl.Locale.new_ "en-US"
  original <- PlainMonthDay.fromString_ "01-15"
  changed <- PlainMonthDay.with { overflow: Overflow.Constrain } { day: 31 } original
  changedIn2024 <- PlainMonthDay.toPlainDate { year: 2024 } changed
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter changedIn2024)
  -- [/EXAMPLE]

exampleToString :: Effect Unit
exampleToString = do
  -- [EXAMPLE JS.Temporal.PlainMonthDay.toString]
  mday <- PlainMonthDay.fromString_ "03-14"
  Console.log (PlainMonthDay.toString {} mday)
  -- [/EXAMPLE]

exampleToPlainDate :: Effect Unit
exampleToPlainDate = do
  -- [EXAMPLE JS.Temporal.PlainMonthDay.toPlainDate]
  locale <- JS.Intl.Locale.new_ "en-US"
  birthday <- PlainMonthDay.fromString_ "12-15"
  birthdayIn2030 <- PlainMonthDay.toPlainDate { year: 2030 } birthday
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log ("Birthday in 2030: " <> JS.Intl.DateTimeFormat.format formatter birthdayIn2030)
  -- [/EXAMPLE]
