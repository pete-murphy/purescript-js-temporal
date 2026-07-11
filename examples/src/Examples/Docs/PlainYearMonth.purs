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

-- | Creates a PlainYearMonth from component fields. Options: overflow.
exampleFromWithOptions :: Effect Unit
exampleFromWithOptions = do
  ym <- PlainYearMonth.fromWithOptions { overflow: Overflow.Constrain } { year: 2024, month: 6 }
  Console.log (PlainYearMonth.toString ym)

-- | Same as [`fromWithOptions`](#v:fromWithOptions) with default options.
exampleFrom :: Effect Unit
exampleFrom = do
  locale <- JS.Intl.Locale.new_ "en-US"
  yearMonth <- PlainYearMonth.from { year: 2024, month: 6 }
  firstDay <- PlainYearMonth.toPlainDate { day: 1 } yearMonth
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter firstDay)

-- | Creates a PlainYearMonth from an RFC 9557 / ISO 8601 year-month string (e.g. `"2024-01"`).
-- | Options: overflow.
exampleFromStringWithOptions :: Effect Unit
exampleFromStringWithOptions = do
  ym <- PlainYearMonth.fromStringWithOptions { overflow: Overflow.Constrain } "2024-06"
  Console.log (PlainYearMonth.toString ym)

-- | Same as [`fromStringWithOptions`](#v:fromStringWithOptions) with default options.
exampleFromString :: Effect Unit
exampleFromString = do
  yearMonth <- PlainYearMonth.fromString "2024-06"
  Console.log (PlainYearMonth.toString yearMonth)

-- | ISO calendar year number.
exampleYear :: Effect Unit
exampleYear = do
  ym <- PlainYearMonth.fromString "2024-06"
  Console.log ("Year: " <> show (PlainYearMonth.year ym))

-- | Month number within the year.
exampleMonth :: Effect Unit
exampleMonth = do
  ym <- PlainYearMonth.fromString "2024-06"
  Console.log ("Month: " <> show (PlainYearMonth.month ym))

-- | Calendar-specific month code, such as `M06`.
exampleMonthCode :: Effect Unit
exampleMonthCode = do
  ym <- PlainYearMonth.fromString "2024-06"
  Console.log ("Month code: " <> PlainYearMonth.monthCode ym)

-- | Number of days in the represented month.
exampleDaysInMonth :: Effect Unit
exampleDaysInMonth = do
  ym <- PlainYearMonth.fromString "2024-02"
  Console.log ("Days in Feb 2024: " <> show (PlainYearMonth.daysInMonth ym))

-- | Number of days in the represented year.
exampleDaysInYear :: Effect Unit
exampleDaysInYear = do
  ym <- PlainYearMonth.fromString "2024-06"
  Console.log ("Days in 2024: " <> show (PlainYearMonth.daysInYear ym))

-- | Number of months in the represented year for this calendar.
exampleMonthsInYear :: Effect Unit
exampleMonthsInYear = do
  ym <- PlainYearMonth.fromString "2024-06"
  Console.log ("Months in year: " <> show (PlainYearMonth.monthsInYear ym))

-- | Whether the represented year is a leap year in this calendar.
exampleInLeapYear :: Effect Unit
exampleInLeapYear = do
  ym <- PlainYearMonth.fromString "2024-06"
  Console.log ("2024 is leap year: " <> show (PlainYearMonth.inLeapYear ym))

-- | Calendar identifier, such as `"iso8601"`.
exampleCalendarId :: Effect Unit
exampleCalendarId = do
  ym <- PlainYearMonth.fromString "2024-06"
  Console.log ("Calendar: " <> PlainYearMonth.calendarId ym)

-- | Era identifier when the calendar uses eras.
exampleEra :: Effect Unit
exampleEra = do
  ym <- PlainYearMonth.fromString "2024-06"
  Console.log ("Era: " <> show (PlainYearMonth.era ym))

-- | Year number within the current era when available.
exampleEraYear :: Effect Unit
exampleEraYear = do
  ym <- PlainYearMonth.fromString "2024-06"
  Console.log ("Era year: " <> show (PlainYearMonth.eraYear ym))

-- | Adds a duration. Options: overflow.
exampleAddWithOptions :: Effect Unit
exampleAddWithOptions = do
  ym <- PlainYearMonth.fromString "2024-06"
  threeMonths <- Duration.from { months: 3 }
  later <- PlainYearMonth.addWithOptions { overflow: Overflow.Constrain } threeMonths ym
  Console.log (PlainYearMonth.toString later)

-- | Same as [`addWithOptions`](#v:addWithOptions) with default options.
exampleAdd :: Effect Unit
exampleAdd = do
  ym <- PlainYearMonth.fromString "2024-06"
  threeMonths <- Duration.from { months: 3 }
  later <- PlainYearMonth.add threeMonths ym
  Console.log (PlainYearMonth.toString later)

-- | Subtracts a duration. Options: overflow.
exampleSubtractWithOptions :: Effect Unit
exampleSubtractWithOptions = do
  ym <- PlainYearMonth.fromString "2024-06"
  twoMonths <- Duration.from { months: 2 }
  earlier <- PlainYearMonth.subtractWithOptions { overflow: Overflow.Constrain } twoMonths ym
  Console.log (PlainYearMonth.toString earlier)

-- | Same as [`subtractWithOptions`](#v:subtractWithOptions) with default options.
exampleSubtract :: Effect Unit
exampleSubtract = do
  ym <- PlainYearMonth.fromString "2024-06"
  twoMonths <- Duration.from { months: 2 }
  earlier <- PlainYearMonth.subtract twoMonths ym
  Console.log (PlainYearMonth.toString earlier)

-- | Returns a new PlainYearMonth with specified fields replaced. Options: overflow.
exampleWithWithOptions :: Effect Unit
exampleWithWithOptions = do
  ym <- PlainYearMonth.fromString "2024-06"
  changed <- PlainYearMonth.withWithOptions { overflow: Overflow.Constrain } { month: 12 } ym
  Console.log (PlainYearMonth.toString changed)

-- | Same as [`withWithOptions`](#v:withWithOptions) with default options.
exampleWith :: Effect Unit
exampleWith = do
  ym <- PlainYearMonth.fromString "2024-06"
  changed <- PlainYearMonth.with { month: 12 } ym
  Console.log (PlainYearMonth.toString changed)

-- | Converts to PlainDate by supplying a day.
exampleToPlainDate :: Effect Unit
exampleToPlainDate = do
  locale <- JS.Intl.Locale.new_ "en-US"
  yearMonth <- PlainYearMonth.fromString "2024-01"
  firstDay <- PlainYearMonth.toPlainDate { day: 1 } yearMonth
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter firstDay)

-- | Creates a `PlainYearMonth` from purescript-datetime `Year` and `Month` components.
exampleFromDateComponents :: Effect Unit
exampleFromDateComponents = do
  yearMonth <- PlainYearMonth.fromString "2024-06"
  roundTripped <- PlainYearMonth.fromDateComponents (PlainYearMonth.toDateComponents yearMonth)
  Console.log (PlainYearMonth.toString roundTripped)

-- | Converts a `PlainYearMonth` to its purescript-datetime `Year` and `Month` components.
exampleToDateComponents :: Effect Unit
exampleToDateComponents = do
  yearMonth <- PlainYearMonth.fromString "2024-06"
  let components = PlainYearMonth.toDateComponents yearMonth
  Console.log (show components.year <> ", " <> show components.month)

-- | Duration from `subject` (last arg) until `other` (second arg). Arg order: `untilWithOptions options other subject`.
exampleUntilWithOptions :: Effect Unit
exampleUntilWithOptions = do
  locale <- JS.Intl.Locale.new_ "en-US"
  start <- PlainYearMonth.fromString "2024-01"
  end <- PlainYearMonth.fromString "2025-06"
  duration <- PlainYearMonth.untilWithOptions { largestUnit: TemporalUnit.Year } end start
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter duration)

-- | Same as [`untilWithOptions`](#v:untilWithOptions) with default options.
exampleUntil :: Effect Unit
exampleUntil = do
  start <- PlainYearMonth.fromString "2024-01"
  end <- PlainYearMonth.fromString "2025-06"
  duration <- PlainYearMonth.until end start
  Console.log (Duration.toString duration)

-- | Duration from `other` to `subject` (inverse of `untilWithOptions`). Arg order: `sinceWithOptions options other subject`.
exampleSinceWithOptions :: Effect Unit
exampleSinceWithOptions = do
  locale <- JS.Intl.Locale.new_ "en-US"
  earlier <- PlainYearMonth.fromString "2022-06"
  later <- PlainYearMonth.fromString "2024-06"
  duration <- PlainYearMonth.sinceWithOptions { largestUnit: TemporalUnit.Year } earlier later
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter duration)

-- | Same as [`sinceWithOptions`](#v:sinceWithOptions) with default options.
exampleSince :: Effect Unit
exampleSince = do
  earlier <- PlainYearMonth.fromString "2022-06"
  later <- PlainYearMonth.fromString "2024-06"
  duration <- PlainYearMonth.since earlier later
  Console.log (Duration.toString duration)

-- | Serializes to ISO 8601 year-month format. Options: calendarName.
exampleToStringWithOptions :: Effect Unit
exampleToStringWithOptions = do
  ym <- PlainYearMonth.fromString "2024-06"
  Console.log (PlainYearMonth.toStringWithOptions {} ym)

-- | Same as [`toStringWithOptions`](#v:toStringWithOptions) with default options.
exampleToString :: Effect Unit
exampleToString = do
  ym <- PlainYearMonth.fromString "2024-06"
  Console.log (PlainYearMonth.toString ym)
