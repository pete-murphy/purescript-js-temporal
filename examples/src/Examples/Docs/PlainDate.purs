-- | Compilable doc examples for JS.Temporal.PlainDate.
module Examples.Docs.PlainDate where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Intl.DateTimeFormat as JS.Intl.DateTimeFormat
import JS.Intl.DurationFormat as JS.Intl.DurationFormat
import JS.Intl.Locale as JS.Intl.Locale
import JS.Temporal.Duration as Duration
import JS.Temporal.Now as Now
import JS.Temporal.Options.CalendarName as CalendarName
import JS.Temporal.Options.Overflow as Overflow
import JS.Temporal.Options.TemporalUnit as TemporalUnit
import JS.Temporal.PlainDate as PlainDate
import JS.Temporal.PlainDateTime as PlainDateTime
import JS.Temporal.PlainMonthDay as PlainMonthDay
import JS.Temporal.PlainTime as PlainTime
import JS.Temporal.PlainYearMonth as PlainYearMonth
import JS.Temporal.ZonedDateTime as ZonedDateTime

-- | Creates a PlainDate from component fields. Options: overflow.
exampleFromWithOptions :: Effect Unit
exampleFromWithOptions = do
  locale <- JS.Intl.Locale.new_ "en-US"
  date <- PlainDate.fromWithOptions { overflow: Overflow.Constrain } { year: 2024, month: 7, day: 1 }
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter date)

-- | Same as [`fromWithOptions`](#v:fromWithOptions) with default options.
exampleFrom :: Effect Unit
exampleFrom = do
  locale <- JS.Intl.Locale.new_ "en-US"
  date <- PlainDate.from { year: 2024, month: 7, day: 1 }
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter date)

-- | Creates a PlainDate from an RFC 9557 / ISO 8601 date string (e.g. `"2024-01-15"`).
-- | Options: overflow.
exampleFromStringWithOptions :: Effect Unit
exampleFromStringWithOptions = do
  date <- PlainDate.fromStringWithOptions { overflow: Overflow.Constrain } "2024-01-15"
  Console.log (PlainDate.toString date)

-- | Same as [`fromStringWithOptions`](#v:fromStringWithOptions) with default options.
exampleFromString :: Effect Unit
exampleFromString = do
  locale <- JS.Intl.Locale.new_ "en-US"
  date <- PlainDate.fromString "2024-01-15"
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter date)

-- | Calendar year.
exampleYear :: Effect Unit
exampleYear = do
  date <- PlainDate.fromString "2024-07-01"
  Console.log ("Year: " <> show (PlainDate.year date))

-- | Calendar month number.
exampleMonth :: Effect Unit
exampleMonth = do
  date <- PlainDate.fromString "2024-07-01"
  Console.log ("Month: " <> show (PlainDate.month date))

-- | Day of the month.
exampleDay :: Effect Unit
exampleDay = do
  date <- PlainDate.fromString "2024-07-01"
  Console.log ("Day: " <> show (PlainDate.day date))

-- | Calendar-specific month code (for example `"M01"`).
exampleMonthCode :: Effect Unit
exampleMonthCode = do
  date <- PlainDate.fromString "2024-07-01"
  Console.log ("Month code: " <> PlainDate.monthCode date)

-- | Identifier of the associated calendar (for example `"iso8601"`).
exampleCalendarId :: Effect Unit
exampleCalendarId = do
  date <- PlainDate.fromString "2024-07-01"
  Console.log ("Calendar: " <> PlainDate.calendarId date)

-- | ISO day of week, from `1` (Monday) to `7` (Sunday).
exampleDayOfWeek :: Effect Unit
exampleDayOfWeek = do
  date <- PlainDate.fromString "2024-07-01"
  Console.log ("Day of week: " <> show (PlainDate.dayOfWeek date))

-- | Day number within the year.
exampleDayOfYear :: Effect Unit
exampleDayOfYear = do
  date <- PlainDate.fromString "2024-07-01"
  Console.log ("Day of year: " <> show (PlainDate.dayOfYear date))

-- | Week number within the year, if the calendar defines week numbering.
exampleWeekOfYear :: Effect Unit
exampleWeekOfYear = do
  date <- PlainDate.fromString "2024-07-01"
  Console.log ("Week of year: " <> show (PlainDate.weekOfYear date))

