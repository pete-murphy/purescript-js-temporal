-- | Compilable doc examples for JS.Temporal.PlainDateTime.
-- | Markers [EXAMPLE JS.Temporal.PlainDateTime.fn] / [/EXAMPLE] delimit
-- | regions that are extracted by script/sync-doc-examples.mjs.
module Examples.Docs.PlainDateTime where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Intl.DateTimeFormat as JS.Intl.DateTimeFormat
import JS.Intl.DurationFormat as JS.Intl.DurationFormat
import JS.Intl.Options.DurationFormatStyle as JS.Intl.Options.DurationFormatStyle
import JS.Intl.Locale as JS.Intl.Locale
import JS.Temporal.Duration as Duration
import JS.Temporal.Now as Now
import JS.Temporal.Options.Overflow as Overflow
import JS.Temporal.Options.TemporalUnit as TemporalUnit
import JS.Temporal.PlainDateTime as PlainDateTime
import JS.Temporal.PlainTime as PlainTime

exampleFrom_ :: Effect Unit
exampleFrom_ = do
  -- [EXAMPLE JS.Temporal.PlainDateTime.from_]
  locale <- JS.Intl.Locale.new_ "en-US"
  dateTime <- PlainDateTime.from_
    { year: 2024
    , month: 1
    , day: 15
    , hour: 9
    , minute: 30
    , second: 0
    }
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter dateTime)
  -- [/EXAMPLE]

exampleFromString :: Effect Unit
exampleFromString = do
  -- [EXAMPLE JS.Temporal.PlainDateTime.fromString]
  locale <- JS.Intl.Locale.new_ "en-US"
  dateTime <- PlainDateTime.fromString { overflow: Overflow.Constrain } "2024-01-15T09:30:00"
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter dateTime)
  -- [/EXAMPLE]

exampleAdd :: Effect Unit
exampleAdd = do
  -- [EXAMPLE JS.Temporal.PlainDateTime.add]
  locale <- JS.Intl.Locale.new_ "en-US"
  start <- PlainDateTime.fromString_ "2024-01-15T09:00:00"
  twoHours <- Duration.from { hours: 2 }
  end <- PlainDateTime.add { overflow: Overflow.Constrain } twoHours start
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter end)
  -- [/EXAMPLE]

exampleSubtract :: Effect Unit
exampleSubtract = do
  -- [EXAMPLE JS.Temporal.PlainDateTime.subtract]
  locale <- JS.Intl.Locale.new_ "en-US"
  start <- PlainDateTime.fromString_ "2024-01-15T11:00:00"
  twoHours <- Duration.from { hours: 2 }
  earlier <- PlainDateTime.subtract { overflow: Overflow.Constrain } twoHours start
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter earlier)
  -- [/EXAMPLE]

exampleWith :: Effect Unit
exampleWith = do
  -- [EXAMPLE JS.Temporal.PlainDateTime.with]
  locale <- JS.Intl.Locale.new_ "en-US"
  dateTime <- PlainDateTime.fromString_ "2024-01-15T09:30:45"
  noon <- PlainDateTime.with { overflow: Overflow.Constrain } { hour: 12, minute: 0, second: 0 } dateTime
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter noon)
  -- [/EXAMPLE]

exampleWithPlainTime :: Effect Unit
exampleWithPlainTime = do
  -- [EXAMPLE JS.Temporal.PlainDateTime.withPlainTime]
  locale <- JS.Intl.Locale.new_ "en-US"
  dateTime <- PlainDateTime.fromString_ "2024-01-15T09:30:00"
  closingTime <- PlainTime.fromString_ "17:00:00"
  updated <- PlainDateTime.withPlainTime closingTime dateTime
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter updated)
  -- [/EXAMPLE]

exampleWithCalendar :: Effect Unit
exampleWithCalendar = do
  -- [EXAMPLE JS.Temporal.PlainDateTime.withCalendar]
  dateTime <- PlainDateTime.fromString_ "2019-05-01T09:30:00"
  japanese <- PlainDateTime.withCalendar "japanese" dateTime
  Console.log (PlainDateTime.calendarId japanese)
  -- [/EXAMPLE]

