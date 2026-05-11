-- | Compilable doc examples for JS.Temporal.PlainYearMonth.
module Examples.Docs.PlainYearMonth where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Intl.DateTimeFormat as JS.Intl.DateTimeFormat
import JS.Intl.DurationFormat as JS.Intl.DurationFormat
import JS.Intl.Locale as JS.Intl.Locale
import JS.Temporal.Duration as Duration
import JS.Temporal.Options.Overflow as Overflow
import JS.Temporal.Options.TemporalUnit as TemporalUnit
import JS.Temporal.PlainYearMonth as PlainYearMonth

exampleFromWithOptions :: Effect Unit
exampleFromWithOptions = do
  ym <- PlainYearMonth.fromWithOptions { overflow: Overflow.Constrain } { year: 2024, month: 6 }
  Console.log (PlainYearMonth.toString ym)

exampleFrom :: Effect Unit
exampleFrom = do
  locale <- JS.Intl.Locale.new_ "en-US"
  yearMonth <- PlainYearMonth.from { year: 2024, month: 6 }
  firstDay <- PlainYearMonth.toPlainDate { day: 1 } yearMonth
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter firstDay)

exampleFromStringWithOptions :: Effect Unit
exampleFromStringWithOptions = do
  ym <- PlainYearMonth.fromStringWithOptions { overflow: Overflow.Constrain } "2024-06"
  Console.log (PlainYearMonth.toString ym)

exampleFromString :: Effect Unit
exampleFromString = do
  yearMonth <- PlainYearMonth.fromString "2024-06"
  Console.log (PlainYearMonth.toString yearMonth)

exampleYear :: Effect Unit
exampleYear = do
  ym <- PlainYearMonth.fromString "2024-06"
  Console.log ("Year: " <> show (PlainYearMonth.year ym))

exampleMonth :: Effect Unit
exampleMonth = do
  ym <- PlainYearMonth.fromString "2024-06"
  Console.log ("Month: " <> show (PlainYearMonth.month ym))

exampleMonthCode :: Effect Unit
exampleMonthCode = do
  ym <- PlainYearMonth.fromString "2024-06"
  Console.log ("Month code: " <> PlainYearMonth.monthCode ym)

exampleDaysInMonth :: Effect Unit
exampleDaysInMonth = do
  ym <- PlainYearMonth.fromString "2024-02"
  Console.log ("Days in Feb 2024: " <> show (PlainYearMonth.daysInMonth ym))

exampleDaysInYear :: Effect Unit
exampleDaysInYear = do
  ym <- PlainYearMonth.fromString "2024-06"
  Console.log ("Days in 2024: " <> show (PlainYearMonth.daysInYear ym))

exampleMonthsInYear :: Effect Unit
exampleMonthsInYear = do
  ym <- PlainYearMonth.fromString "2024-06"
  Console.log ("Months in year: " <> show (PlainYearMonth.monthsInYear ym))

exampleInLeapYear :: Effect Unit
exampleInLeapYear = do
  ym <- PlainYearMonth.fromString "2024-06"
  Console.log ("2024 is leap year: " <> show (PlainYearMonth.inLeapYear ym))

exampleCalendarId :: Effect Unit
exampleCalendarId = do
  ym <- PlainYearMonth.fromString "2024-06"
  Console.log ("Calendar: " <> PlainYearMonth.calendarId ym)

exampleEra :: Effect Unit
exampleEra = do
  ym <- PlainYearMonth.fromString "2024-06"
  Console.log ("Era: " <> show (PlainYearMonth.era ym))

exampleEraYear :: Effect Unit
exampleEraYear = do
  ym <- PlainYearMonth.fromString "2024-06"
  Console.log ("Era year: " <> show (PlainYearMonth.eraYear ym))

exampleAddWithOptions :: Effect Unit
exampleAddWithOptions = do
  ym <- PlainYearMonth.fromString "2024-06"
  threeMonths <- Duration.from { months: 3 }
  later <- PlainYearMonth.addWithOptions { overflow: Overflow.Constrain } threeMonths ym
  Console.log (PlainYearMonth.toString later)

exampleAdd :: Effect Unit
exampleAdd = do
  ym <- PlainYearMonth.fromString "2024-06"
  threeMonths <- Duration.from { months: 3 }
  later <- PlainYearMonth.add threeMonths ym
  Console.log (PlainYearMonth.toString later)

exampleSubtractWithOptions :: Effect Unit
exampleSubtractWithOptions = do
  ym <- PlainYearMonth.fromString "2024-06"
  twoMonths <- Duration.from { months: 2 }
  earlier <- PlainYearMonth.subtractWithOptions { overflow: Overflow.Constrain } twoMonths ym
  Console.log (PlainYearMonth.toString earlier)

exampleSubtract :: Effect Unit
exampleSubtract = do
  ym <- PlainYearMonth.fromString "2024-06"
  twoMonths <- Duration.from { months: 2 }
  earlier <- PlainYearMonth.subtract twoMonths ym
  Console.log (PlainYearMonth.toString earlier)

exampleWithWithOptions :: Effect Unit
exampleWithWithOptions = do
  ym <- PlainYearMonth.fromString "2024-06"
  changed <- PlainYearMonth.withWithOptions { overflow: Overflow.Constrain } { month: 12 } ym
  Console.log (PlainYearMonth.toString changed)

exampleWith :: Effect Unit
exampleWith = do
  ym <- PlainYearMonth.fromString "2024-06"
  changed <- PlainYearMonth.with { month: 12 } ym
  Console.log (PlainYearMonth.toString changed)

exampleToPlainDate :: Effect Unit
exampleToPlainDate = do
  locale <- JS.Intl.Locale.new_ "en-US"
  yearMonth <- PlainYearMonth.fromString "2024-01"
  firstDay <- PlainYearMonth.toPlainDate { day: 1 } yearMonth
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter firstDay)

exampleUntilWithOptions :: Effect Unit
exampleUntilWithOptions = do
  locale <- JS.Intl.Locale.new_ "en-US"
  start <- PlainYearMonth.fromString "2024-01"
  end <- PlainYearMonth.fromString "2025-06"
  duration <- PlainYearMonth.untilWithOptions { largestUnit: TemporalUnit.Year } end start
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter duration)

exampleUntil :: Effect Unit
exampleUntil = do
  start <- PlainYearMonth.fromString "2024-01"
  end <- PlainYearMonth.fromString "2025-06"
  duration <- PlainYearMonth.until end start
  Console.log (Duration.toString duration)

exampleSinceWithOptions :: Effect Unit
exampleSinceWithOptions = do
  locale <- JS.Intl.Locale.new_ "en-US"
  earlier <- PlainYearMonth.fromString "2022-06"
  later <- PlainYearMonth.fromString "2024-06"
  duration <- PlainYearMonth.sinceWithOptions { largestUnit: TemporalUnit.Year } earlier later
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter duration)

exampleSince :: Effect Unit
exampleSince = do
  earlier <- PlainYearMonth.fromString "2022-06"
  later <- PlainYearMonth.fromString "2024-06"
  duration <- PlainYearMonth.since earlier later
  Console.log (Duration.toString duration)

exampleToStringWithOptions :: Effect Unit
exampleToStringWithOptions = do
  ym <- PlainYearMonth.fromString "2024-06"
  Console.log (PlainYearMonth.toStringWithOptions {} ym)

exampleToString :: Effect Unit
exampleToString = do
  ym <- PlainYearMonth.fromString "2024-06"
  Console.log (PlainYearMonth.toString ym)
