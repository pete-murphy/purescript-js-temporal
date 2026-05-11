-- | Compilable doc examples for JS.Temporal.PlainDateTime.
-- | Markers [EXAMPLE JS.Temporal.PlainDateTime.fn] / [/EXAMPLE] delimit
-- | regions that are extracted by script/sync-doc-examples.mjs.
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
import JS.Temporal.PlainDateTime as PlainDateTime
import JS.Temporal.PlainTime as PlainTime

-- [EXAMPLE JS.Temporal.PlainDateTime.from]
exampleFrom :: Effect Unit
exampleFrom = do
  locale <- JS.Intl.Locale.new_ "en-US"
  dateTime <- PlainDateTime.from
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

-- [EXAMPLE JS.Temporal.PlainDateTime.fromString]
exampleFromString :: Effect Unit
exampleFromString = do
  locale <- JS.Intl.Locale.new_ "en-US"
  dateTime <- PlainDateTime.fromStringWithOptions { overflow: Overflow.Constrain } "2024-01-15T09:30:00"
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter dateTime)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.PlainDateTime.add]
exampleAdd :: Effect Unit
exampleAdd = do
  locale <- JS.Intl.Locale.new_ "en-US"
  start <- PlainDateTime.fromString "2024-01-15T09:00:00"
  twoHours <- Duration.from { hours: 2 }
  end <- PlainDateTime.addWithOptions { overflow: Overflow.Constrain } twoHours start
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter end)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.PlainDateTime.subtract]
exampleSubtract :: Effect Unit
exampleSubtract = do
  locale <- JS.Intl.Locale.new_ "en-US"
  start <- PlainDateTime.fromString "2024-01-15T11:00:00"
  twoHours <- Duration.from { hours: 2 }
  earlier <- PlainDateTime.subtractWithOptions { overflow: Overflow.Constrain } twoHours start
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter earlier)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.PlainDateTime.with]
exampleWith :: Effect Unit
exampleWith = do
  locale <- JS.Intl.Locale.new_ "en-US"
  dateTime <- PlainDateTime.fromString "2024-01-15T09:30:45"
  noon <- PlainDateTime.withWithOptions { overflow: Overflow.Constrain } { hour: 12, minute: 0, second: 0 } dateTime
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter noon)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.PlainDateTime.withPlainTime]
exampleWithPlainTime :: Effect Unit
exampleWithPlainTime = do
  locale <- JS.Intl.Locale.new_ "en-US"
  dateTime <- PlainDateTime.fromString "2024-01-15T09:30:00"
  closingTime <- PlainTime.fromString "17:00:00"
  updated <- PlainDateTime.withPlainTime closingTime dateTime
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter updated)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.PlainDateTime.withCalendar]
exampleWithCalendar :: Effect Unit
exampleWithCalendar = do
  dateTime <- PlainDateTime.fromString "2019-05-01T09:30:00"
  japanese <- PlainDateTime.withCalendar "japanese" dateTime
  Console.log (PlainDateTime.calendarId japanese)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.PlainDateTime.round]
exampleRound :: Effect Unit
exampleRound = do
  locale <- JS.Intl.Locale.new_ "en-US"
  dateTime <- PlainDateTime.fromString "2024-01-15T09:30:45.123"
  rounded <- PlainDateTime.round { smallestUnit: TemporalUnit.Minute } dateTime
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter rounded)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.PlainDateTime.toString]
exampleToString :: Effect Unit
exampleToString = do
  dateTime <- PlainDateTime.fromString "2024-01-15T09:30:00"
  Console.log (PlainDateTime.toStringWithOptions { smallestUnit: TemporalUnit.Minute } dateTime)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.PlainDateTime.toPlainDate]
exampleToPlainDate :: Effect Unit
exampleToPlainDate = do
  locale <- JS.Intl.Locale.new_ "en-US"
  dateTime <- PlainDateTime.fromString "2024-01-15T09:30:00"
  date <- pure (PlainDateTime.toPlainDate dateTime)
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter date)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.PlainDateTime.toPlainTime]
exampleToPlainTime :: Effect Unit
exampleToPlainTime = do
  locale <- JS.Intl.Locale.new_ "en-US"
  dateTime <- PlainDateTime.fromString "2024-01-15T09:30:00"
  time <- pure (PlainDateTime.toPlainTime dateTime)
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter time)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.PlainDateTime.toZonedDateTime]
exampleToZonedDateTime :: Effect Unit
exampleToZonedDateTime = do
  locale <- JS.Intl.Locale.new_ "en-US"
  plain <- PlainDateTime.fromString "2024-01-15T09:30:00"
  zoned <- PlainDateTime.toZonedDateTime "America/New_York" plain
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter zoned)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.PlainDateTime.until]
exampleUntil :: Effect Unit
exampleUntil = do
  locale <- JS.Intl.Locale.new_ "en-US"
  now <- Now.plainDateTimeISO
    >>= PlainDateTime.round { smallestUnit: TemporalUnit.Second }
  nextBilling <- do
    aprilFirst <- PlainDateTime.from
      { year: PlainDateTime.year now
      , month: 4
      , day: 1
      }
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

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.PlainDateTime.since]
exampleSince :: Effect Unit
exampleSince = do
  locale <- JS.Intl.Locale.new_ "en-US"
  start <- PlainDateTime.fromString "2024-01-01T00:00:00"
  end <- PlainDateTime.fromString "2024-03-15T12:00:00"
  elapsed <- PlainDateTime.sinceWithOptions { largestUnit: TemporalUnit.Day } start end
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: JS.Intl.Options.DurationFormatStyle.Long }
  Console.log ("Elapsed: " <> JS.Intl.DurationFormat.format formatter elapsed)
-- [/EXAMPLE]

