-- | Compilable doc examples for JS.Temporal.PlainMonthDay.
module Examples.Docs.PlainMonthDay where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Intl.DateTimeFormat as JS.Intl.DateTimeFormat
import JS.Intl.Locale as JS.Intl.Locale
import JS.Temporal.Options.Overflow as Overflow
import JS.Temporal.PlainMonthDay as PlainMonthDay

exampleFromWithOptions :: Effect Unit
exampleFromWithOptions = do
  holiday <- PlainMonthDay.fromWithOptions { overflow: Overflow.Constrain } { month: 7, day: 4 }
  Console.log (PlainMonthDay.toString holiday)

exampleFrom :: Effect Unit
exampleFrom = do
  locale <- JS.Intl.Locale.new_ "en-US"
  holiday <- PlainMonthDay.from { month: 7, day: 4 }
  holidayIn2024 <- PlainMonthDay.toPlainDate { year: 2024 } holiday
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter holidayIn2024)

exampleFromStringWithOptions :: Effect Unit
exampleFromStringWithOptions = do
  birthday <- PlainMonthDay.fromStringWithOptions { overflow: Overflow.Constrain } "12-15"
  Console.log (PlainMonthDay.toString birthday)

exampleFromString :: Effect Unit
exampleFromString = do
  birthday <- PlainMonthDay.fromString "12-15"
  Console.log (PlainMonthDay.toString birthday)

exampleMonthCode :: Effect Unit
exampleMonthCode = do
  mday <- PlainMonthDay.fromString "03-14"
  Console.log ("Month code: " <> PlainMonthDay.monthCode mday)

exampleDay :: Effect Unit
exampleDay = do
  mday <- PlainMonthDay.fromString "03-14"
  Console.log ("Day: " <> show (PlainMonthDay.day mday))

exampleCalendarId :: Effect Unit
exampleCalendarId = do
  mday <- PlainMonthDay.fromString "03-14"
  Console.log ("Calendar: " <> PlainMonthDay.calendarId mday)

exampleWithWithOptions :: Effect Unit
exampleWithWithOptions = do
  original <- PlainMonthDay.fromString "01-15"
  changed <- PlainMonthDay.withWithOptions { overflow: Overflow.Constrain } { day: 31 } original
  Console.log (PlainMonthDay.toString changed)

exampleWith :: Effect Unit
exampleWith = do
  original <- PlainMonthDay.fromString "01-15"
  changed <- PlainMonthDay.with { day: 28 } original
  Console.log (PlainMonthDay.toString changed)

exampleToPlainDate :: Effect Unit
exampleToPlainDate = do
  locale <- JS.Intl.Locale.new_ "en-US"
  birthday <- PlainMonthDay.fromString "12-15"
  birthdayIn2030 <- PlainMonthDay.toPlainDate { year: 2030 } birthday
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log ("Birthday in 2030: " <> JS.Intl.DateTimeFormat.format formatter birthdayIn2030)

exampleToStringWithOptions :: Effect Unit
exampleToStringWithOptions = do
  mday <- PlainMonthDay.fromString "03-14"
  Console.log (PlainMonthDay.toStringWithOptions {} mday)

exampleToString :: Effect Unit
exampleToString = do
  mday <- PlainMonthDay.fromString "03-14"
  Console.log (PlainMonthDay.toString mday)
