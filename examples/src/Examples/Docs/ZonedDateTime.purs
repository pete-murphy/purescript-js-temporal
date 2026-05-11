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

exampleFromWithOptions :: Effect Unit
exampleFromWithOptions = do
  zoned <- ZonedDateTime.fromWithOptions { overflow: Overflow.Constrain }
    { year: 2024, month: 1, day: 15, hour: 12, minute: 0, second: 0, timeZone: "America/New_York" }
  Console.log (ZonedDateTime.toString zoned)

exampleFrom :: Effect Unit
exampleFrom = do
  zoned <- ZonedDateTime.from
    { year: 2024, month: 1, day: 15, hour: 12, minute: 0, second: 0, timeZone: "America/New_York" }
  Console.log (ZonedDateTime.toString zoned)

exampleFromStringWithOptions :: Effect Unit
exampleFromStringWithOptions = do
  zoned <- ZonedDateTime.fromStringWithOptions { overflow: Overflow.Constrain } "2024-01-15T12:00:00-05:00[America/New_York]"
  Console.log (ZonedDateTime.toString zoned)

exampleFromString :: Effect Unit
exampleFromString = do
  zoned <- ZonedDateTime.fromString "1970-01-01T00:00:00+00:00[UTC]"
  Console.log (ZonedDateTime.toString zoned)

exampleYear :: Effect Unit
exampleYear = do
  zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
  Console.log ("Year: " <> show (ZonedDateTime.year zoned))

exampleMonth :: Effect Unit
exampleMonth = do
  zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
  Console.log ("Month: " <> show (ZonedDateTime.month zoned))

exampleDay :: Effect Unit
exampleDay = do
  zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
  Console.log ("Day: " <> show (ZonedDateTime.day zoned))

exampleMonthCode :: Effect Unit
exampleMonthCode = do
  zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
  Console.log ("Month code: " <> ZonedDateTime.monthCode zoned)

exampleHour :: Effect Unit
exampleHour = do
  zoned <- ZonedDateTime.fromString "2024-07-01T14:30:00[America/New_York]"
  Console.log ("Hour: " <> show (ZonedDateTime.hour zoned))

exampleMinute :: Effect Unit
exampleMinute = do
  zoned <- ZonedDateTime.fromString "2024-07-01T14:30:00[America/New_York]"
  Console.log ("Minute: " <> show (ZonedDateTime.minute zoned))

exampleSecond :: Effect Unit
exampleSecond = do
  zoned <- ZonedDateTime.fromString "2024-07-01T14:30:45[America/New_York]"
  Console.log ("Second: " <> show (ZonedDateTime.second zoned))

exampleMillisecond :: Effect Unit
exampleMillisecond = do
  zoned <- ZonedDateTime.fromString "2024-07-01T14:30:45.123[America/New_York]"
  Console.log ("Millisecond: " <> show (ZonedDateTime.millisecond zoned))

exampleMicrosecond :: Effect Unit
exampleMicrosecond = do
  zoned <- ZonedDateTime.fromString "2024-07-01T14:30:45.123456[America/New_York]"
  Console.log ("Microsecond: " <> show (ZonedDateTime.microsecond zoned))

exampleNanosecond :: Effect Unit
exampleNanosecond = do
  zoned <- ZonedDateTime.fromString "2024-07-01T14:30:45.123456789[America/New_York]"
  Console.log ("Nanosecond: " <> show (ZonedDateTime.nanosecond zoned))

exampleDayOfWeek :: Effect Unit
exampleDayOfWeek = do
  zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
  Console.log ("Day of week: " <> show (ZonedDateTime.dayOfWeek zoned))

exampleDayOfYear :: Effect Unit
exampleDayOfYear = do
  zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
  Console.log ("Day of year: " <> show (ZonedDateTime.dayOfYear zoned))

