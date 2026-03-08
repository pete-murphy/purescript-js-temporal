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

exampleNew :: Effect Unit
exampleNew = do
  -- [EXAMPLE JS.Temporal.ZonedDateTime.new]
  locale <- JS.Intl.Locale.new_ "en-US"
  zoned <- ZonedDateTime.new (BigInt.fromInt 0) "UTC"
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium", timeZone: "UTC" }
  Console.log (JS.Intl.DateTimeFormat.format formatter zoned)
  -- [/EXAMPLE]

exampleFrom :: Effect Unit
exampleFrom = do
  -- [EXAMPLE JS.Temporal.ZonedDateTime.from]
  locale <- JS.Intl.Locale.new_ "en-US"
  zoned <- ZonedDateTime.from { overflow: Overflow.Constrain } "2024-01-15T12:00:00-05:00[America/New_York]"
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter zoned)
  -- [/EXAMPLE]

exampleAdd :: Effect Unit
exampleAdd = do
  -- [EXAMPLE JS.Temporal.ZonedDateTime.add]
  locale <- JS.Intl.Locale.new_ "en-US"
  start <- ZonedDateTime.from_ "2024-01-15T12:00:00-05:00[America/New_York]"
  twoHours <- Duration.new { hours: 2 }
  later <- ZonedDateTime.add { overflow: Overflow.Constrain } twoHours start
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter later)
  -- [/EXAMPLE]

exampleUntil :: Effect Unit
exampleUntil = do
  -- [EXAMPLE JS.Temporal.ZonedDateTime.until]
  locale <- JS.Intl.Locale.new_ "en-US"
  departure <- ZonedDateTime.from_ "2020-03-08T11:55:00+08:00[Asia/Hong_Kong]"
  arrival <- ZonedDateTime.from_ "2020-03-08T09:50:00-07:00[America/Los_Angeles]"
  flightTime <- ZonedDateTime.until { largestUnit: TemporalUnit.Hour } arrival departure
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log ("Flight time: " <> JS.Intl.DurationFormat.format formatter flightTime)
  -- [/EXAMPLE]

exampleSince :: Effect Unit
exampleSince = do
  -- [EXAMPLE JS.Temporal.ZonedDateTime.since]
  locale <- JS.Intl.Locale.new_ "en-US"
  start <- ZonedDateTime.from_ "2024-01-01T00:00:00[America/New_York]"
  end <- ZonedDateTime.from_ "2024-03-15T12:00:00[America/New_York]"
  elapsed <- ZonedDateTime.since { largestUnit: TemporalUnit.Hour } start end
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log ("Elapsed: " <> JS.Intl.DurationFormat.format formatter elapsed)
  -- [/EXAMPLE]

exampleSubtract :: Effect Unit
exampleSubtract = do
  -- [EXAMPLE JS.Temporal.ZonedDateTime.subtract]
  locale <- JS.Intl.Locale.new_ "en-US"
  zoned <- ZonedDateTime.from_ "2024-03-15T14:00:00[America/New_York]"
  twoHours <- Duration.new { hours: 2 }
  earlier <- ZonedDateTime.subtract { overflow: Overflow.Constrain } twoHours zoned
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter earlier)
  -- [/EXAMPLE]

exampleWith :: Effect Unit
exampleWith = do
  -- [EXAMPLE JS.Temporal.ZonedDateTime.with]
  locale <- JS.Intl.Locale.new_ "en-US"
  meeting <- ZonedDateTime.from_ "2024-01-15T09:30:45-05:00[America/New_York]"
  noon <- ZonedDateTime.with { overflow: Overflow.Constrain } { hour: 12, minute: 0, second: 0 } meeting
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter noon)
  -- [/EXAMPLE]

exampleWithTimeZone :: Effect Unit
exampleWithTimeZone = do
  -- [EXAMPLE JS.Temporal.ZonedDateTime.withTimeZone]
  zoned <- ZonedDateTime.from_ "2024-01-15T12:00:00-05:00[America/New_York]"
  inTokyo <- ZonedDateTime.withTimeZone "Asia/Tokyo" zoned
  Console.log (ZonedDateTime.toString_ inTokyo)
  -- [/EXAMPLE]

exampleWithCalendar :: Effect Unit
exampleWithCalendar = do
  -- [EXAMPLE JS.Temporal.ZonedDateTime.withCalendar]
  zoned <- ZonedDateTime.from_ "2024-01-15T12:00:00-05:00[America/New_York]"
  gregory <- ZonedDateTime.withCalendar "gregory" zoned
  Console.log (ZonedDateTime.toString { calendarName: CalendarName.Always } gregory)
  -- [/EXAMPLE]

exampleWithPlainTime :: Effect Unit
exampleWithPlainTime = do
  -- [EXAMPLE JS.Temporal.ZonedDateTime.withPlainTime]
  zoned <- ZonedDateTime.from_ "2024-01-15T09:30:45-05:00[America/New_York]"
  closingTime <- PlainTime.from_ "17:00:00"
  updated <- ZonedDateTime.withPlainTime closingTime zoned
  Console.log (ZonedDateTime.toString_ updated)
  -- [/EXAMPLE]

