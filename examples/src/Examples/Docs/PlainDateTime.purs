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

exampleFromWithOptions :: Effect Unit
exampleFromWithOptions = do
  locale <- JS.Intl.Locale.new_ "en-US"
  dateTime <- PlainDateTime.fromWithOptions { overflow: Overflow.Constrain }
    { year: 2024, month: 1, day: 15, hour: 9, minute: 30, second: 0 }
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter dateTime)

exampleFrom :: Effect Unit
exampleFrom = do
  locale <- JS.Intl.Locale.new_ "en-US"
  dateTime <- PlainDateTime.from
    { year: 2024, month: 1, day: 15, hour: 9, minute: 30, second: 0 }
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter dateTime)

exampleFromStringWithOptions :: Effect Unit
exampleFromStringWithOptions = do
  dateTime <- PlainDateTime.fromStringWithOptions { overflow: Overflow.Constrain } "2024-01-15T09:30:00"
  Console.log (PlainDateTime.toString dateTime)

exampleFromString :: Effect Unit
exampleFromString = do
  locale <- JS.Intl.Locale.new_ "en-US"
  dateTime <- PlainDateTime.fromString "2024-01-15T09:30:00"
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter dateTime)

exampleYear :: Effect Unit
exampleYear = do
  dt <- PlainDateTime.fromString "2024-07-01T09:30:00"
  Console.log ("Year: " <> show (PlainDateTime.year dt))

exampleMonth :: Effect Unit
exampleMonth = do
  dt <- PlainDateTime.fromString "2024-07-01T09:30:00"
  Console.log ("Month: " <> show (PlainDateTime.month dt))

exampleDay :: Effect Unit
exampleDay = do
  dt <- PlainDateTime.fromString "2024-07-01T09:30:00"
  Console.log ("Day: " <> show (PlainDateTime.day dt))

exampleMonthCode :: Effect Unit
exampleMonthCode = do
  dt <- PlainDateTime.fromString "2024-07-01T09:30:00"
  Console.log ("Month code: " <> PlainDateTime.monthCode dt)

exampleDayOfWeek :: Effect Unit
exampleDayOfWeek = do
  dt <- PlainDateTime.fromString "2024-07-01T09:30:00"
  Console.log ("Day of week: " <> show (PlainDateTime.dayOfWeek dt))

exampleDayOfYear :: Effect Unit
exampleDayOfYear = do
  dt <- PlainDateTime.fromString "2024-07-01T09:30:00"
  Console.log ("Day of year: " <> show (PlainDateTime.dayOfYear dt))

exampleWeekOfYear :: Effect Unit
exampleWeekOfYear = do
  dt <- PlainDateTime.fromString "2024-07-01T09:30:00"
  Console.log ("Week of year: " <> show (PlainDateTime.weekOfYear dt))

exampleYearOfWeek :: Effect Unit
exampleYearOfWeek = do
  dt <- PlainDateTime.fromString "2024-07-01T09:30:00"
  Console.log ("Year of week: " <> show (PlainDateTime.yearOfWeek dt))

exampleDaysInMonth :: Effect Unit
exampleDaysInMonth = do
  dt <- PlainDateTime.fromString "2024-02-01T00:00:00"
  Console.log ("Days in Feb 2024: " <> show (PlainDateTime.daysInMonth dt))

exampleDaysInYear :: Effect Unit
exampleDaysInYear = do
  dt <- PlainDateTime.fromString "2024-07-01T00:00:00"
  Console.log ("Days in 2024: " <> show (PlainDateTime.daysInYear dt))

exampleDaysInWeek :: Effect Unit
exampleDaysInWeek = do
  dt <- PlainDateTime.fromString "2024-07-01T00:00:00"
  Console.log ("Days in week: " <> show (PlainDateTime.daysInWeek dt))

exampleMonthsInYear :: Effect Unit
exampleMonthsInYear = do
  dt <- PlainDateTime.fromString "2024-07-01T00:00:00"
  Console.log ("Months in year: " <> show (PlainDateTime.monthsInYear dt))