exampleWeekOfYear :: Effect Unit
exampleWeekOfYear = do
  zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
  Console.log ("Week of year: " <> show (ZonedDateTime.weekOfYear zoned))

exampleYearOfWeek :: Effect Unit
exampleYearOfWeek = do
  zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
  Console.log ("Year of week: " <> show (ZonedDateTime.yearOfWeek zoned))

exampleDaysInMonth :: Effect Unit
exampleDaysInMonth = do
  zoned <- ZonedDateTime.fromString "2024-02-01T12:00:00[America/New_York]"
  Console.log ("Days in Feb 2024: " <> show (ZonedDateTime.daysInMonth zoned))

exampleDaysInYear :: Effect Unit
exampleDaysInYear = do
  zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
  Console.log ("Days in 2024: " <> show (ZonedDateTime.daysInYear zoned))

exampleDaysInWeek :: Effect Unit
exampleDaysInWeek = do
  zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
  Console.log ("Days in week: " <> show (ZonedDateTime.daysInWeek zoned))

exampleMonthsInYear :: Effect Unit
exampleMonthsInYear = do
  zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
  Console.log ("Months in year: " <> show (ZonedDateTime.monthsInYear zoned))

exampleInLeapYear :: Effect Unit
exampleInLeapYear = do
  zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
  Console.log ("2024 is leap year: " <> show (ZonedDateTime.inLeapYear zoned))

exampleCalendarId :: Effect Unit
exampleCalendarId = do
  zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
  Console.log ("Calendar: " <> ZonedDateTime.calendarId zoned)

exampleEra :: Effect Unit
exampleEra = do
  zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
  Console.log ("Era: " <> show (ZonedDateTime.era zoned))

exampleEraYear :: Effect Unit
exampleEraYear = do
  zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
  Console.log ("Era year: " <> show (ZonedDateTime.eraYear zoned))

exampleTimeZoneId :: Effect Unit
exampleTimeZoneId = do
  zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
  Console.log ("Time zone: " <> ZonedDateTime.timeZoneId zoned)

exampleOffset :: Effect Unit
exampleOffset = do
  zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
  Console.log ("Offset: " <> ZonedDateTime.offset zoned)

exampleOffsetNanoseconds :: Effect Unit
exampleOffsetNanoseconds = do
  zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
  Console.log ("Offset ns: " <> show (ZonedDateTime.offsetNanoseconds zoned))

exampleHoursInDay :: Effect Unit
exampleHoursInDay = do
  zoned <- ZonedDateTime.fromString "2024-03-10T12:00:00[America/New_York]"
  Console.log ("Hours in day (DST spring forward): " <> show (ZonedDateTime.hoursInDay zoned))

exampleEpochMilliseconds :: Effect Unit
exampleEpochMilliseconds = do
  zoned <- ZonedDateTime.fromString "1970-01-01T00:00:01+00:00[UTC]"
  Console.log ("Epoch ms: " <> show (ZonedDateTime.epochMilliseconds zoned))

exampleEpochNanoseconds :: Effect Unit
exampleEpochNanoseconds = do
  zoned <- ZonedDateTime.fromString "1970-01-01T00:00:01+00:00[UTC]"
  Console.log ("Epoch ns: " <> show (ZonedDateTime.epochNanoseconds zoned))

exampleAddWithOptions :: Effect Unit
exampleAddWithOptions = do
  start <- ZonedDateTime.fromString "2024-01-15T12:00:00-05:00[America/New_York]"
  twoHours <- Duration.from { hours: 2 }
  later <- ZonedDateTime.addWithOptions { overflow: Overflow.Constrain } twoHours start
  Console.log (ZonedDateTime.toString later)

exampleAdd :: Effect Unit
exampleAdd = do
  start <- ZonedDateTime.fromString "2024-01-15T12:00:00-05:00[America/New_York]"
  twoHours <- Duration.from { hours: 2 }
  later <- ZonedDateTime.add twoHours start
  Console.log (ZonedDateTime.toString later)

