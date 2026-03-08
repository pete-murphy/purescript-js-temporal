-- | Compilable doc examples for JS.Temporal.PlainDateTime.
-- | Markers [EXAMPLE JS.Temporal.PlainDateTime.fn] / [/EXAMPLE] delimit
-- | regions that are extracted by script/sync-doc-examples.mjs.
module Examples.Docs.PlainDateTime where

import Prelude

import Data.Int as Int
import Effect (Effect)
import Effect.Class.Console as Console
import JS.Intl.DateTimeFormat as JS.Intl.DateTimeFormat
import JS.Intl.DurationFormat as JS.Intl.DurationFormat
import JS.Intl.NumberFormat as JS.Intl.NumberFormat
import JS.Intl.Options.DurationFormatStyle as JS.Intl.Options.DurationFormatStyle
import JS.Intl.Locale as Locale
import JS.Temporal.Duration as Duration
import JS.Temporal.Now as Now
import JS.Temporal.Options.Overflow as Overflow
import JS.Temporal.Options.TemporalUnit as TemporalUnit
import JS.Temporal.PlainDateTime as PlainDateTime

exampleNew :: Effect Unit
exampleNew = do
  -- [EXAMPLE JS.Temporal.PlainDateTime.new]
  locale <- Locale.new_ "en-US"
  dateTime <- PlainDateTime.new
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

exampleFrom :: Effect Unit
exampleFrom = do
  -- [EXAMPLE JS.Temporal.PlainDateTime.from_]
  locale <- Locale.new_ "en-US"
  dateTime <- PlainDateTime.from_ "2024-01-15T09:30:00"
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter dateTime)
  -- [/EXAMPLE]

exampleFromWithOptions :: Effect Unit
exampleFromWithOptions = do
  -- [EXAMPLE JS.Temporal.PlainDateTime.from]
  locale <- Locale.new_ "en-US"
  dateTime <- PlainDateTime.from { overflow: Overflow.Constrain } "2024-01-15T09:30:00"
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter dateTime)
  -- [/EXAMPLE]

exampleAdd :: Effect Unit
exampleAdd = do
  -- [EXAMPLE JS.Temporal.PlainDateTime.add_]
  locale <- Locale.new_ "en-US"
  start <- PlainDateTime.from_ "2024-01-15T09:00:00"
  twoHours <- Duration.new { hours: 2 }
  end <- PlainDateTime.add_ twoHours start
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter end)
  -- [/EXAMPLE]

exampleSubtract :: Effect Unit
exampleSubtract = do
  -- [EXAMPLE JS.Temporal.PlainDateTime.subtract_]
  locale <- Locale.new_ "en-US"
  start <- PlainDateTime.from_ "2024-01-15T11:00:00"
  twoHours <- Duration.new { hours: 2 }
  earlier <- PlainDateTime.subtract_ twoHours start
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter earlier)
  -- [/EXAMPLE]

exampleWith :: Effect Unit
exampleWith = do
  -- [EXAMPLE JS.Temporal.PlainDateTime.with_]
  locale <- Locale.new_ "en-US"
  dateTime <- PlainDateTime.from_ "2024-01-15T09:30:45"
  noon <- PlainDateTime.with_ { hour: 12, minute: 0, second: 0 } dateTime
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter noon)
  -- [/EXAMPLE]

exampleRound :: Effect Unit
exampleRound = do
  -- [EXAMPLE JS.Temporal.PlainDateTime.round]
  locale <- Locale.new_ "en-US"
  dateTime <- PlainDateTime.from_ "2024-01-15T09:30:45.123"
  rounded <- PlainDateTime.round { smallestUnit: TemporalUnit.Minute } dateTime
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter rounded)
  -- [/EXAMPLE]

exampleToString :: Effect Unit
exampleToString = do
  -- [EXAMPLE JS.Temporal.PlainDateTime.toString_]
  locale <- Locale.new_ "en-US"
  dateTime <- PlainDateTime.from_ "2024-01-15T09:30:00"
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter dateTime)
  -- [/EXAMPLE]

exampleToZonedDateTime :: Effect Unit
exampleToZonedDateTime = do
  -- [EXAMPLE JS.Temporal.PlainDateTime.toZonedDateTime]
  locale <- Locale.new_ "en-US"
  plain <- PlainDateTime.from_ "2024-01-15T09:30:00"
  zoned <- PlainDateTime.toZonedDateTime "America/New_York" plain
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter zoned)
  -- [/EXAMPLE]

exampleUntil :: Effect Unit
exampleUntil = do
  -- [EXAMPLE JS.Temporal.PlainDateTime.until]
  locale <- Locale.new_ "en-US"
  now <- Now.plainDateTimeISO_
    >>= PlainDateTime.round { smallestUnit: TemporalUnit.Second }
  nextBilling <- do
    aprilFirst <- PlainDateTime.new
      { year: PlainDateTime.year now
      , month: 4
      , day: 1
      }
    if aprilFirst < now then do
      oneYear <- Duration.new { years: 1 }
      PlainDateTime.add_ oneYear aprilFirst
    else
      pure aprilFirst

  duration <- PlainDateTime.until
    { largestUnit: TemporalUnit.Day }
    nextBilling
    now
  durationFormatter <- JS.Intl.DurationFormat.new [ locale ] { style: JS.Intl.Options.DurationFormatStyle.Long }
  Console.log (JS.Intl.DurationFormat.format durationFormatter duration <> " until next billing")
  -- [/EXAMPLE]

exampleSince :: Effect Unit
exampleSince = do
  -- [EXAMPLE JS.Temporal.PlainDateTime.since]
  locale <- Locale.new_ "en-US"
  start <- PlainDateTime.from_ "2024-01-01T00:00:00"
  end <- PlainDateTime.from_ "2024-03-15T12:00:00"
  elapsed <- PlainDateTime.since { largestUnit: TemporalUnit.Day } start end
  numberFormatter <- JS.Intl.NumberFormat.new [ locale ] {}
  Console.log ("Elapsed: " <> JS.Intl.NumberFormat.format numberFormatter (Int.toNumber (Duration.days elapsed)) <> " days")
  -- [/EXAMPLE]