exampleInLeapYear :: Effect Unit
exampleInLeapYear = do
  dt <- PlainDateTime.fromString "2024-07-01T00:00:00"
  Console.log ("2024 is leap year: " <> show (PlainDateTime.inLeapYear dt))

exampleCalendarId :: Effect Unit
exampleCalendarId = do
  dt <- PlainDateTime.fromString "2024-07-01T00:00:00"
  Console.log ("Calendar: " <> PlainDateTime.calendarId dt)

exampleEra :: Effect Unit
exampleEra = do
  dt <- PlainDateTime.fromString "2024-07-01T00:00:00"
  Console.log ("Era: " <> show (PlainDateTime.era dt))

exampleEraYear :: Effect Unit
exampleEraYear = do
  dt <- PlainDateTime.fromString "2024-07-01T00:00:00"
  Console.log ("Era year: " <> show (PlainDateTime.eraYear dt))

exampleHour :: Effect Unit
exampleHour = do
  dt <- PlainDateTime.fromString "2024-07-01T14:30:45"
  Console.log ("Hour: " <> show (PlainDateTime.hour dt))

exampleMinute :: Effect Unit
exampleMinute = do
  dt <- PlainDateTime.fromString "2024-07-01T14:30:45"
  Console.log ("Minute: " <> show (PlainDateTime.minute dt))

exampleSecond :: Effect Unit
exampleSecond = do
  dt <- PlainDateTime.fromString "2024-07-01T14:30:45"
  Console.log ("Second: " <> show (PlainDateTime.second dt))

exampleMillisecond :: Effect Unit
exampleMillisecond = do
  dt <- PlainDateTime.fromString "2024-07-01T14:30:45.123"
  Console.log ("Millisecond: " <> show (PlainDateTime.millisecond dt))

exampleMicrosecond :: Effect Unit
exampleMicrosecond = do
  dt <- PlainDateTime.fromString "2024-07-01T14:30:45.123456"
  Console.log ("Microsecond: " <> show (PlainDateTime.microsecond dt))

exampleNanosecond :: Effect Unit
exampleNanosecond = do
  dt <- PlainDateTime.fromString "2024-07-01T14:30:45.123456789"
  Console.log ("Nanosecond: " <> show (PlainDateTime.nanosecond dt))

exampleAddWithOptions :: Effect Unit
exampleAddWithOptions = do
  start <- PlainDateTime.fromString "2024-01-15T09:00:00"
  twoHours <- Duration.from { hours: 2 }
  end <- PlainDateTime.addWithOptions { overflow: Overflow.Constrain } twoHours start
  Console.log (PlainDateTime.toString end)

exampleAdd :: Effect Unit
exampleAdd = do
  start <- PlainDateTime.fromString "2024-01-15T09:00:00"
  twoHours <- Duration.from { hours: 2 }
  end <- PlainDateTime.add twoHours start
  Console.log (PlainDateTime.toString end)

exampleSubtractWithOptions :: Effect Unit
exampleSubtractWithOptions = do
  start <- PlainDateTime.fromString "2024-01-15T11:00:00"
  twoHours <- Duration.from { hours: 2 }
  earlier <- PlainDateTime.subtractWithOptions { overflow: Overflow.Constrain } twoHours start
  Console.log (PlainDateTime.toString earlier)

exampleSubtract :: Effect Unit
exampleSubtract = do
  start <- PlainDateTime.fromString "2024-01-15T11:00:00"
  twoHours <- Duration.from { hours: 2 }
  earlier <- PlainDateTime.subtract twoHours start
  Console.log (PlainDateTime.toString earlier)

exampleWithWithOptions :: Effect Unit
exampleWithWithOptions = do
  dateTime <- PlainDateTime.fromString "2024-01-15T09:30:45"
  noon <- PlainDateTime.withWithOptions { overflow: Overflow.Constrain } { hour: 12, minute: 0, second: 0 } dateTime
  Console.log (PlainDateTime.toString noon)

