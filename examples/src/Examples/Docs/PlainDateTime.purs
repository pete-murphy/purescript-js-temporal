-- | Compilable doc examples for JS.Temporal.PlainDateTime.
module Examples.Docs.PlainDateTime where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Intl.DateTimeFormat as JS.Intl.DateTimeFormat
import JS.Intl.DurationFormat as JS.Intl.DurationFormat
import JS.Intl.Locale as JS.Intl.Locale
import JS.Intl.Options.DurationFormatStyle as JS.Intl.Options.DurationFormatStyle
import JS.Temporal.Duration as Duration
import JS.Temporal.Now as Now
import JS.Temporal.Options.Overflow as Overflow
import JS.Temporal.Options.TemporalUnit as TemporalUnit
import JS.Temporal.PlainDate as PlainDate
import JS.Temporal.PlainDateTime as PlainDateTime
import JS.Temporal.PlainTime as PlainTime
import JS.Temporal.ZonedDateTime as ZonedDateTime

-- | Creates a PlainDateTime from component fields. Options: overflow.
exampleFromWithOptions :: Effect Unit
exampleFromWithOptions = do
  locale <- JS.Intl.Locale.new_ "en-US"
  dateTime <- PlainDateTime.fromWithOptions { overflow: Overflow.Constrain }
    { year: 2024, month: 1, day: 15, hour: 9, minute: 30, second: 0 }
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter dateTime)

-- | Same as [`fromWithOptions`](#v:fromWithOptions) withWithOptions default options.
exampleFrom :: Effect Unit
exampleFrom = do
  locale <- JS.Intl.Locale.new_ "en-US"
  dateTime <- PlainDateTime.from
    { year: 2024, month: 1, day: 15, hour: 9, minute: 30, second: 0 }
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter dateTime)

-- | Parses a date-time string (e.g. `"2024-01-15T15:30:00"`). Options: overflow.
exampleFromStringWithOptions :: Effect Unit
exampleFromStringWithOptions = do
  dateTime <- PlainDateTime.fromStringWithOptions { overflow: Overflow.Constrain } "2024-01-15T09:30:00"
  Console.log (PlainDateTime.toString dateTime)

-- | Same as [`fromStringWithOptions`](#v:fromStringWithOptions) withWithOptions default options.
exampleFromString :: Effect Unit
exampleFromString = do
  locale <- JS.Intl.Locale.new_ "en-US"
  dateTime <- PlainDateTime.fromString "2024-01-15T09:30:00"
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter dateTime)

-- | ISO calendar year number.
exampleYear :: Effect Unit
exampleYear = do
  dt <- PlainDateTime.fromString "2024-07-01T09:30:00"
  Console.log ("Year: " <> show (PlainDateTime.year dt))

-- | Month number within the year.
exampleMonth :: Effect Unit
exampleMonth = do
  dt <- PlainDateTime.fromString "2024-07-01T09:30:00"
  Console.log ("Month: " <> show (PlainDateTime.month dt))

-- | Day of the month.
exampleDay :: Effect Unit
exampleDay = do
  dt <- PlainDateTime.fromString "2024-07-01T09:30:00"
  Console.log ("Day: " <> show (PlainDateTime.day dt))

-- | Calendar-specific month code, such as `M01`.
exampleMonthCode :: Effect Unit
exampleMonthCode = do
  dt <- PlainDateTime.fromString "2024-07-01T09:30:00"
  Console.log ("Month code: " <> PlainDateTime.monthCode dt)

-- | Day of the week, from `1` (Monday) to `7` (Sunday).
exampleDayOfWeek :: Effect Unit
exampleDayOfWeek = do
  dt <- PlainDateTime.fromString "2024-07-01T09:30:00"
  Console.log ("Day of week: " <> show (PlainDateTime.dayOfWeek dt))

-- | Day number within the year.
exampleDayOfYear :: Effect Unit
exampleDayOfYear = do
  dt <- PlainDateTime.fromString "2024-07-01T09:30:00"
  Console.log ("Day of year: " <> show (PlainDateTime.dayOfYear dt))

-- | Week number within the year when defined by the calendar.
exampleWeekOfYear :: Effect Unit
exampleWeekOfYear = do
  dt <- PlainDateTime.fromString "2024-07-01T09:30:00"
  Console.log ("Week of year: " <> show (PlainDateTime.weekOfYear dt))

