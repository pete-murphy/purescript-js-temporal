-- | Compilable doc examples for JS.Temporal.ZonedDateTime.
module Examples.Docs.ZonedDateTime where

import Prelude

import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Class.Console as Console
import JS.BigInt as BigInt
import JS.Intl.DateTimeFormat as JS.Intl.DateTimeFormat
import JS.Intl.DurationFormat as JS.Intl.DurationFormat
import JS.Intl.Locale as JS.Intl.Locale
import JS.Temporal.Duration as Duration
import JS.Temporal.Instant as Instant
import JS.Temporal.Options.CalendarName as CalendarName
import JS.Temporal.Options.Overflow as Overflow
import JS.Temporal.Options.RoundingMode as RoundingMode
import JS.Temporal.Options.TemporalUnit as TemporalUnit
import JS.Temporal.PlainDate as PlainDate
import JS.Temporal.PlainDateTime as PlainDateTime
import JS.Temporal.PlainMonthDay as PlainMonthDay
import JS.Temporal.PlainTime as PlainTime
import JS.Temporal.PlainYearMonth as PlainYearMonth
import JS.Temporal.ZonedDateTime as ZonedDateTime

-- | Creates a ZonedDateTime from component fields. Options: overflow, disambiguation, offset.
exampleFromWithOptions :: Effect Unit
exampleFromWithOptions = do
  zoned <- ZonedDateTime.fromWithOptions { overflow: Overflow.Constrain }
    { year: 2024, month: 1, day: 15, hour: 12, minute: 0, second: 0, timeZone: "America/New_York" }
  Console.log (ZonedDateTime.toString zoned)