exampleWith :: Effect Unit
exampleWith = do
  dateTime <- PlainDateTime.fromString "2024-01-15T09:30:45"
  noon <- PlainDateTime.with { hour: 12, minute: 0, second: 0 } dateTime
  Console.log (PlainDateTime.toString noon)

exampleWithPlainTime :: Effect Unit
exampleWithPlainTime = do
  dateTime <- PlainDateTime.fromString "2024-01-15T09:30:00"
  closingTime <- PlainTime.fromString "17:00:00"
  updated <- PlainDateTime.withPlainTime closingTime dateTime
  Console.log (PlainDateTime.toString updated)

exampleWithCalendar :: Effect Unit
exampleWithCalendar = do
  dateTime <- PlainDateTime.fromString "2019-05-01T09:30:00"
  japanese <- PlainDateTime.withCalendar "japanese" dateTime
  Console.log (PlainDateTime.calendarId japanese)

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

exampleUntil :: Effect Unit
exampleUntil = do
  start <- PlainDateTime.fromString "2024-01-01T00:00:00"
  end <- PlainDateTime.fromString "2024-03-15T12:00:00"
  duration <- PlainDateTime.until end start
  Console.log (Duration.toString duration)

exampleSinceWithOptions :: Effect Unit
exampleSinceWithOptions = do
  locale <- JS.Intl.Locale.new_ "en-US"
  start <- PlainDateTime.fromString "2024-01-01T00:00:00"
  end <- PlainDateTime.fromString "2024-03-15T12:00:00"
  elapsed <- PlainDateTime.sinceWithOptions { largestUnit: TemporalUnit.Day } start end
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: JS.Intl.Options.DurationFormatStyle.Long }
  Console.log ("Elapsed: " <> JS.Intl.DurationFormat.format formatter elapsed)

exampleSince :: Effect Unit
exampleSince = do
  start <- PlainDateTime.fromString "2024-01-01T00:00:00"
  end <- PlainDateTime.fromString "2024-03-15T12:00:00"
  elapsed <- PlainDateTime.since start end
  Console.log (Duration.toString elapsed)

exampleRound :: Effect Unit
exampleRound = do
  dateTime <- PlainDateTime.fromString "2024-01-15T09:30:45.123"
  rounded <- PlainDateTime.round { smallestUnit: TemporalUnit.Minute } dateTime
  Console.log (PlainDateTime.toString rounded)

exampleToStringWithOptions :: Effect Unit
exampleToStringWithOptions = do
  dateTime <- PlainDateTime.fromString "2024-01-15T09:30:00"
  Console.log (PlainDateTime.toStringWithOptions { smallestUnit: TemporalUnit.Minute } dateTime)

exampleToString :: Effect Unit
exampleToString = do
  dateTime <- PlainDateTime.fromString "2024-01-15T09:30:00"
  Console.log (PlainDateTime.toString dateTime)

exampleFromDateTime :: Effect Unit
exampleFromDateTime = do
  dt <- PlainDateTime.fromString "2024-07-01T12:00:00"
  roundTripped <- PlainDateTime.fromDateTime (PlainDateTime.toDateTime dt)
  Console.log (PlainDateTime.toString roundTripped)

exampleToDateTime :: Effect Unit
exampleToDateTime = do
  dt <- PlainDateTime.fromString "2024-07-01T12:00:00"
  Console.log (show (PlainDateTime.toDateTime dt))

exampleToPlainDate :: Effect Unit
exampleToPlainDate = do
  dateTime <- PlainDateTime.fromString "2024-01-15T09:30:00"
  Console.log (PlainDate.toString (PlainDateTime.toPlainDate dateTime))

exampleToPlainTime :: Effect Unit
exampleToPlainTime = do
  dateTime <- PlainDateTime.fromString "2024-01-15T09:30:00"
  Console.log (PlainTime.toString (PlainDateTime.toPlainTime dateTime))

exampleToZonedDateTime :: Effect Unit
exampleToZonedDateTime = do
  plain <- PlainDateTime.fromString "2024-01-15T09:30:00"
  zoned <- PlainDateTime.toZonedDateTime "America/New_York" plain
  Console.log (ZonedDateTime.toString zoned)