-- | Week-numbering year, if the calendar defines week numbering.
exampleYearOfWeek :: Effect Unit
exampleYearOfWeek = do
  date <- PlainDate.fromString "2024-07-01"
  Console.log ("Year of week: " <> show (PlainDate.yearOfWeek date))

-- | Number of days in the current month.
exampleDaysInMonth :: Effect Unit
exampleDaysInMonth = do
  date <- PlainDate.fromString "2024-02-01"
  Console.log ("Days in Feb 2024: " <> show (PlainDate.daysInMonth date))

-- | Number of days in the current week according to the calendar.
exampleDaysInWeek :: Effect Unit
exampleDaysInWeek = do
  date <- PlainDate.fromString "2024-07-01"
  Console.log ("Days in week: " <> show (PlainDate.daysInWeek date))

-- | Number of days in the current year.
exampleDaysInYear :: Effect Unit
exampleDaysInYear = do
  date <- PlainDate.fromString "2024-07-01"
  Console.log ("Days in 2024: " <> show (PlainDate.daysInYear date))

-- | Number of months in the current year.
exampleMonthsInYear :: Effect Unit
exampleMonthsInYear = do
  date <- PlainDate.fromString "2024-07-01"
  Console.log ("Months in year: " <> show (PlainDate.monthsInYear date))

-- | Whether the current year is a leap year in this calendar.
exampleInLeapYear :: Effect Unit
exampleInLeapYear = do
  date <- PlainDate.fromString "2024-07-01"
  Console.log ("2024 is leap year: " <> show (PlainDate.inLeapYear date))

-- | Calendar era name, if this calendar uses eras.
exampleEra :: Effect Unit
exampleEra = do
  date <- PlainDate.fromString "2024-07-01"
  Console.log ("Era: " <> show (PlainDate.era date))

-- | Year number within the current era, if this calendar uses eras.
exampleEraYear :: Effect Unit
exampleEraYear = do
  date <- PlainDate.fromString "2024-07-01"
  Console.log ("Era year: " <> show (PlainDate.eraYear date))

-- | Adds a duration to a date. Supports calendar durations. Options: overflow.
exampleAddWithOptions :: Effect Unit
exampleAddWithOptions = do
  locale <- JS.Intl.Locale.new_ "en-US"
  date <- PlainDate.fromString "2024-03-15"
  oneWeek <- Duration.from { weeks: 1 }
  later <- PlainDate.addWithOptions { overflow: Overflow.Constrain } oneWeek date
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter later)

-- | Same as [`addWithOptions`](#v:addWithOptions) with default options.
exampleAdd :: Effect Unit
exampleAdd = do
  locale <- JS.Intl.Locale.new_ "en-US"
  date <- PlainDate.fromString "2024-03-15"
  oneWeek <- Duration.from { weeks: 1 }
  later <- PlainDate.add oneWeek date
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter later)

-- | Subtracts a duration. Arg order: `subtractWithOptions options duration subject`. Options: overflow.
exampleSubtractWithOptions :: Effect Unit
exampleSubtractWithOptions = do
  locale <- JS.Intl.Locale.new_ "en-US"
  date <- PlainDate.fromString "2024-03-15"
  oneWeek <- Duration.from { weeks: 1 }
  earlier <- PlainDate.subtractWithOptions { overflow: Overflow.Constrain } oneWeek date
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter earlier)

-- | Same as [`subtractWithOptions`](#v:subtractWithOptions) with default options.
exampleSubtract :: Effect Unit
exampleSubtract = do
  locale <- JS.Intl.Locale.new_ "en-US"
  date <- PlainDate.fromString "2024-03-15"
  oneWeek <- Duration.from { weeks: 1 }
  earlier <- PlainDate.subtract oneWeek date
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter earlier)

-- | Returns a new PlainDate with specified fields replaced. Because PlainDate is
-- | immutable, this is the way to "set" fields. Options: overflow.
exampleWithWithOptions :: Effect Unit
exampleWithWithOptions = do
  date <- PlainDate.fromString "2021-07-06"
  lastDay <- PlainDate.withWithOptions { overflow: Overflow.Constrain } { day: PlainDate.daysInMonth date } date
  Console.log (PlainDate.toString lastDay)

