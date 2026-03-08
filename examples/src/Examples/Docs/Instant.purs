-- | Compilable doc examples for JS.Temporal.Instant.
module Examples.Docs.Instant where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.BigInt as BigInt
import JS.Intl.DateTimeFormat as JS.Intl.DateTimeFormat
import JS.Intl.DurationFormat as JS.Intl.DurationFormat
import JS.Intl.Locale as JS.Intl.Locale
import JS.Temporal.Duration as Duration
import JS.Temporal.Instant as Instant
import JS.Temporal.Options.RoundingMode as RoundingMode
import JS.Temporal.Options.TemporalUnit as TemporalUnit
import JS.Temporal.ZonedDateTime as ZonedDateTime

exampleNew :: Effect Unit
exampleNew = do
  -- [EXAMPLE JS.Temporal.Instant.new]
  locale <- JS.Intl.Locale.new_ "en-US"
  instant <- Instant.new (BigInt.fromInt 0)
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium", timeZone: "UTC" }
  Console.log (JS.Intl.DateTimeFormat.format formatter instant)
  -- [/EXAMPLE]

exampleFrom :: Effect Unit
exampleFrom = do
  -- [EXAMPLE JS.Temporal.Instant.from]
  locale <- JS.Intl.Locale.new_ "en-US"
  instant <- Instant.from "2024-01-15T12:00:00Z"
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium", timeZone: "UTC" }
  Console.log (JS.Intl.DateTimeFormat.format formatter instant)
  -- [/EXAMPLE]

exampleFromEpochMilliseconds :: Effect Unit
exampleFromEpochMilliseconds = do
  -- [EXAMPLE JS.Temporal.Instant.fromEpochMilliseconds]
  instant <- Instant.fromEpochMilliseconds 1000.0
  Console.log (Instant.toString_ instant)
  -- [/EXAMPLE]

exampleFromEpochNanoseconds :: Effect Unit
exampleFromEpochNanoseconds = do
  -- [EXAMPLE JS.Temporal.Instant.fromEpochNanoseconds]
  instant <- Instant.fromEpochNanoseconds (BigInt.fromInt 1000000000)
  Console.log (Instant.toString_ instant)
  -- [/EXAMPLE]

exampleAdd :: Effect Unit
exampleAdd = do
  -- [EXAMPLE JS.Temporal.Instant.add]
  instant <- Instant.from "2024-01-15T12:00:00Z"
  oneHour <- Duration.new { hours: 1 }
  later <- Instant.add oneHour instant
  Console.log (Instant.toString_ later)
  -- [/EXAMPLE]

exampleSubtract :: Effect Unit
exampleSubtract = do
  -- [EXAMPLE JS.Temporal.Instant.subtract]
  instant <- Instant.from "2024-01-15T12:00:00Z"
  oneHour <- Duration.new { hours: 1 }
  earlier <- Instant.subtract oneHour instant
  Console.log (Instant.toString_ earlier)
  -- [/EXAMPLE]

exampleUntil :: Effect Unit
exampleUntil = do
  -- [EXAMPLE JS.Temporal.Instant.until]
  locale <- JS.Intl.Locale.new_ "en-US"
  earlier <- Instant.from "2020-01-09T00:00Z"
  later <- Instant.from "2020-01-09T04:00Z"
  result <- Instant.until { largestUnit: TemporalUnit.Hour } later earlier
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log ("4 hours: " <> JS.Intl.DurationFormat.format formatter result)
  -- [/EXAMPLE]

exampleSince :: Effect Unit
exampleSince = do
  -- [EXAMPLE JS.Temporal.Instant.since]
  locale <- JS.Intl.Locale.new_ "en-US"
  earlier <- Instant.from "2020-01-09T00:00Z"
  later <- Instant.from "2020-01-09T04:00Z"
  elapsed <- Instant.since { largestUnit: TemporalUnit.Hour } earlier later
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log ("Elapsed: " <> JS.Intl.DurationFormat.format formatter elapsed)
  -- [/EXAMPLE]

exampleRound :: Effect Unit
exampleRound = do
  -- [EXAMPLE JS.Temporal.Instant.round]
  instant <- Instant.from "2024-01-15T12:00:00.789Z"
  rounded <- Instant.round
    { smallestUnit: TemporalUnit.Second
    , roundingMode: RoundingMode.HalfExpand
    }
    instant
  Console.log (Instant.toString_ rounded)
  -- [/EXAMPLE]

exampleToZonedDateTimeISO :: Effect Unit
exampleToZonedDateTimeISO = do
  -- [EXAMPLE JS.Temporal.Instant.toZonedDateTimeISO]
  instant <- Instant.from "2024-01-15T12:00:00Z"
  zoned <- pure (Instant.toZonedDateTimeISO "America/New_York" instant)
  Console.log (ZonedDateTime.toString_ zoned)
  -- [/EXAMPLE]

exampleToString :: Effect Unit
exampleToString = do
  -- [EXAMPLE JS.Temporal.Instant.toString]
  instant <- Instant.from "2024-01-15T12:00:00.789Z"
  Console.log
    ( Instant.toString
        { smallestUnit: TemporalUnit.Second
        , timeZone: "UTC"
        }
        instant
    )
  -- [/EXAMPLE]
