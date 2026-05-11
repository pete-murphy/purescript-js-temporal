-- | Compilable doc examples for JS.Temporal.PlainTime.
module Examples.Docs.PlainTime where

import Prelude


import Effect (Effect)
import Effect.Class.Console as Console
import JS.Intl.DateTimeFormat as JS.Intl.DateTimeFormat
import JS.Intl.DurationFormat as JS.Intl.DurationFormat
import JS.Intl.Locale as JS.Intl.Locale
import JS.Temporal.Duration as Duration
import JS.Temporal.Options.Overflow as Overflow
import JS.Temporal.Options.TemporalUnit as TemporalUnit
import JS.Temporal.PlainTime as PlainTime

-- | Creates a PlainTime from component fields. Options: overflow.
exampleFromWithOptions :: Effect Unit
exampleFromWithOptions = do
  time <- PlainTime.fromWithOptions { overflow: Overflow.Constrain }
    { hour: 9, minute: 30, second: 0 }
  Console.log (PlainTime.toString time)

-- | Same as [`fromWithOptions`](#v:fromWithOptions) with default options.
exampleFrom :: Effect Unit
exampleFrom = do
  locale <- JS.Intl.Locale.new_ "en-US"
  time <- PlainTime.from { hour: 9, minute: 30, second: 0 }
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter time)

-- | Parses a time string (e.g. `"15:30:00"`). Options: overflow. Throws on invalid input.
exampleFromStringWithOptions :: Effect Unit
exampleFromStringWithOptions = do
  time <- PlainTime.fromStringWithOptions { overflow: Overflow.Constrain } "15:30:00"
  Console.log (PlainTime.toString time)

-- | Same as [`fromStringWithOptions`](#v:fromStringWithOptions) with default options.
exampleFromString :: Effect Unit
exampleFromString = do
  locale <- JS.Intl.Locale.new_ "en-US"
  time <- PlainTime.fromString "15:30:00"
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter time)

-- | Hour component.
exampleHour :: Effect Unit
exampleHour = do
  time <- PlainTime.fromString "14:30:45"
  Console.log ("Hour: " <> show (PlainTime.hour time))

-- | Minute component.
exampleMinute :: Effect Unit
exampleMinute = do
  time <- PlainTime.fromString "14:30:45"
  Console.log ("Minute: " <> show (PlainTime.minute time))

-- | Second component.
exampleSecond :: Effect Unit
exampleSecond = do
  time <- PlainTime.fromString "14:30:45"
  Console.log ("Second: " <> show (PlainTime.second time))

-- | Millisecond component.
exampleMillisecond :: Effect Unit
exampleMillisecond = do
  time <- PlainTime.fromString "14:30:45.123"
  Console.log ("Millisecond: " <> show (PlainTime.millisecond time))

-- | Microsecond component.
exampleMicrosecond :: Effect Unit
exampleMicrosecond = do
  time <- PlainTime.fromString "14:30:45.123456"
  Console.log ("Microsecond: " <> show (PlainTime.microsecond time))

-- | Nanosecond component.
exampleNanosecond :: Effect Unit
exampleNanosecond = do
  time <- PlainTime.fromString "14:30:45.123456789"
  Console.log ("Nanosecond: " <> show (PlainTime.nanosecond time))

-- | Adds a duration. Wraps at 24 hours. Throws for calendar durations.
exampleAdd :: Effect Unit
exampleAdd = do
  time <- PlainTime.fromString "14:30:00"
  twoHours <- Duration.from { hours: 2 }
  later <- PlainTime.add twoHours time
  Console.log (PlainTime.toString later)

-- | Subtracts a duration. Arg order: `subtract duration subject`. Wraps at 24 hours.
exampleSubtract :: Effect Unit
exampleSubtract = do
  time <- PlainTime.fromString "14:30:00"
  twoHours <- Duration.from { hours: 2 }
  earlier <- PlainTime.subtract twoHours time
  Console.log (PlainTime.toString earlier)

