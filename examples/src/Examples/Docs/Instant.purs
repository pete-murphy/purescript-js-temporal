-- | Compilable doc examples for JS.Temporal.Instant.
module Examples.Docs.Instant where

import Prelude

import Data.DateTime.Instant as DateTime.Instant
import Data.JSDate as JSDate
import Data.Maybe (Maybe(..))
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

-- | Parses an ISO 8601 instant string (e.g. `"2024-01-15T12:00:00Z"`). Throws on invalid input.
exampleFromString :: Effect Unit
exampleFromString = do
  locale <- JS.Intl.Locale.new_ "en-US"
  instant <- Instant.fromString "2024-01-15T12:00:00Z"
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium", timeZone: "UTC" }
  Console.log (JS.Intl.DateTimeFormat.format formatter instant)

-- | Creates an Instant from epoch milliseconds.
exampleFromEpochMilliseconds :: Effect Unit
exampleFromEpochMilliseconds = do
  instant <- Instant.fromEpochMilliseconds 1000.0
  Console.log (Instant.toString instant)

-- | Creates an Instant from epoch nanoseconds.
exampleFromEpochNanoseconds :: Effect Unit
exampleFromEpochNanoseconds = do
  instant <- Instant.fromEpochNanoseconds (BigInt.fromInt 1000000000)
  Console.log (Instant.toString instant)

-- | Creates an Instant from a JavaScript Date.
exampleFromJSDate :: Effect Unit
exampleFromJSDate = do
  jsDate <- JSDate.parse "2024-01-15T12:00:00Z"
  instant <- Instant.fromJSDate jsDate
  Console.log (Instant.toString instant)

-- | Milliseconds since the Unix epoch.
exampleEpochMilliseconds :: Effect Unit
exampleEpochMilliseconds = do
  instant <- Instant.fromString "1970-01-01T00:00:01Z"
  Console.log ("Epoch ms: " <> show (Instant.epochMilliseconds instant))

-- | Nanoseconds since the Unix epoch.
exampleEpochNanoseconds :: Effect Unit
exampleEpochNanoseconds = do
  instant <- Instant.fromString "1970-01-01T00:00:01Z"
  Console.log ("Epoch ns: " <> show (Instant.epochNanoseconds instant))

-- | Adds a duration to an instant. Throws for calendar durations.
exampleAdd :: Effect Unit
exampleAdd = do
  instant <- Instant.fromString "2024-01-15T12:00:00Z"
  oneHour <- Duration.from { hours: 1 }
  later <- Instant.add oneHour instant
  Console.log (Instant.toString later)

-- | Subtracts a duration. Arg order: `subtract duration instant`.
exampleSubtract :: Effect Unit
exampleSubtract = do
  instant <- Instant.fromString "2024-01-15T12:00:00Z"
  oneHour <- Duration.from { hours: 1 }
  earlier <- Instant.subtract oneHour instant
  Console.log (Instant.toString earlier)

-- | Duration from `subject` (last arg) until `other` (second arg). Arg order: `untilWithOptions options other subject`.
exampleUntilWithOptions :: Effect Unit
exampleUntilWithOptions = do
  locale <- JS.Intl.Locale.new_ "en-US"
  earlier <- Instant.fromString "2020-01-09T00:00Z"
  later <- Instant.fromString "2020-01-09T04:00Z"
  result <- Instant.untilWithOptions { largestUnit: TemporalUnit.Hour } later earlier
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log ("4 hours: " <> JS.Intl.DurationFormat.format formatter result)

-- | Same as [`untilWithOptions`](#v:untilWithOptions) with default options.
exampleUntil :: Effect Unit
exampleUntil = do
  earlier <- Instant.fromString "2020-01-09T00:00Z"
  later <- Instant.fromString "2020-01-09T04:00Z"
  result <- Instant.until later earlier
  Console.log (Duration.toString result)

-- | Duration from `other` to `subject` (inverse of `untilWithOptions`). Arg order: `sinceWithOptions options other subject`.
exampleSinceWithOptions :: Effect Unit
exampleSinceWithOptions = do
  locale <- JS.Intl.Locale.new_ "en-US"
  earlier <- Instant.fromString "2020-01-09T00:00Z"
  later <- Instant.fromString "2020-01-09T04:00Z"
  elapsed <- Instant.sinceWithOptions { largestUnit: TemporalUnit.Hour } earlier later
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log ("Elapsed: " <> JS.Intl.DurationFormat.format formatter elapsed)

-- | Same as [`sinceWithOptions`](#v:sinceWithOptions) with default options.
exampleSince :: Effect Unit
exampleSince = do
  earlier <- Instant.fromString "2020-01-09T00:00Z"
  later <- Instant.fromString "2020-01-09T04:00Z"
  elapsed <- Instant.since earlier later
  Console.log (Duration.toString elapsed)

-- | Rounds the instant to the given smallest unit. Options: smallestUnit, roundingIncrement, roundingMode.
exampleRound :: Effect Unit
exampleRound = do
  instant <- Instant.fromString "2024-01-15T12:00:00.789Z"
  rounded <- Instant.round
    { smallestUnit: TemporalUnit.Second
    , roundingMode: RoundingMode.HalfExpand
    }
    instant
  Console.log (Instant.toString rounded)

-- | Converts a purescript-datetime `Instant` to a Temporal `Instant`.
exampleFromDateTimeInstant :: Effect Unit
exampleFromDateTimeInstant = do
  let dtInstant = DateTime.Instant.fromDateTime bottom
  instant <- Instant.fromDateTimeInstant dtInstant
  Console.log (Instant.toString instant)

-- | Converts a Temporal `Instant` to a purescript-datetime `Instant`.
-- | Returns `Nothing` if the value is outside the datetime Instant range.
exampleToDateTimeInstant :: Effect Unit
exampleToDateTimeInstant = do
  instant <- Instant.fromString "2024-01-15T12:00:00Z"
  case Instant.toDateTimeInstant instant of
    Just dtInstant -> Console.log (show dtInstant)
    Nothing -> Console.log "Out of range"

-- | Converts the instant to a ZonedDateTime in the given time zone (e.g. `"America/New_York"`).
exampleToZonedDateTimeISO :: Effect Unit
exampleToZonedDateTimeISO = do
  instant <- Instant.fromString "2024-01-15T12:00:00Z"
  zoned <- pure (Instant.toZonedDateTimeISO "America/New_York" instant)
  Console.log (ZonedDateTime.toString zoned)

-- | Serializes the instant to ISO 8601 format. Options: fractionalSecondDigits, smallestUnit, roundingMode, timeZone.
exampleToStringWithOptions :: Effect Unit
exampleToStringWithOptions = do
  instant <- Instant.fromString "2024-01-15T12:00:00.789Z"
  Console.log
    ( Instant.toStringWithOptions
        { smallestUnit: TemporalUnit.Second
        , timeZone: "UTC"
        }
        instant
    )

-- | Same as [`toStringWithOptions`](#v:toStringWithOptions) with default options.
exampleToString :: Effect Unit
exampleToString = do
  instant <- Instant.fromString "2024-01-15T12:00:00.789Z"
  Console.log (Instant.toString instant)