-- | Week-numbering year when defined by the calendar.
exampleYearOfWeek :: Effect Unit
exampleYearOfWeek = do
  dt <- PlainDateTime.fromString "2024-07-01T09:30:00"
  Console.log ("Year of week: " <> show (PlainDateTime.yearOfWeek dt))

-- | Number of days in the month.
exampleDaysInMonth :: Effect Unit
exampleDaysInMonth = do
  dt <- PlainDateTime.fromString "2024-02-01T00:00:00"
  Console.log ("Days in Feb 2024: " <> show (PlainDateTime.daysInMonth dt))

-- | Number of days in the year.
exampleDaysInYear :: Effect Unit
exampleDaysInYear = do
  dt <- PlainDateTime.fromString "2024-07-01T00:00:00"
  Console.log ("Days in 2024: " <> show (PlainDateTime.daysInYear dt))

-- | Number of days in the week for this calendar.
exampleDaysInWeek :: Effect Unit
exampleDaysInWeek = do
  dt <- PlainDateTime.fromString "2024-07-01T00:00:00"
  Console.log ("Days in week: " <> show (PlainDateTime.daysInWeek dt))

-- | Number of months in the year for this calendar.
exampleMonthsInYear :: Effect Unit
exampleMonthsInYear = do
  dt <- PlainDateTime.fromString "2024-07-01T00:00:00"
  Console.log ("Months in year: " <> show (PlainDateTime.monthsInYear dt))

-- | Whether the year is a leap year in this calendar.
exampleInLeapYear :: Effect Unit
exampleInLeapYear = do
  dt <- PlainDateTime.fromString "2024-07-01T00:00:00"
  Console.log ("2024 is leap year: " <> show (PlainDateTime.inLeapYear dt))

-- | Calendar identifier, such as `"iso8601"`.
exampleCalendarId :: Effect Unit
exampleCalendarId = do
  dt <- PlainDateTime.fromString "2024-07-01T00:00:00"
  Console.log ("Calendar: " <> PlainDateTime.calendarId dt)

-- | Era identifier when the calendar uses eras.
exampleEra :: Effect Unit
exampleEra = do
  dt <- PlainDateTime.fromString "2024-07-01T00:00:00"
  Console.log ("Era: " <> show (PlainDateTime.era dt))

-- | Year number within the current era when available.
exampleEraYear :: Effect Unit
exampleEraYear = do
  dt <- PlainDateTime.fromString "2024-07-01T00:00:00"
  Console.log ("Era year: " <> show (PlainDateTime.eraYear dt))

-- | Hour component.
exampleHour :: Effect Unit
exampleHour = do
  dt <- PlainDateTime.fromString "2024-07-01T14:30:45"
  Console.log ("Hour: " <> show (PlainDateTime.hour dt))

-- | Minute component.
exampleMinute :: Effect Unit
exampleMinute = do
  dt <- PlainDateTime.fromString "2024-07-01T14:30:45"
  Console.log ("Minute: " <> show (PlainDateTime.minute dt))

-- | Second component.
exampleSecond :: Effect Unit
exampleSecond = do
  dt <- PlainDateTime.fromString "2024-07-01T14:30:45"
  Console.log ("Second: " <> show (PlainDateTime.second dt))

-- | Millisecond component.
exampleMillisecond :: Effect Unit
exampleMillisecond = do
  dt <- PlainDateTime.fromString "2024-07-01T14:30:45.123"
  Console.log ("Millisecond: " <> show (PlainDateTime.millisecond dt))

-- | Microsecond component.
exampleMicrosecond :: Effect Unit
exampleMicrosecond = do
  dt <- PlainDateTime.fromString "2024-07-01T14:30:45.123456"
  Console.log ("Microsecond: " <> show (PlainDateTime.microsecond dt))

-- | Nanosecond component.
exampleNanosecond :: Effect Unit
exampleNanosecond = do
  dt <- PlainDateTime.fromString "2024-07-01T14:30:45.123456789"
  Console.log ("Nanosecond: " <> show (PlainDateTime.nanosecond dt))