exampleSubtractWithOptions :: Effect Unit
exampleSubtractWithOptions = do
  zoned <- ZonedDateTime.fromString "2024-03-15T14:00:00[America/New_York]"
  twoHours <- Duration.from { hours: 2 }
  earlier <- ZonedDateTime.subtractWithOptions { overflow: Overflow.Constrain } twoHours zoned
  Console.log (ZonedDateTime.toString earlier)

exampleSubtract :: Effect Unit
exampleSubtract = do
  zoned <- ZonedDateTime.fromString "2024-03-15T14:00:00[America/New_York]"
  twoHours <- Duration.from { hours: 2 }
  earlier <- ZonedDateTime.subtract twoHours zoned
  Console.log (ZonedDateTime.toString earlier)

exampleWithWithOptions :: Effect Unit
exampleWithWithOptions = do
  meeting <- ZonedDateTime.fromString "2024-01-15T09:30:45-05:00[America/New_York]"
  noon <- ZonedDateTime.withWithOptions { overflow: Overflow.Constrain } { hour: 12, minute: 0, second: 0 } meeting
  Console.log (ZonedDateTime.toString noon)

exampleWith :: Effect Unit
exampleWith = do
  meeting <- ZonedDateTime.fromString "2024-01-15T09:30:45-05:00[America/New_York]"
  noon <- ZonedDateTime.with { hour: 12, minute: 0, second: 0 } meeting
  Console.log (ZonedDateTime.toString noon)

exampleWithTimeZone :: Effect Unit
exampleWithTimeZone = do
  zoned <- ZonedDateTime.fromString "2024-01-15T12:00:00-05:00[America/New_York]"
  inTokyo <- ZonedDateTime.withTimeZone "Asia/Tokyo" zoned
  Console.log (ZonedDateTime.toString inTokyo)

exampleWithCalendar :: Effect Unit
exampleWithCalendar = do
  zoned <- ZonedDateTime.fromString "2024-01-15T12:00:00-05:00[America/New_York]"
  gregory <- ZonedDateTime.withCalendar "gregory" zoned
  Console.log (ZonedDateTime.toStringWithOptions { calendarName: CalendarName.Always } gregory)

exampleWithPlainTime :: Effect Unit
exampleWithPlainTime = do
  zoned <- ZonedDateTime.fromString "2024-01-15T09:30:45-05:00[America/New_York]"
  closingTime <- PlainTime.fromString "17:00:00"
  updated <- ZonedDateTime.withPlainTime closingTime zoned
  Console.log (ZonedDateTime.toString updated)

exampleWithPlainDate :: Effect Unit
exampleWithPlainDate = do
  zoned <- ZonedDateTime.fromString "2024-01-15T09:30:45-05:00[America/New_York]"
  nextDay <- PlainDate.fromString "2024-01-16"
  updated <- ZonedDateTime.withPlainDate nextDay zoned
  Console.log (ZonedDateTime.toString updated)

exampleUntilWithOptions :: Effect Unit
exampleUntilWithOptions = do
  locale <- JS.Intl.Locale.new_ "en-US"
  departure <- ZonedDateTime.fromString "2020-03-08T11:55:00+08:00[Asia/Hong_Kong]"
  arrival <- ZonedDateTime.fromString "2020-03-08T09:50:00-07:00[America/Los_Angeles]"
  flightTime <- ZonedDateTime.untilWithOptions { largestUnit: TemporalUnit.Hour } arrival departure
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log ("Flight time: " <> JS.Intl.DurationFormat.format formatter flightTime)

exampleUntil :: Effect Unit
exampleUntil = do
  start <- ZonedDateTime.fromString "2024-01-01T00:00:00[America/New_York]"
  end <- ZonedDateTime.fromString "2024-01-02T00:00:00[America/New_York]"
  duration <- ZonedDateTime.until end start
  Console.log (Duration.toString duration)