-- | Returns a new PlainTime with specified fields replaced. Options: overflow.
exampleWithWithOptions :: Effect Unit
exampleWithWithOptions = do
  time <- PlainTime.fromString "15:30:45"
  noon <- PlainTime.withWithOptions { overflow: Overflow.Constrain } { hour: 12, minute: 0, second: 0 } time
  Console.log (PlainTime.toString noon)

-- | Same as [`withWithOptions`](#v:withWithOptions) with default options.
exampleWith :: Effect Unit
exampleWith = do
  time <- PlainTime.fromString "15:30:45"
  noon <- PlainTime.with { hour: 12, minute: 0, second: 0 } time
  Console.log (PlainTime.toString noon)

-- | Duration from `subject` (last arg) until `other` (second arg). Arg order: `untilWithOptions options other subject`.
exampleUntilWithOptions :: Effect Unit
exampleUntilWithOptions = do
  locale <- JS.Intl.Locale.new_ "en-US"
  start <- PlainTime.fromString "09:00:00"
  end <- PlainTime.fromString "17:30:00"
  duration <- PlainTime.untilWithOptions { largestUnit: TemporalUnit.Hour } end start
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter duration)

-- | Same as [`untilWithOptions`](#v:untilWithOptions) with default options.
exampleUntil :: Effect Unit
exampleUntil = do
  start <- PlainTime.fromString "09:00:00"
  end <- PlainTime.fromString "17:30:00"
  duration <- PlainTime.until end start
  Console.log (Duration.toString duration)

-- | Duration from `other` to `subject` (inverse of `untilWithOptions`). Arg order: `sinceWithOptions options other subject`.
exampleSinceWithOptions :: Effect Unit
exampleSinceWithOptions = do
  locale <- JS.Intl.Locale.new_ "en-US"
  earlier <- PlainTime.fromString "08:00:00"
  later <- PlainTime.fromString "12:30:00"
  duration <- PlainTime.sinceWithOptions { largestUnit: TemporalUnit.Hour } earlier later
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter duration)

-- | Same as [`sinceWithOptions`](#v:sinceWithOptions) with default options.
exampleSince :: Effect Unit
exampleSince = do
  earlier <- PlainTime.fromString "08:00:00"
  later <- PlainTime.fromString "12:30:00"
  duration <- PlainTime.since earlier later
  Console.log (Duration.toString duration)

-- | Rounds the time to the given smallest unit.
exampleRound :: Effect Unit
exampleRound = do
  time <- PlainTime.fromString "09:30:45.123"
  rounded <- PlainTime.round { smallestUnit: TemporalUnit.Minute } time
  Console.log (PlainTime.toString rounded)

-- | Converts a purescript-datetime `Time` to a `PlainTime`. Microsecond and
-- | nanosecond components are set to zero.
exampleFromTime :: Effect Unit
exampleFromTime = do
  time <- PlainTime.fromString "14:30:00"
  roundTripped <- PlainTime.fromTime (PlainTime.toTime time)
  Console.log (PlainTime.toString roundTripped)

-- | Converts a `PlainTime` to a purescript-datetime `Time`.
-- | Microsecond and nanosecond are dropped (treated as zero).
exampleToTime :: Effect Unit
exampleToTime = do
  time <- PlainTime.fromString "14:30:00"
  Console.log (show (PlainTime.toTime time))

-- | Serializes to ISO 8601 time format. Options: fractionalSecondDigits, smallestUnit, roundingMode.
exampleToStringWithOptions :: Effect Unit
exampleToStringWithOptions = do
  time <- PlainTime.fromString "14:30:45.123"
  Console.log (PlainTime.toStringWithOptions { smallestUnit: TemporalUnit.Millisecond } time)

-- | Same as [`toStringWithOptions`](#v:toStringWithOptions) with default options.
exampleToString :: Effect Unit
exampleToString = do
  time <- PlainTime.fromString "14:30:45.123"
  Console.log (PlainTime.toString time)
