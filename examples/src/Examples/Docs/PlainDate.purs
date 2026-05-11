-- | Compilable doc examples for JS.Temporal.PlainDate.
module Examples.Docs.PlainDate where

import Prelude

import Data.Date as Date
import Data.Enum (fromEnum)
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

exampleFromWithOptions :: Effect Unit
exampleFromWithOptions = do
  locale <- JS.Intl.Locale.new_ "en-US"
  date <- PlainDate.fromWithOptions { overflow: Overflow.Constrain } { year: 2024, month: 7, day: 1 }
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter date)

exampleFrom :: Effect Unit
exampleFrom = do
  locale <- JS.Intl.Locale.new_ "en-US"
  date <- PlainDate.from { year: 2024, month: 7, day: 1 }
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter date)

exampleFromDate :: Effect Unit
exampleFromDate = do
  date <- PlainDate.fromString "2024-07-01"
  roundTripped <- PlainDate.fromDate (PlainDate.toDate date)
  Console.log (PlainDate.toString roundTripped)

exampleFromStringWithOptions :: Effect Unit
exampleFromStringWithOptions = do
  date <- PlainDate.fromStringWithOptions { overflow: Overflow.Constrain } "2024-01-15"
  Console.log (PlainDate.toString date)

exampleFromString :: Effect Unit
exampleFromString = do
  locale <- JS.Intl.Locale.new_ "en-US"
  date <- PlainDate.fromString "2024-01-15"
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter date)

exampleYear :: Effect Unit
exampleYear = do
  date <- PlainDate.fromString "2024-07-01"
  Console.log ("Year: " <> show (PlainDate.year date))

exampleMonth :: Effect Unit
exampleMonth = do
  date <- PlainDate.fromString "2024-07-01"
  Console.log ("Month: " <> show (PlainDate.month date))

exampleDay :: Effect Unit
exampleDay = do
  date <- PlainDate.fromString "2024-07-01"
  Console.log ("Day: " <> show (PlainDate.day date))

exampleMonthCode :: Effect Unit
exampleMonthCode = do
  date <- PlainDate.fromString "2024-07-01"
  Console.log ("Month code: " <> PlainDate.monthCode date)

exampleCalendarId :: Effect Unit
exampleCalendarId = do
  date <- PlainDate.fromString "2024-07-01"
  Console.log ("Calendar: " <> PlainDate.calendarId date)

exampleDayOfWeek :: Effect Unit
exampleDayOfWeek = do
  date <- PlainDate.fromString "2024-07-01"
  Console.log ("Day of week: " <> show (PlainDate.dayOfWeek date))

exampleDayOfYear :: Effect Unit
exampleDayOfYear = do
  date <- PlainDate.fromString "2024-07-01"
  Console.log ("Day of year: " <> show (PlainDate.dayOfYear date))

exampleWeekOfYear :: Effect Unit
exampleWeekOfYear = do
  date <- PlainDate.fromString "2024-07-01"
  Console.log ("Week of year: " <> show (PlainDate.weekOfYear date))

exampleYearOfWeek :: Effect Unit
exampleYearOfWeek = do
  date <- PlainDate.fromString "2024-07-01"
  Console.log ("Year of week: " <> show (PlainDate.yearOfWeek date))

exampleDaysInMonth :: Effect Unit
exampleDaysInMonth = do
  date <- PlainDate.fromString "2024-02-01"
  Console.log ("Days in Feb 2024: " <> show (PlainDate.daysInMonth date))

exampleDaysInWeek :: Effect Unit
exampleDaysInWeek = do
  date <- PlainDate.fromString "2024-07-01"
  Console.log ("Days in week: " <> show (PlainDate.daysInWeek date))

exampleDaysInYear :: Effect Unit
exampleDaysInYear = do
  date <- PlainDate.fromString "2024-07-01"
  Console.log ("Days in 2024: " <> show (PlainDate.daysInYear date))

exampleMonthsInYear :: Effect Unit
exampleMonthsInYear = do
  date <- PlainDate.fromString "2024-07-01"
  Console.log ("Months in year: " <> show (PlainDate.monthsInYear date))

exampleInLeapYear :: Effect Unit
exampleInLeapYear = do
  date <- PlainDate.fromString "2024-07-01"
  Console.log ("2024 is leap year: " <> show (PlainDate.inLeapYear date))

exampleEra :: Effect Unit
exampleEra = do
  date <- PlainDate.fromString "2024-07-01"
  Console.log ("Era: " <> show (PlainDate.era date))

exampleEraYear :: Effect Unit
exampleEraYear = do
  date <- PlainDate.fromString "2024-07-01"
  Console.log ("Era year: " <> show (PlainDate.eraYear date))

exampleAddWithOptions :: Effect Unit
exampleAddWithOptions = do
  locale <- JS.Intl.Locale.new_ "en-US"
  date <- PlainDate.fromString "2024-03-15"
  oneWeek <- Duration.from { weeks: 1 }
  later <- PlainDate.addWithOptions { overflow: Overflow.Constrain } oneWeek date
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter later)