exampleWithPlainDate :: Effect Unit
exampleWithPlainDate = do
  -- [EXAMPLE JS.Temporal.ZonedDateTime.withPlainDate]
  zoned <- ZonedDateTime.from_ "2024-01-15T09:30:45-05:00[America/New_York]"
  nextDay <- PlainDate.from_ "2024-01-16"
  updated <- ZonedDateTime.withPlainDate nextDay zoned
  Console.log (ZonedDateTime.toString_ updated)
  -- [/EXAMPLE]

exampleRound :: Effect Unit
exampleRound = do
  -- [EXAMPLE JS.Temporal.ZonedDateTime.round]
  zoned <- ZonedDateTime.from_ "2024-01-15T09:30:45.123456789-05:00[America/New_York]"
  rounded <- ZonedDateTime.round { smallestUnit: TemporalUnit.Minute, roundingMode: RoundingMode.HalfExpand } zoned
  Console.log (ZonedDateTime.toString_ rounded)
  -- [/EXAMPLE]

exampleStartOfDay :: Effect Unit
exampleStartOfDay = do
  -- [EXAMPLE JS.Temporal.ZonedDateTime.startOfDay]
  zoned <- ZonedDateTime.from_ "2024-03-10T12:00:00-04:00[America/New_York]"
  start <- ZonedDateTime.startOfDay zoned
  Console.log (ZonedDateTime.toString_ start)
  -- [/EXAMPLE]

exampleGetTimeZoneTransition :: Effect Unit
exampleGetTimeZoneTransition = do
  -- [EXAMPLE JS.Temporal.ZonedDateTime.getTimeZoneTransition]
  zoned <- ZonedDateTime.from_ "2024-03-09T12:00:00-05:00[America/New_York]"
  case ZonedDateTime.getTimeZoneTransition "next" zoned of
    Nothing -> Console.log "No transition"
    Just transition -> Console.log (ZonedDateTime.toString_ transition)
  -- [/EXAMPLE]

exampleToInstant :: Effect Unit
exampleToInstant = do
  -- [EXAMPLE JS.Temporal.ZonedDateTime.toInstant]
  zoned <- ZonedDateTime.from_ "2024-01-15T12:00:00-05:00[America/New_York]"
  Console.log (Instant.toString_ (ZonedDateTime.toInstant zoned))
  -- [/EXAMPLE]

exampleToPlainDateTime :: Effect Unit
exampleToPlainDateTime = do
  -- [EXAMPLE JS.Temporal.ZonedDateTime.toPlainDateTime]
  zoned <- ZonedDateTime.from_ "2024-01-15T12:00:00-05:00[America/New_York]"
  Console.log (PlainDateTime.toString_ (ZonedDateTime.toPlainDateTime zoned))
  -- [/EXAMPLE]

exampleToPlainDate :: Effect Unit
exampleToPlainDate = do
  -- [EXAMPLE JS.Temporal.ZonedDateTime.toPlainDate]
  zoned <- ZonedDateTime.from_ "2024-01-15T12:00:00-05:00[America/New_York]"
  Console.log (PlainDate.toString_ (ZonedDateTime.toPlainDate zoned))
  -- [/EXAMPLE]

exampleToPlainTime :: Effect Unit
exampleToPlainTime = do
  -- [EXAMPLE JS.Temporal.ZonedDateTime.toPlainTime]
  zoned <- ZonedDateTime.from_ "2024-01-15T12:00:00-05:00[America/New_York]"
  Console.log (PlainTime.toString_ (ZonedDateTime.toPlainTime zoned))
  -- [/EXAMPLE]

exampleToPlainYearMonth :: Effect Unit
exampleToPlainYearMonth = do
  -- [EXAMPLE JS.Temporal.ZonedDateTime.toPlainYearMonth]
  zoned <- ZonedDateTime.from_ "2024-01-15T12:00:00-05:00[America/New_York]"
  Console.log (PlainYearMonth.toString_ (ZonedDateTime.toPlainYearMonth zoned))
  -- [/EXAMPLE]

exampleToPlainMonthDay :: Effect Unit
exampleToPlainMonthDay = do
  -- [EXAMPLE JS.Temporal.ZonedDateTime.toPlainMonthDay]
  zoned <- ZonedDateTime.from_ "2024-01-15T12:00:00-05:00[America/New_York]"
  Console.log (PlainMonthDay.toString_ (ZonedDateTime.toPlainMonthDay zoned))
  -- [/EXAMPLE]

exampleToString :: Effect Unit
exampleToString = do
  -- [EXAMPLE JS.Temporal.ZonedDateTime.toString]
  zoned <- ZonedDateTime.from_ "2024-01-15T12:00:00.123456789-05:00[America/New_York]"
  Console.log
    ( ZonedDateTime.toString
        { smallestUnit: TemporalUnit.Minute
        , calendarName: CalendarName.Never
        }
        zoned
    )
  -- [/EXAMPLE]