-- | Adds a duration. Arg order: `addWithOptions options duration subject`. Options: overflow.
exampleAddWithOptions :: Effect Unit
exampleAddWithOptions = do
  start <- PlainDateTime.fromString "2024-01-15T09:00:00"
  twoHours <- Duration.from { hours: 2 }
  end <- PlainDateTime.addWithOptions { overflow: Overflow.Constrain } twoHours start
  Console.log (PlainDateTime.toString end)

-- | Same as [`addWithOptions`](#v:addWithOptions) with default options.
exampleAdd :: Effect Unit
exampleAdd = do
  start <- PlainDateTime.fromString "2024-01-15T09:00:00"
  twoHours <- Duration.from { hours: 2 }
  end <- PlainDateTime.add twoHours start
  Console.log (PlainDateTime.toString end)

-- | Subtracts a duration. Arg order: `subtractWithOptions options duration subject` (subject minus duration).
-- | Options: overflow.
exampleSubtractWithOptions :: Effect Unit
exampleSubtractWithOptions = do
  start <- PlainDateTime.fromString "2024-01-15T11:00:00"
  twoHours <- Duration.from { hours: 2 }
  earlier <- PlainDateTime.subtractWithOptions { overflow: Overflow.Constrain } twoHours start
  Console.log (PlainDateTime.toString earlier)

-- | Same as [`subtractWithOptions`](#v:subtractWithOptions) with default options.
exampleSubtract :: Effect Unit
exampleSubtract = do
  start <- PlainDateTime.fromString "2024-01-15T11:00:00"
  twoHours <- Duration.from { hours: 2 }
  earlier <- PlainDateTime.subtract twoHours start
  Console.log (PlainDateTime.toString earlier)

-- | Returns a new PlainDateTime with specified fields replaced. Options: overflow.
exampleWithWithOptions :: Effect Unit
exampleWithWithOptions = do
  dateTime <- PlainDateTime.fromString "2024-01-15T09:30:45"
  noon <- PlainDateTime.withWithOptions { overflow: Overflow.Constrain } { hour: 12, minute: 0, second: 0 } dateTime
  Console.log (PlainDateTime.toString noon)

-- | Same as [`withWithOptions`](#v:withWithOptions) with default options.
exampleWith :: Effect Unit
exampleWith = do
  dateTime <- PlainDateTime.fromString "2024-01-15T09:30:45"
  noon <- PlainDateTime.with { hour: 12, minute: 0, second: 0 } dateTime
  Console.log (PlainDateTime.toString noon)

-- | Returns a new PlainDateTime with the time component replaced.
exampleWithPlainTime :: Effect Unit
exampleWithPlainTime = do
  dateTime <- PlainDateTime.fromString "2024-01-15T09:30:00"
  closingTime <- PlainTime.fromString "17:00:00"
  updated <- PlainDateTime.withPlainTime closingTime dateTime
  Console.log (PlainDateTime.toString updated)

-- | Returns a new PlainDateTime that uses a different calendar.
exampleWithCalendar :: Effect Unit
exampleWithCalendar = do
  dateTime <- PlainDateTime.fromString "2019-05-01T09:30:00"
  japanese <- PlainDateTime.withCalendar "japanese" dateTime
  Console.log (PlainDateTime.calendarId japanese)

-- | Computes the duration from `subject` (last arg) until `other` (second arg).
-- | Positive when `other` is later. Arg order: `untilWithOptions options other subject`.
-- |
-- | Options: largestUnit, smallestUnit, roundingIncrement, roundingMode.
exampleUntilWithOptions :: Effect Unit
exampleUntilWithOptions = do
  locale <- JS.Intl.Locale.new_ "en-US"
  now <- Now.plainDateTimeISO
    >>= PlainDateTime.round { smallestUnit: TemporalUnit.Second }
  nextBilling <- do
    aprilFirst <- PlainDateTime.from
      { year: PlainDateTime.year now, month: 4, day: 1 }
    if aprilFirst < now then do
      oneYear <- Duration.from { years: 1 }
      PlainDateTime.add oneYear aprilFirst
    else
      pure aprilFirst
  duration <- PlainDateTime.untilWithOptions
    { smallestUnit: TemporalUnit.Day }
    nextBilling
    now
  durationFormatter <- JS.Intl.DurationFormat.new [ locale ] { style: JS.Intl.Options.DurationFormatStyle.Long }
  Console.log (JS.Intl.DurationFormat.format durationFormatter duration <> " until next billing")

-- | Same as [`untilWithOptions`](#v:untilWithOptions) with default options.
exampleUntil :: Effect Unit
exampleUntil = do
  start <- PlainDateTime.fromString "2024-01-01T00:00:00"
  end <- PlainDateTime.fromString "2024-03-15T12:00:00"
  duration <- PlainDateTime.until end start
  Console.log (Duration.toString duration)

-- | Duration from `other` to `subject` (inverse of `untilWithOptions`). Arg order: `sinceWithOptions options other subject`.
exampleSinceWithOptions :: Effect Unit
exampleSinceWithOptions = do
  locale <- JS.Intl.Locale.new_ "en-US"
  start <- PlainDateTime.fromString "2024-01-01T00:00:00"
  end <- PlainDateTime.fromString "2024-03-15T12:00:00"
  elapsed <- PlainDateTime.sinceWithOptions { largestUnit: TemporalUnit.Day } start end
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: JS.Intl.Options.DurationFormatStyle.Long }
  Console.log ("Elapsed: " <> JS.Intl.DurationFormat.format formatter elapsed)

-- | Same as [`sinceWithOptions`](#v:sinceWithOptions) with default options.
exampleSince :: Effect Unit
exampleSince = do
  start <- PlainDateTime.fromString "2024-01-01T00:00:00"
  end <- PlainDateTime.fromString "2024-03-15T12:00:00"
  elapsed <- PlainDateTime.since start end
  Console.log (Duration.toString elapsed)

-- | Rounds to a specified unit. Options: smallestUnit, roundingIncrement, roundingMode.
exampleRound :: Effect Unit
exampleRound = do
  dateTime <- PlainDateTime.fromString "2024-01-15T09:30:45.123"
  rounded <- PlainDateTime.round { smallestUnit: TemporalUnit.Minute } dateTime
  Console.log (PlainDateTime.toString rounded)

-- | Serializes to ISO 8601 format. Options: fractionalSecondDigits, smallestUnit, roundingMode, calendarName.
exampleToStringWithOptions :: Effect Unit
exampleToStringWithOptions = do
  dateTime <- PlainDateTime.fromString "2024-01-15T09:30:00"
  Console.log (PlainDateTime.toStringWithOptions { smallestUnit: TemporalUnit.Minute } dateTime)

-- | Default ISO 8601 serialization (no options).
exampleToString :: Effect Unit
exampleToString = do
  dateTime <- PlainDateTime.fromString "2024-01-15T09:30:00"
  Console.log (PlainDateTime.toString dateTime)

-- | Converts a purescript-datetime `DateTime` to a `PlainDateTime`.
exampleFromDateTime :: Effect Unit
exampleFromDateTime = do
  dt <- PlainDateTime.fromString "2024-07-01T12:00:00"
  roundTripped <- PlainDateTime.fromDateTime (PlainDateTime.toDateTime dt)
  Console.log (PlainDateTime.toString roundTripped)

-- | Converts a `PlainDateTime` to a purescript-datetime `DateTime`.
exampleToDateTime :: Effect Unit
exampleToDateTime = do
  dt <- PlainDateTime.fromString "2024-07-01T12:00:00"
  Console.log (show (PlainDateTime.toDateTime dt))

-- | Extracts the date component.
exampleToPlainDate :: Effect Unit
exampleToPlainDate = do
  dateTime <- PlainDateTime.fromString "2024-01-15T09:30:00"
  Console.log (PlainDate.toString (PlainDateTime.toPlainDate dateTime))

-- | Extracts the time component.
exampleToPlainTime :: Effect Unit
exampleToPlainTime = do
  dateTime <- PlainDateTime.fromString "2024-01-15T09:30:00"
  Console.log (PlainTime.toString (PlainDateTime.toPlainTime dateTime))

-- | Interprets this date-time as occurring in the given time zone.
exampleToZonedDateTime :: Effect Unit
exampleToZonedDateTime = do
  plain <- PlainDateTime.fromString "2024-01-15T09:30:00"
  zoned <- PlainDateTime.toZonedDateTime "America/New_York" plain
  Console.log (ZonedDateTime.toString zoned)
