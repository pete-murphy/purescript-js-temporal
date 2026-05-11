-- | Compilable doc examples for JS.Temporal.ZonedDateTime.
module Examples.Docs.ZonedDateTime where

import Prelude

import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Class.Console as Console
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

-- [EXAMPLE JS.Temporal.ZonedDateTime.fromString_]
exampleFromString_ :: Effect Unit
exampleFromString_ = do
  locale <- JS.Intl.Locale.new_ "en-US"
  zoned <- ZonedDateTime.fromString_ "1970-01-01T00:00:00+00:00[UTC]"
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium", timeZone: "UTC" }
  Console.log (JS.Intl.DateTimeFormat.format formatter zoned)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.ZonedDateTime.fromString]
exampleFromString :: Effect Unit
exampleFromString = do
  locale <- JS.Intl.Locale.new_ "en-US"
  zoned <- ZonedDateTime.fromString { overflow: Overflow.Constrain } "2024-01-15T12:00:00-05:00[America/New_York]"
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter zoned)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.ZonedDateTime.add]
exampleAdd :: Effect Unit
exampleAdd = do
  locale <- JS.Intl.Locale.new_ "en-US"
  start <- ZonedDateTime.fromString_ "2024-01-15T12:00:00-05:00[America/New_York]"
  twoHours <- Duration.from { hours: 2 }
  later <- ZonedDateTime.add { overflow: Overflow.Constrain } twoHours start
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter later)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.ZonedDateTime.until]
exampleUntil :: Effect Unit
exampleUntil = do
  locale <- JS.Intl.Locale.new_ "en-US"
  departure <- ZonedDateTime.fromString_ "2020-03-08T11:55:00+08:00[Asia/Hong_Kong]"
  arrival <- ZonedDateTime.fromString_ "2020-03-08T09:50:00-07:00[America/Los_Angeles]"
  flightTime <- ZonedDateTime.until { largestUnit: TemporalUnit.Hour } arrival departure
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log ("Flight time: " <> JS.Intl.DurationFormat.format formatter flightTime)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.ZonedDateTime.since]
exampleSince :: Effect Unit
exampleSince = do
  locale <- JS.Intl.Locale.new_ "en-US"
  start <- ZonedDateTime.fromString_ "2024-01-01T00:00:00[America/New_York]"
  end <- ZonedDateTime.fromString_ "2024-03-15T12:00:00[America/New_York]"
  elapsed <- ZonedDateTime.since { largestUnit: TemporalUnit.Hour } start end
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log ("Elapsed: " <> JS.Intl.DurationFormat.format formatter elapsed)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.ZonedDateTime.subtract]
exampleSubtract :: Effect Unit
exampleSubtract = do
  locale <- JS.Intl.Locale.new_ "en-US"
  zoned <- ZonedDateTime.fromString_ "2024-03-15T14:00:00[America/New_York]"
  twoHours <- Duration.from { hours: 2 }
  earlier <- ZonedDateTime.subtract { overflow: Overflow.Constrain } twoHours zoned
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter earlier)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.ZonedDateTime.with]
exampleWith :: Effect Unit
exampleWith = do
  locale <- JS.Intl.Locale.new_ "en-US"
  meeting <- ZonedDateTime.fromString_ "2024-01-15T09:30:45-05:00[America/New_York]"
  noon <- ZonedDateTime.with { overflow: Overflow.Constrain } { hour: 12, minute: 0, second: 0 } meeting
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter noon)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.ZonedDateTime.withTimeZone]
exampleWithTimeZone :: Effect Unit
exampleWithTimeZone = do
  zoned <- ZonedDateTime.fromString_ "2024-01-15T12:00:00-05:00[America/New_York]"
  inTokyo <- ZonedDateTime.withTimeZone "Asia/Tokyo" zoned
  Console.log (ZonedDateTime.toString_ inTokyo)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.ZonedDateTime.withCalendar]
exampleWithCalendar :: Effect Unit
exampleWithCalendar = do
  zoned <- ZonedDateTime.fromString_ "2024-01-15T12:00:00-05:00[America/New_York]"
  gregory <- ZonedDateTime.withCalendar "gregory" zoned
  Console.log (ZonedDateTime.toString { calendarName: CalendarName.Always } gregory)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.ZonedDateTime.withPlainTime]