exampleRound :: Effect Unit
exampleRound = do
  -- [EXAMPLE JS.Temporal.PlainDateTime.round]
  locale <- JS.Intl.Locale.new_ "en-US"
  dateTime <- PlainDateTime.fromString_ "2024-01-15T09:30:45.123"
  rounded <- PlainDateTime.round { smallestUnit: TemporalUnit.Minute } dateTime
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter rounded)
  -- [/EXAMPLE]

exampleToString :: Effect Unit
exampleToString = do
  -- [EXAMPLE JS.Temporal.PlainDateTime.toString]
  dateTime <- PlainDateTime.fromString_ "2024-01-15T09:30:00"
  Console.log (PlainDateTime.toString { smallestUnit: TemporalUnit.Minute } dateTime)
  -- [/EXAMPLE]

exampleToPlainDate :: Effect Unit
exampleToPlainDate = do
  -- [EXAMPLE JS.Temporal.PlainDateTime.toPlainDate]
  locale <- JS.Intl.Locale.new_ "en-US"
  dateTime <- PlainDateTime.fromString_ "2024-01-15T09:30:00"
  date <- pure (PlainDateTime.toPlainDate dateTime)
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter date)
  -- [/EXAMPLE]

exampleToPlainTime :: Effect Unit
exampleToPlainTime = do
  -- [EXAMPLE JS.Temporal.PlainDateTime.toPlainTime]
  locale <- JS.Intl.Locale.new_ "en-US"
  dateTime <- PlainDateTime.fromString_ "2024-01-15T09:30:00"
  time <- pure (PlainDateTime.toPlainTime dateTime)
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter time)
  -- [/EXAMPLE]

exampleToZonedDateTime :: Effect Unit
exampleToZonedDateTime = do
  -- [EXAMPLE JS.Temporal.PlainDateTime.toZonedDateTime]
  locale <- JS.Intl.Locale.new_ "en-US"
  plain <- PlainDateTime.fromString_ "2024-01-15T09:30:00"
  zoned <- PlainDateTime.toZonedDateTime "America/New_York" plain
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter zoned)
  -- [/EXAMPLE]

exampleUntil :: Effect Unit
exampleUntil = do
  -- [EXAMPLE JS.Temporal.PlainDateTime.until]
  locale <- JS.Intl.Locale.new_ "en-US"
  now <- Now.plainDateTimeISO_
    >>= PlainDateTime.round { smallestUnit: TemporalUnit.Second }
  nextBilling <- do
    aprilFirst <- PlainDateTime.from_
      { year: PlainDateTime.year now
      , month: 4
      , day: 1
      }
    if aprilFirst < now then do
      oneYear <- Duration.from { years: 1 }
      PlainDateTime.add_ oneYear aprilFirst
    else
      pure aprilFirst

  duration <- PlainDateTime.until
    { smallestUnit: TemporalUnit.Day }
    nextBilling
    now
  durationFormatter <- JS.Intl.DurationFormat.new [ locale ] { style: JS.Intl.Options.DurationFormatStyle.Long }
  Console.log (JS.Intl.DurationFormat.format durationFormatter duration <> " until next billing")
  -- [/EXAMPLE]

exampleSince :: Effect Unit
exampleSince = do
  -- [EXAMPLE JS.Temporal.PlainDateTime.since]
  locale <- JS.Intl.Locale.new_ "en-US"
  start <- PlainDateTime.fromString_ "2024-01-01T00:00:00"
  end <- PlainDateTime.fromString_ "2024-03-15T12:00:00"
  elapsed <- PlainDateTime.since { largestUnit: TemporalUnit.Day } start end
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: JS.Intl.Options.DurationFormatStyle.Long }
  Console.log ("Elapsed: " <> JS.Intl.DurationFormat.format formatter elapsed)
  -- [/EXAMPLE]
