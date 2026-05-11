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

exampleFromString :: Effect Unit
exampleFromString = do
  locale <- JS.Intl.Locale.new_ "en-US"
  instant <- Instant.fromString "2024-01-15T12:00:00Z"
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium", timeZone: "UTC" }
  Console.log (JS.Intl.DateTimeFormat.format formatter instant)

exampleFromEpochMilliseconds :: Effect Unit
exampleFromEpochMilliseconds = do
  instant <- Instant.fromEpochMilliseconds 1000.0
  Console.log (Instant.toString instant)

exampleFromEpochNanoseconds :: Effect Unit
exampleFromEpochNanoseconds = do
  instant <- Instant.fromEpochNanoseconds (BigInt.fromInt 1000000000)
  Console.log (Instant.toString instant)

exampleFromJSDate :: Effect Unit
exampleFromJSDate = do
  jsDate <- JSDate.parse "2024-01-15T12:00:00Z"
  instant <- Instant.fromJSDate jsDate
  Console.log (Instant.toString instant)

exampleEpochMilliseconds :: Effect Unit
exampleEpochMilliseconds = do
  instant <- Instant.fromString "1970-01-01T00:00:01Z"
  Console.log ("Epoch ms: " <> show (Instant.epochMilliseconds instant))

exampleEpochNanoseconds :: Effect Unit
exampleEpochNanoseconds = do
  instant <- Instant.fromString "1970-01-01T00:00:01Z"
  Console.log ("Epoch ns: " <> show (Instant.epochNanoseconds instant))

exampleAdd :: Effect Unit
exampleAdd = do
  instant <- Instant.fromString "2024-01-15T12:00:00Z"
  oneHour <- Duration.from { hours: 1 }
  later <- Instant.add oneHour instant
  Console.log (Instant.toString later)

exampleSubtract :: Effect Unit
exampleSubtract = do
  instant <- Instant.fromString "2024-01-15T12:00:00Z"
  oneHour <- Duration.from { hours: 1 }
  earlier <- Instant.subtract oneHour instant
  Console.log (Instant.toString earlier)

exampleUntilWithOptions :: Effect Unit
exampleUntilWithOptions = do
  locale <- JS.Intl.Locale.new_ "en-US"
  earlier <- Instant.fromString "2020-01-09T00:00Z"
  later <- Instant.fromString "2020-01-09T04:00Z"
  result <- Instant.untilWithOptions { largestUnit: TemporalUnit.Hour } later earlier
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log ("4 hours: " <> JS.Intl.DurationFormat.format formatter result)

exampleUntil :: Effect Unit
exampleUntil = do
  earlier <- Instant.fromString "2020-01-09T00:00Z"
  later <- Instant.fromString "2020-01-09T04:00Z"
  result <- Instant.until later earlier
  Console.log (Duration.toString result)

exampleSinceWithOptions :: Effect Unit
exampleSinceWithOptions = do
  locale <- JS.Intl.Locale.new_ "en-US"
  earlier <- Instant.fromString "2020-01-09T00:00Z"
  later <- Instant.fromString "2020-01-09T04:00Z"
  elapsed <- Instant.sinceWithOptions { largestUnit: TemporalUnit.Hour } earlier later
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log ("Elapsed: " <> JS.Intl.DurationFormat.format formatter elapsed)

exampleSince :: Effect Unit
exampleSince = do
  earlier <- Instant.fromString "2020-01-09T00:00Z"
  later <- Instant.fromString "2020-01-09T04:00Z"
  elapsed <- Instant.since earlier later
  Console.log (Duration.toString elapsed)

exampleRound :: Effect Unit
exampleRound = do
  instant <- Instant.fromString "2024-01-15T12:00:00.789Z"
  rounded <- Instant.round
    { smallestUnit: TemporalUnit.Second
    , roundingMode: RoundingMode.HalfExpand
    }
    instant
  Console.log (Instant.toString rounded)

exampleFromDateTimeInstant :: Effect Unit
exampleFromDateTimeInstant = do
  let dtInstant = DateTime.Instant.fromDateTime bottom
  instant <- Instant.fromDateTimeInstant dtInstant
  Console.log (Instant.toString instant)

exampleToDateTimeInstant :: Effect Unit
exampleToDateTimeInstant = do
  instant <- Instant.fromString "2024-01-15T12:00:00Z"
  case Instant.toDateTimeInstant instant of
    Just dtInstant -> Console.log (show dtInstant)
    Nothing -> Console.log "Out of range"

exampleToZonedDateTimeISO :: Effect Unit
exampleToZonedDateTimeISO = do
  instant <- Instant.fromString "2024-01-15T12:00:00Z"
  zoned <- pure (Instant.toZonedDateTimeISO "America/New_York" instant)
  Console.log (ZonedDateTime.toString zoned)

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

exampleToString :: Effect Unit
exampleToString = do
  instant <- Instant.fromString "2024-01-15T12:00:00.789Z"
  Console.log (Instant.toString instant)