exampleWithPlainTime :: Effect Unit
exampleWithPlainTime = do
  zoned <- ZonedDateTime.fromString_ "2024-01-15T09:30:45-05:00[America/New_York]"
  closingTime <- PlainTime.fromString_ "17:00:00"
  updated <- ZonedDateTime.withPlainTime closingTime zoned
  Console.log (ZonedDateTime.toString_ updated)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.ZonedDateTime.withPlainDate]
exampleWithPlainDate :: Effect Unit
exampleWithPlainDate = do
  zoned <- ZonedDateTime.fromString_ "2024-01-15T09:30:45-05:00[America/New_York]"
  nextDay <- PlainDate.fromString_ "2024-01-16"
  updated <- ZonedDateTime.withPlainDate nextDay zoned
  Console.log (ZonedDateTime.toString_ updated)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.ZonedDateTime.round]
exampleRound :: Effect Unit
exampleRound = do
  zoned <- ZonedDateTime.fromString_ "2024-01-15T09:30:45.123456789-05:00[America/New_York]"
  rounded <- ZonedDateTime.round { smallestUnit: TemporalUnit.Minute, roundingMode: RoundingMode.HalfExpand } zoned
  Console.log (ZonedDateTime.toString_ rounded)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.ZonedDateTime.startOfDay]
exampleStartOfDay :: Effect Unit
exampleStartOfDay = do
  zoned <- ZonedDateTime.fromString_ "2024-03-10T12:00:00-04:00[America/New_York]"
  start <- ZonedDateTime.startOfDay zoned
  Console.log (ZonedDateTime.toString_ start)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.ZonedDateTime.getTimeZoneTransition]
exampleGetTimeZoneTransition :: Effect Unit
exampleGetTimeZoneTransition = do
  zoned <- ZonedDateTime.fromString_ "2024-03-09T12:00:00-05:00[America/New_York]"
  case ZonedDateTime.getTimeZoneTransition "next" zoned of
    Nothing -> Console.log "No transition"
    Just transition -> Console.log (ZonedDateTime.toString_ transition)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.ZonedDateTime.toInstant]
exampleToInstant :: Effect Unit
exampleToInstant = do
  zoned <- ZonedDateTime.fromString_ "2024-01-15T12:00:00-05:00[America/New_York]"
  Console.log (Instant.toString_ (ZonedDateTime.toInstant zoned))

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.ZonedDateTime.toPlainDateTime]
exampleToPlainDateTime :: Effect Unit
exampleToPlainDateTime = do
  zoned <- ZonedDateTime.fromString_ "2024-01-15T12:00:00-05:00[America/New_York]"
  Console.log (PlainDateTime.toString_ (ZonedDateTime.toPlainDateTime zoned))

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.ZonedDateTime.toPlainDate]
exampleToPlainDate :: Effect Unit
exampleToPlainDate = do
  zoned <- ZonedDateTime.fromString_ "2024-01-15T12:00:00-05:00[America/New_York]"
  Console.log (PlainDate.toString_ (ZonedDateTime.toPlainDate zoned))

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.ZonedDateTime.toPlainTime]
exampleToPlainTime :: Effect Unit
exampleToPlainTime = do
  zoned <- ZonedDateTime.fromString_ "2024-01-15T12:00:00-05:00[America/New_York]"
  Console.log (PlainTime.toString_ (ZonedDateTime.toPlainTime zoned))

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.ZonedDateTime.toPlainYearMonth]
exampleToPlainYearMonth :: Effect Unit
exampleToPlainYearMonth = do
  zoned <- ZonedDateTime.fromString_ "2024-01-15T12:00:00-05:00[America/New_York]"
  Console.log (PlainYearMonth.toString_ (ZonedDateTime.toPlainYearMonth zoned))

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.ZonedDateTime.toPlainMonthDay]
exampleToPlainMonthDay :: Effect Unit
exampleToPlainMonthDay = do
  zoned <- ZonedDateTime.fromString_ "2024-01-15T12:00:00-05:00[America/New_York]"
  Console.log (PlainMonthDay.toString_ (ZonedDateTime.toPlainMonthDay zoned))

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.ZonedDateTime.toString]
exampleToString :: Effect Unit
exampleToString = do
  zoned <- ZonedDateTime.fromString_ "2024-01-15T12:00:00.123456789-05:00[America/New_York]"
  Console.log
    ( ZonedDateTime.toString
        { smallestUnit: TemporalUnit.Minute
        , calendarName: CalendarName.Never
        }
        zoned
    )
-- [/EXAMPLE]