-- | Same as [`fromWithOptions`](#v:fromWithOptions) with default options.
exampleFrom :: Effect Unit
exampleFrom = do
  zoned <- ZonedDateTime.from
    { year: 2024, month: 1, day: 15, hour: 12, minute: 0, second: 0, timeZone: "America/New_York" }
  Console.log (ZonedDateTime.toString zoned)

-- | Parses an ISO 8601 string with time zone (e.g. `"2024-01-15T12:00-05:00[America/New_York]"`). Options: overflow, disambiguation, offset.
exampleFromStringWithOptions :: Effect Unit
exampleFromStringWithOptions = do
  zoned <- ZonedDateTime.fromStringWithOptions { overflow: Overflow.Constrain } "2024-01-15T12:00:00-05:00[America/New_York]"
  Console.log (ZonedDateTime.toString zoned)

-- | Same as [`fromStringWithOptions`](#v:fromStringWithOptions) with default options.
exampleFromString :: Effect Unit
exampleFromString = do
  zoned <- ZonedDateTime.fromString "1970-01-01T00:00:00+00:00[UTC]"
  Console.log (ZonedDateTime.toString zoned)

-- | Calendar year in this zoned date-time's calendar.
exampleYear :: Effect Unit
exampleYear = do
  zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
  Console.log ("Year: " <> show (ZonedDateTime.year zoned))

-- | Calendar month number in this zoned date-time's calendar.
exampleMonth :: Effect Unit
exampleMonth = do
  zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
  Console.log ("Month: " <> show (ZonedDateTime.month zoned))

-- | Day of the month in this zoned date-time's calendar.
exampleDay :: Effect Unit
exampleDay = do
  zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
  Console.log ("Day: " <> show (ZonedDateTime.day zoned))

-- | Calendar-specific month code (for example `"M01"`).
exampleMonthCode :: Effect Unit
exampleMonthCode = do
  zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
  Console.log ("Month code: " <> ZonedDateTime.monthCode zoned)

-- | Hour of the day in the zoned wall-clock view.
exampleHour :: Effect Unit
exampleHour = do
  zoned <- ZonedDateTime.fromString "2024-07-01T14:30:00[America/New_York]"
  Console.log ("Hour: " <> show (ZonedDateTime.hour zoned))

-- | Minute of the hour in the zoned wall-clock view.
exampleMinute :: Effect Unit
exampleMinute = do
  zoned <- ZonedDateTime.fromString "2024-07-01T14:30:00[America/New_York]"
  Console.log ("Minute: " <> show (ZonedDateTime.minute zoned))

-- | Second of the minute in the zoned wall-clock view.
exampleSecond :: Effect Unit
exampleSecond = do
  zoned <- ZonedDateTime.fromString "2024-07-01T14:30:45[America/New_York]"
  Console.log ("Second: " <> show (ZonedDateTime.second zoned))

-- | Millisecond of the second in the zoned wall-clock view.
exampleMillisecond :: Effect Unit
exampleMillisecond = do
  zoned <- ZonedDateTime.fromString "2024-07-01T14:30:45.123[America/New_York]"
  Console.log ("Millisecond: " <> show (ZonedDateTime.millisecond zoned))

-- | Microsecond of the millisecond in the zoned wall-clock view.
exampleMicrosecond :: Effect Unit
exampleMicrosecond = do
  zoned <- ZonedDateTime.fromString "2024-07-01T14:30:45.123456[America/New_York]"
  Console.log ("Microsecond: " <> show (ZonedDateTime.microsecond zoned))

-- | Nanosecond of the microsecond in the zoned wall-clock view.
exampleNanosecond :: Effect Unit
exampleNanosecond = do
  zoned <- ZonedDateTime.fromString "2024-07-01T14:30:45.123456789[America/New_York]"
  Console.log ("Nanosecond: " <> show (ZonedDateTime.nanosecond zoned))

-- | ISO day of week, from `1` (Monday) to `7` (Sunday).
exampleDayOfWeek :: Effect Unit
exampleDayOfWeek = do
  zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
  Console.log ("Day of week: " <> show (ZonedDateTime.dayOfWeek zoned))

-- | Day number within the year in this zoned date-time's calendar.
exampleDayOfYear :: Effect Unit
exampleDayOfYear = do
  zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
  Console.log ("Day of year: " <> show (ZonedDateTime.dayOfYear zoned))

-- | Week number within the year, if the calendar defines week numbering.
exampleWeekOfYear :: Effect Unit
exampleWeekOfYear = do
  zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
  Console.log ("Week of year: " <> show (ZonedDateTime.weekOfYear zoned))

-- | Week-numbering year, if the calendar defines week numbering.
exampleYearOfWeek :: Effect Unit
exampleYearOfWeek = do
  zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
  Console.log ("Year of week: " <> show (ZonedDateTime.yearOfWeek zoned))

-- | Number of days in the current month.
exampleDaysInMonth :: Effect Unit
exampleDaysInMonth = do
  zoned <- ZonedDateTime.fromString "2024-02-01T12:00:00[America/New_York]"
  Console.log ("Days in Feb 2024: " <> show (ZonedDateTime.daysInMonth zoned))

-- | Number of days in the current year.
exampleDaysInYear :: Effect Unit
exampleDaysInYear = do
  zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
  Console.log ("Days in 2024: " <> show (ZonedDateTime.daysInYear zoned))

-- | Number of days in the current week according to the calendar.
exampleDaysInWeek :: Effect Unit
exampleDaysInWeek = do
  zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
  Console.log ("Days in week: " <> show (ZonedDateTime.daysInWeek zoned))

-- | Number of months in the current year.
exampleMonthsInYear :: Effect Unit
exampleMonthsInYear = do
  zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
  Console.log ("Months in year: " <> show (ZonedDateTime.monthsInYear zoned))

-- | Whether the current year is a leap year in this calendar.
exampleInLeapYear :: Effect Unit
exampleInLeapYear = do
  zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
  Console.log ("2024 is leap year: " <> show (ZonedDateTime.inLeapYear zoned))

-- | Identifier of the current calendar (for example `"iso8601"`).
exampleCalendarId :: Effect Unit
exampleCalendarId = do
  zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
  Console.log ("Calendar: " <> ZonedDateTime.calendarId zoned)

-- | Calendar era name, if this calendar uses eras.
exampleEra :: Effect Unit
exampleEra = do
  zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
  Console.log ("Era: " <> show (ZonedDateTime.era zoned))

-- | Year number within the current era, if this calendar uses eras.
exampleEraYear :: Effect Unit
exampleEraYear = do
  zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
  Console.log ("Era year: " <> show (ZonedDateTime.eraYear zoned))

-- | Identifier of the associated time zone (for example `"America/New_York"`).
exampleTimeZoneId :: Effect Unit
exampleTimeZoneId = do
  zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
  Console.log ("Time zone: " <> ZonedDateTime.timeZoneId zoned)

-- | Numeric UTC offset string for this instant in the associated time zone.
exampleOffset :: Effect Unit
exampleOffset = do
  zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
  Console.log ("Offset: " <> ZonedDateTime.offset zoned)

-- | UTC offset for this instant, in nanoseconds.
exampleOffsetNanoseconds :: Effect Unit
exampleOffsetNanoseconds = do
  zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
  Console.log ("Offset ns: " <> show (ZonedDateTime.offsetNanoseconds zoned))

-- | Number of wall-clock hours in this calendar day in the associated time zone.
exampleHoursInDay :: Effect Unit
exampleHoursInDay = do
  zoned <- ZonedDateTime.fromString "2024-03-10T12:00:00[America/New_York]"
  Console.log ("Hours in day (DST spring forward): " <> show (ZonedDateTime.hoursInDay zoned))

-- | Milliseconds since the Unix epoch for the represented instant.
exampleEpochMilliseconds :: Effect Unit
exampleEpochMilliseconds = do
  zoned <- ZonedDateTime.fromString "1970-01-01T00:00:01+00:00[UTC]"
  Console.log ("Epoch ms: " <> show (ZonedDateTime.epochMilliseconds zoned))

-- | Nanoseconds since the Unix epoch for the represented instant.
exampleEpochNanoseconds :: Effect Unit
exampleEpochNanoseconds = do
  zoned <- ZonedDateTime.fromString "1970-01-01T00:00:01+00:00[UTC]"
  Console.log ("Epoch ns: " <> show (ZonedDateTime.epochNanoseconds zoned))

-- | Adds a duration. Supports calendar durations. Options: overflow.
exampleAddWithOptions :: Effect Unit
exampleAddWithOptions = do
  start <- ZonedDateTime.fromString "2024-01-15T12:00:00-05:00[America/New_York]"
  twoHours <- Duration.from { hours: 2 }
  later <- ZonedDateTime.addWithOptions { overflow: Overflow.Constrain } twoHours start
  Console.log (ZonedDateTime.toString later)

-- | Same as [`addWithOptions`](#v:addWithOptions) with default options.
exampleAdd :: Effect Unit
exampleAdd = do
  start <- ZonedDateTime.fromString "2024-01-15T12:00:00-05:00[America/New_York]"
  twoHours <- Duration.from { hours: 2 }
  later <- ZonedDateTime.add twoHours start
  Console.log (ZonedDateTime.toString later)

-- | Subtracts a duration. Arg order: `subtractWithOptions options duration subject`.
exampleSubtractWithOptions :: Effect Unit
exampleSubtractWithOptions = do
  zoned <- ZonedDateTime.fromString "2024-03-15T14:00:00[America/New_York]"
  twoHours <- Duration.from { hours: 2 }
  earlier <- ZonedDateTime.subtractWithOptions { overflow: Overflow.Constrain } twoHours zoned
  Console.log (ZonedDateTime.toString earlier)

-- | Same as [`subtractWithOptions`](#v:subtractWithOptions) with default options.
exampleSubtract :: Effect Unit
exampleSubtract = do
  zoned <- ZonedDateTime.fromString "2024-03-15T14:00:00[America/New_York]"
  twoHours <- Duration.from { hours: 2 }
  earlier <- ZonedDateTime.subtract twoHours zoned
  Console.log (ZonedDateTime.toString earlier)

-- | Returns a copy with some wall-clock fields replaced. Options: overflow,
-- | disambiguation, offset.
exampleWithWithOptions :: Effect Unit
exampleWithWithOptions = do
  meeting <- ZonedDateTime.fromString "2024-01-15T09:30:45-05:00[America/New_York]"
  noon <- ZonedDateTime.withWithOptions { overflow: Overflow.Constrain } { hour: 12, minute: 0, second: 0 } meeting
  Console.log (ZonedDateTime.toString noon)

-- | Same as [`withWithOptions`](#v:withWithOptions) with default options.
exampleWith :: Effect Unit
exampleWith = do
  meeting <- ZonedDateTime.fromString "2024-01-15T09:30:45-05:00[America/New_York]"
  noon <- ZonedDateTime.with { hour: 12, minute: 0, second: 0 } meeting
  Console.log (ZonedDateTime.toString noon)

-- | Returns the same instant interpreted in a different time zone.
exampleWithTimeZone :: Effect Unit
exampleWithTimeZone = do
  zoned <- ZonedDateTime.fromString "2024-01-15T12:00:00-05:00[America/New_York]"
  inTokyo <- ZonedDateTime.withTimeZone "Asia/Tokyo" zoned
  Console.log (ZonedDateTime.toString inTokyo)

-- | Returns a copy with the same instant and time zone, but a different calendar.
exampleWithCalendar :: Effect Unit
exampleWithCalendar = do
  zoned <- ZonedDateTime.fromString "2024-01-15T12:00:00-05:00[America/New_York]"
  gregory <- ZonedDateTime.withCalendar "gregory" zoned
  Console.log (ZonedDateTime.toStringWithOptions { calendarName: CalendarName.Always } gregory)

-- | Returns a copy with the wall-clock time replaced.
exampleWithPlainTime :: Effect Unit
exampleWithPlainTime = do
  zoned <- ZonedDateTime.fromString "2024-01-15T09:30:45-05:00[America/New_York]"
  closingTime <- PlainTime.fromString "17:00:00"
  updated <- ZonedDateTime.withPlainTime closingTime zoned
  Console.log (ZonedDateTime.toString updated)

-- | Returns a copy with the calendar date replaced.
exampleWithPlainDate :: Effect Unit
exampleWithPlainDate = do
  zoned <- ZonedDateTime.fromString "2024-01-15T09:30:45-05:00[America/New_York]"
  nextDay <- PlainDate.fromString "2024-01-16"
  updated <- ZonedDateTime.withPlainDate nextDay zoned
  Console.log (ZonedDateTime.toString updated)

-- | Duration from `subject` (last arg) until `other` (second arg). Arg order: `untilWithOptions options other subject`.
exampleUntilWithOptions :: Effect Unit
exampleUntilWithOptions = do
  locale <- JS.Intl.Locale.new_ "en-US"
  departure <- ZonedDateTime.fromString "2020-03-08T11:55:00+08:00[Asia/Hong_Kong]"
  arrival <- ZonedDateTime.fromString "2020-03-08T09:50:00-07:00[America/Los_Angeles]"
  flightTime <- ZonedDateTime.untilWithOptions { largestUnit: TemporalUnit.Hour } arrival departure
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log ("Flight time: " <> JS.Intl.DurationFormat.format formatter flightTime)

-- | Same as [`untilWithOptions`](#v:untilWithOptions) with default options. Arg order: `until other subject`.
exampleUntil :: Effect Unit
exampleUntil = do
  start <- ZonedDateTime.fromString "2024-01-01T00:00:00[America/New_York]"
  end <- ZonedDateTime.fromString "2024-01-02T00:00:00[America/New_York]"
  duration <- ZonedDateTime.until end start
  Console.log (Duration.toString duration)

-- | Duration from `other` to `subject` (inverse of `untilWithOptions`). Arg order: `sinceWithOptions options other subject`.
exampleSinceWithOptions :: Effect Unit
exampleSinceWithOptions = do
  locale <- JS.Intl.Locale.new_ "en-US"
  start <- ZonedDateTime.fromString "2024-01-01T00:00:00[America/New_York]"
  end <- ZonedDateTime.fromString "2024-03-15T12:00:00[America/New_York]"
  elapsed <- ZonedDateTime.sinceWithOptions { largestUnit: TemporalUnit.Hour } start end
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log ("Elapsed: " <> JS.Intl.DurationFormat.format formatter elapsed)

-- | Same as [`sinceWithOptions`](#v:sinceWithOptions) with default options. Arg order: `since other subject`.
exampleSince :: Effect Unit
exampleSince = do
  start <- ZonedDateTime.fromString "2024-01-01T00:00:00[America/New_York]"
  end <- ZonedDateTime.fromString "2024-03-15T12:00:00[America/New_York]"
  elapsed <- ZonedDateTime.since start end
  Console.log (Duration.toString elapsed)

-- | Rounds this zoned date-time to a smaller unit. Options: smallestUnit,
-- | roundingIncrement, roundingMode.
exampleRound :: Effect Unit
exampleRound = do
  zoned <- ZonedDateTime.fromString "2024-01-15T09:30:45.123456789-05:00[America/New_York]"
  rounded <- ZonedDateTime.round { smallestUnit: TemporalUnit.Minute, roundingMode: RoundingMode.HalfExpand } zoned
  Console.log (ZonedDateTime.toString rounded)

-- | Returns the start of the calendar day in this time zone.
exampleStartOfDay :: Effect Unit
exampleStartOfDay = do
  zoned <- ZonedDateTime.fromString "2024-03-10T12:00:00-04:00[America/New_York]"
  start <- ZonedDateTime.startOfDay zoned
  Console.log (ZonedDateTime.toString start)

-- | Gets the next or previous time zone transition. Direction: `"next"` or `"previous"`.
exampleGetTimeZoneTransition :: Effect Unit
exampleGetTimeZoneTransition = do
  zoned <- ZonedDateTime.fromString "2024-03-09T12:00:00-05:00[America/New_York]"
  case ZonedDateTime.getTimeZoneTransition "next" zoned of
    Nothing -> Console.log "No transition"
    Just transition -> Console.log (ZonedDateTime.toString transition)

-- | Extracts the absolute instant (no time zone).
exampleToInstant :: Effect Unit
exampleToInstant = do
  zoned <- ZonedDateTime.fromString "2024-01-15T12:00:00-05:00[America/New_York]"
  Console.log (Instant.toString (ZonedDateTime.toInstant zoned))

-- | Extracts date and time in the zoned wall-clock view (drops time zone).
exampleToPlainDateTime :: Effect Unit
exampleToPlainDateTime = do
  zoned <- ZonedDateTime.fromString "2024-01-15T12:00:00-05:00[America/New_York]"
  Console.log (PlainDateTime.toString (ZonedDateTime.toPlainDateTime zoned))

-- | Extracts the calendar date in the zoned wall-clock view.
exampleToPlainDate :: Effect Unit
exampleToPlainDate = do
  zoned <- ZonedDateTime.fromString "2024-01-15T12:00:00-05:00[America/New_York]"
  Console.log (PlainDate.toString (ZonedDateTime.toPlainDate zoned))

-- | Extracts the wall-clock time in the associated time zone.
exampleToPlainTime :: Effect Unit
exampleToPlainTime = do
  zoned <- ZonedDateTime.fromString "2024-01-15T12:00:00-05:00[America/New_York]"
  Console.log (PlainTime.toString (ZonedDateTime.toPlainTime zoned))

-- | Extracts the year and month in the zoned wall-clock view.
exampleToPlainYearMonth :: Effect Unit
exampleToPlainYearMonth = do
  zoned <- ZonedDateTime.fromString "2024-01-15T12:00:00-05:00[America/New_York]"
  Console.log (PlainYearMonth.toString (ZonedDateTime.toPlainYearMonth zoned))

-- | Extracts the month and day in the zoned wall-clock view.
exampleToPlainMonthDay :: Effect Unit
exampleToPlainMonthDay = do
  zoned <- ZonedDateTime.fromString "2024-01-15T12:00:00-05:00[America/New_York]"
  Console.log (PlainMonthDay.toString (ZonedDateTime.toPlainMonthDay zoned))

-- | Serializes to ISO 8601 format with time zone. Options: calendarName, timeZoneName, offset, fractionalSecondDigits, smallestUnit, roundingMode.
exampleToStringWithOptions :: Effect Unit
exampleToStringWithOptions = do
  zoned <- ZonedDateTime.fromString "2024-01-15T12:00:00.123456789-05:00[America/New_York]"
  Console.log
    ( ZonedDateTime.toStringWithOptions
        { smallestUnit: TemporalUnit.Minute
        , calendarName: CalendarName.Never
        }
        zoned
    )

-- | Same as [`toStringWithOptions`](#v:toStringWithOptions) with default options.
exampleToString :: Effect Unit
exampleToString = do
  zoned <- ZonedDateTime.fromString "2024-01-15T12:00:00-05:00[America/New_York]"
  Console.log (ZonedDateTime.toString zoned)