exampleSinceWithOptions :: Effect Unit
exampleSinceWithOptions = do
  locale <- JS.Intl.Locale.new_ "en-US"
  start <- ZonedDateTime.fromString "2024-01-01T00:00:00[America/New_York]"
  end <- ZonedDateTime.fromString "2024-03-15T12:00:00[America/New_York]"
  elapsed <- ZonedDateTime.sinceWithOptions { largestUnit: TemporalUnit.Hour } start end
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log ("Elapsed: " <> JS.Intl.DurationFormat.format formatter elapsed)

exampleSince :: Effect Unit
exampleSince = do
  start <- ZonedDateTime.fromString "2024-01-01T00:00:00[America/New_York]"
  end <- ZonedDateTime.fromString "2024-03-15T12:00:00[America/New_York]"
  elapsed <- ZonedDateTime.since start end
  Console.log (Duration.toString elapsed)

exampleRound :: Effect Unit
exampleRound = do
  zoned <- ZonedDateTime.fromString "2024-01-15T09:30:45.123456789-05:00[America/New_York]"
  rounded <- ZonedDateTime.round { smallestUnit: TemporalUnit.Minute, roundingMode: RoundingMode.HalfExpand } zoned
  Console.log (ZonedDateTime.toString rounded)

exampleStartOfDay :: Effect Unit
exampleStartOfDay = do
  zoned <- ZonedDateTime.fromString "2024-03-10T12:00:00-04:00[America/New_York]"
  start <- ZonedDateTime.startOfDay zoned
  Console.log (ZonedDateTime.toString start)

exampleGetTimeZoneTransition :: Effect Unit
exampleGetTimeZoneTransition = do
  zoned <- ZonedDateTime.fromString "2024-03-09T12:00:00-05:00[America/New_York]"
  case ZonedDateTime.getTimeZoneTransition "next" zoned of
    Nothing -> Console.log "No transition"
    Just transition -> Console.log (ZonedDateTime.toString transition)

exampleToInstant :: Effect Unit
exampleToInstant = do
  zoned <- ZonedDateTime.fromString "2024-01-15T12:00:00-05:00[America/New_York]"
  Console.log (Instant.toString (ZonedDateTime.toInstant zoned))

exampleToPlainDateTime :: Effect Unit
exampleToPlainDateTime = do
  zoned <- ZonedDateTime.fromString "2024-01-15T12:00:00-05:00[America/New_York]"
  Console.log (PlainDateTime.toString (ZonedDateTime.toPlainDateTime zoned))

exampleToPlainDate :: Effect Unit
exampleToPlainDate = do
  zoned <- ZonedDateTime.fromString "2024-01-15T12:00:00-05:00[America/New_York]"
  Console.log (PlainDate.toString (ZonedDateTime.toPlainDate zoned))

exampleToPlainTime :: Effect Unit
exampleToPlainTime = do
  zoned <- ZonedDateTime.fromString "2024-01-15T12:00:00-05:00[America/New_York]"
  Console.log (PlainTime.toString (ZonedDateTime.toPlainTime zoned))

exampleToPlainYearMonth :: Effect Unit
exampleToPlainYearMonth = do
  zoned <- ZonedDateTime.fromString "2024-01-15T12:00:00-05:00[America/New_York]"
  Console.log (PlainYearMonth.toString (ZonedDateTime.toPlainYearMonth zoned))

exampleToPlainMonthDay :: Effect Unit
exampleToPlainMonthDay = do
  zoned <- ZonedDateTime.fromString "2024-01-15T12:00:00-05:00[America/New_York]"
  Console.log (PlainMonthDay.toString (ZonedDateTime.toPlainMonthDay zoned))

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

exampleToString :: Effect Unit
exampleToString = do
  zoned <- ZonedDateTime.fromString "2024-01-15T12:00:00-05:00[America/New_York]"
  Console.log (ZonedDateTime.toString zoned)