-- | Same as [`withWithOptions`](#v:withWithOptions) with default options.
exampleWith :: Effect Unit
exampleWith = do
  date <- PlainDate.fromString "2021-07-06"
  lastDay <- PlainDate.with { day: PlainDate.daysInMonth date } date
  Console.log (PlainDate.toString lastDay)

-- | Returns a new PlainDate with the given calendar (for example `"iso8601"`).
exampleWithCalendar :: Effect Unit
exampleWithCalendar = do
  date <- PlainDate.fromString "2024-01-15"
  gregory <- PlainDate.withCalendar "gregory" date
  Console.log (PlainDate.toStringWithOptions { calendarName: CalendarName.Always } gregory)

-- | Duration from `subject` (last arg) until `other` (second arg). Arg order: `until options other subject`.
-- | Options: largestUnit, smallestUnit, roundingIncrement, roundingMode.
exampleUntilWithOptions :: Effect Unit
exampleUntilWithOptions = do
  locale <- JS.Intl.Locale.new_ "en-US"
  today <- Now.plainDateISO
  futureDate <- PlainDate.fromString "2026-12-25"
  untilDuration <- PlainDate.untilWithOptions { smallestUnit: TemporalUnit.Day } futureDate today
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter untilDuration <> " until Christmas 2026")

-- | Same as [`untilWithOptions`](#v:untilWithOptions) with default options.
exampleUntil :: Effect Unit
exampleUntil = do
  start <- PlainDate.fromString "2024-01-01"
  end <- PlainDate.fromString "2024-03-15"
  duration <- PlainDate.until end start
  Console.log (Duration.toString duration)

-- | Duration from `other` to `subject` (inverse of `untilWithOptions`). Arg order: `since options other subject`.
exampleSinceWithOptions :: Effect Unit
exampleSinceWithOptions = do
  locale <- JS.Intl.Locale.new_ "en-US"
  start <- PlainDate.fromString "2024-01-01"
  end <- PlainDate.fromString "2024-03-15"
  elapsed <- PlainDate.sinceWithOptions { largestUnit: TemporalUnit.Day } start end
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log ("Elapsed: " <> JS.Intl.DurationFormat.format formatter elapsed)

-- | Same as [`sinceWithOptions`](#v:sinceWithOptions) with default options.
exampleSince :: Effect Unit
exampleSince = do
  start <- PlainDate.fromString "2024-01-01"
  end <- PlainDate.fromString "2024-03-15"
  elapsed <- PlainDate.since start end
  Console.log (Duration.toString elapsed)

-- | Combines a `PlainTime` with this date to form a `PlainDateTime`.
exampleToPlainDateTime :: Effect Unit
exampleToPlainDateTime = do
  date <- PlainDate.fromString "2024-01-15"
  time <- PlainTime.fromString "09:30:00"
  Console.log (PlainDateTime.toString (PlainDate.toPlainDateTime time date))

-- | Extracts the month and day.
exampleToPlainMonthDay :: Effect Unit
exampleToPlainMonthDay = do
  date <- PlainDate.fromString "2024-01-15"
  Console.log (PlainMonthDay.toString (PlainDate.toPlainMonthDay date))

-- | Extracts the year and month.
exampleToPlainYearMonth :: Effect Unit
exampleToPlainYearMonth = do
  date <- PlainDate.fromString "2024-01-15"
  Console.log (PlainYearMonth.toString (PlainDate.toPlainYearMonth date))

-- | Converts to a `ZonedDateTime` at the given time in the given time zone.
exampleToZonedDateTimeWithPlainTime :: Effect Unit
exampleToZonedDateTimeWithPlainTime = do
  date <- PlainDate.fromString "2024-01-15"
  time <- PlainTime.fromString "09:30:00"
  zoned <- PlainDate.toZonedDateTimeWithPlainTime "America/New_York" time date
  Console.log (ZonedDateTime.toString zoned)

-- | Converts to a `ZonedDateTime` at midnight in the given time zone.
exampleToZonedDateTime :: Effect Unit
exampleToZonedDateTime = do
  date <- PlainDate.fromString "2024-01-15"
  zoned <- PlainDate.toZonedDateTime "America/New_York" date
  Console.log (ZonedDateTime.toString zoned)

-- | Serializes to ISO 8601 date format. Options: calendarName.
exampleToStringWithOptions :: Effect Unit
exampleToStringWithOptions = do
  date <- PlainDate.fromString "2024-01-15"
  Console.log (PlainDate.toStringWithOptions { calendarName: CalendarName.Always } date)

-- | Same as [`toStringWithOptions`](#v:toStringWithOptions) with default options.
exampleToString :: Effect Unit
exampleToString = do
  date <- PlainDate.fromString "2024-01-15"
  Console.log (PlainDate.toString date)