exampleAdd :: Effect Unit
exampleAdd = do
  locale <- JS.Intl.Locale.new_ "en-US"
  date <- PlainDate.fromString "2024-03-15"
  oneWeek <- Duration.from { weeks: 1 }
  later <- PlainDate.add oneWeek date
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter later)

exampleSubtractWithOptions :: Effect Unit
exampleSubtractWithOptions = do
  locale <- JS.Intl.Locale.new_ "en-US"
  date <- PlainDate.fromString "2024-03-15"
  oneWeek <- Duration.from { weeks: 1 }
  earlier <- PlainDate.subtractWithOptions { overflow: Overflow.Constrain } oneWeek date
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter earlier)

exampleSubtract :: Effect Unit
exampleSubtract = do
  locale <- JS.Intl.Locale.new_ "en-US"
  date <- PlainDate.fromString "2024-03-15"
  oneWeek <- Duration.from { weeks: 1 }
  earlier <- PlainDate.subtract oneWeek date
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter earlier)

exampleWithWithOptions :: Effect Unit
exampleWithWithOptions = do
  date <- PlainDate.fromString "2021-07-06"
  lastDay <- PlainDate.withWithOptions { overflow: Overflow.Constrain } { day: PlainDate.daysInMonth date } date
  Console.log (PlainDate.toString lastDay)

exampleWith :: Effect Unit
exampleWith = do
  date <- PlainDate.fromString "2021-07-06"
  lastDay <- PlainDate.with { day: PlainDate.daysInMonth date } date
  Console.log (PlainDate.toString lastDay)

exampleWithCalendar :: Effect Unit
exampleWithCalendar = do
  date <- PlainDate.fromString "2024-01-15"
  gregory <- PlainDate.withCalendar "gregory" date
  Console.log (PlainDate.toStringWithOptions { calendarName: CalendarName.Always } gregory)

exampleUntilWithOptions :: Effect Unit
exampleUntilWithOptions = do
  locale <- JS.Intl.Locale.new_ "en-US"
  today <- Now.plainDateISO
  futureDate <- PlainDate.fromString "2026-12-25"
  untilDuration <- PlainDate.untilWithOptions { smallestUnit: TemporalUnit.Day } futureDate today
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter untilDuration <> " until Christmas 2026")

exampleUntil :: Effect Unit
exampleUntil = do
  start <- PlainDate.fromString "2024-01-01"
  end <- PlainDate.fromString "2024-03-15"
  duration <- PlainDate.until end start
  Console.log (Duration.toString duration)

exampleSinceWithOptions :: Effect Unit
exampleSinceWithOptions = do
  locale <- JS.Intl.Locale.new_ "en-US"
  start <- PlainDate.fromString "2024-01-01"
  end <- PlainDate.fromString "2024-03-15"
  elapsed <- PlainDate.sinceWithOptions { largestUnit: TemporalUnit.Day } start end
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log ("Elapsed: " <> JS.Intl.DurationFormat.format formatter elapsed)

exampleSince :: Effect Unit
exampleSince = do
  start <- PlainDate.fromString "2024-01-01"
  end <- PlainDate.fromString "2024-03-15"
  elapsed <- PlainDate.since start end
  Console.log (Duration.toString elapsed)

exampleToDate :: Effect Unit
exampleToDate = do
  date <- PlainDate.fromString "2024-07-01"
  let d = PlainDate.toDate date
  Console.log ("PureScript Date year: " <> show (fromEnum (Date.year d)))

exampleToPlainDateTime :: Effect Unit
exampleToPlainDateTime = do
  date <- PlainDate.fromString "2024-01-15"
  time <- PlainTime.fromString "09:30:00"
  Console.log (PlainDateTime.toString (PlainDate.toPlainDateTime time date))

exampleToPlainMonthDay :: Effect Unit
exampleToPlainMonthDay = do
  date <- PlainDate.fromString "2024-01-15"
  Console.log (PlainMonthDay.toString (PlainDate.toPlainMonthDay date))

exampleToPlainYearMonth :: Effect Unit
exampleToPlainYearMonth = do
  date <- PlainDate.fromString "2024-01-15"
  Console.log (PlainYearMonth.toString (PlainDate.toPlainYearMonth date))

exampleToZonedDateTimeWithPlainTime :: Effect Unit
exampleToZonedDateTimeWithPlainTime = do
  date <- PlainDate.fromString "2024-01-15"
  time <- PlainTime.fromString "09:30:00"
  zoned <- PlainDate.toZonedDateTimeWithPlainTime "America/New_York" time date
  Console.log (ZonedDateTime.toString zoned)

exampleToZonedDateTime :: Effect Unit
exampleToZonedDateTime = do
  date <- PlainDate.fromString "2024-01-15"
  zoned <- PlainDate.toZonedDateTime "America/New_York" date
  Console.log (ZonedDateTime.toString zoned)

exampleToStringWithOptions :: Effect Unit
exampleToStringWithOptions = do
  date <- PlainDate.fromString "2024-01-15"
  Console.log (PlainDate.toStringWithOptions { calendarName: CalendarName.Always } date)

exampleToString :: Effect Unit
exampleToString = do
  date <- PlainDate.fromString "2024-01-15"
  Console.log (PlainDate.toString date)
