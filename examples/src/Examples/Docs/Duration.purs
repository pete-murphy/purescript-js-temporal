-- | Compilable doc examples for JS.Temporal.Duration.
module Examples.Docs.Duration where

import Prelude

import Data.Maybe (Maybe(..))
import Data.Time.Duration (Milliseconds(..))
import Effect (Effect)
import Effect.Class.Console as Console
import JS.Intl.DurationFormat as JS.Intl.DurationFormat
import JS.Intl.Locale as JS.Intl.Locale
import JS.Intl.NumberFormat as JS.Intl.NumberFormat
import JS.Temporal.Duration as Duration
import JS.Temporal.Options.TemporalUnit as TemporalUnit

-- | Parses an ISO 8601 duration string (e.g. `"PT1H30M"`). Throws on invalid
-- | input. Corresponds to `Temporal.Duration.from()`.
exampleFromString :: Effect Unit
exampleFromString = do
  locale <- JS.Intl.Locale.new_ "en-US"
  duration <- Duration.fromString "PT2H30M"
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter duration)

-- | Creates a Duration from component fields. At least one component must be
-- | provided. Mixed signs are invalid.
exampleFrom :: Effect Unit
exampleFrom = do
  locale <- JS.Intl.Locale.new_ "en-US"
  twoHours <- Duration.from { hours: 2 }
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter twoHours)

-- | Year component of the duration.
exampleYears :: Effect Unit
exampleYears = do
  duration <- Duration.from { years: 3, months: 6 }
  Console.log ("Years: " <> show (Duration.years duration))

-- | Month component of the duration.
exampleMonths :: Effect Unit
exampleMonths = do
  duration <- Duration.from { years: 3, months: 6 }
  Console.log ("Months: " <> show (Duration.months duration))

-- | Week component of the duration.
exampleWeeks :: Effect Unit
exampleWeeks = do
  duration <- Duration.from { weeks: 2 }
  Console.log ("Weeks: " <> show (Duration.weeks duration))

-- | Day component of the duration.
exampleDays :: Effect Unit
exampleDays = do
  duration <- Duration.from { days: 10 }
  Console.log ("Days: " <> show (Duration.days duration))

-- | Hour component of the duration.
exampleHours :: Effect Unit
exampleHours = do
  duration <- Duration.from { hours: 5 }
  Console.log ("Hours: " <> show (Duration.hours duration))

-- | Minute component of the duration.
exampleMinutes :: Effect Unit
exampleMinutes = do
  duration <- Duration.from { minutes: 45 }
  Console.log ("Minutes: " <> show (Duration.minutes duration))

-- | Second component of the duration.
exampleSeconds :: Effect Unit
exampleSeconds = do
  duration <- Duration.from { seconds: 30 }
  Console.log ("Seconds: " <> show (Duration.seconds duration))

-- | Millisecond component of the duration.
exampleMilliseconds :: Effect Unit
exampleMilliseconds = do
  duration <- Duration.from { milliseconds: 500 }
  Console.log ("Milliseconds: " <> show (Duration.milliseconds duration))

-- | Microsecond component of the duration.
exampleMicroseconds :: Effect Unit
exampleMicroseconds = do
  duration <- Duration.from { microseconds: 250 }
  Console.log ("Microseconds: " <> show (Duration.microseconds duration))

-- | Nanosecond component of the duration.
exampleNanoseconds :: Effect Unit
exampleNanoseconds = do
  duration <- Duration.from { nanoseconds: 100 }
  Console.log ("Nanoseconds: " <> show (Duration.nanoseconds duration))

-- | Returns 1 if positive, -1 if negative, 0 if zero.
exampleSign :: Effect Unit
exampleSign = do
  positive <- Duration.from { hours: 2 }
  Console.log ("Sign of 2h: " <> show (Duration.sign positive))
  negated <- pure (Duration.negated positive)
  Console.log ("Sign of -2h: " <> show (Duration.sign negated))

-- | True if all components are zero.
exampleBlank :: Effect Unit
exampleBlank = do
  zero <- Duration.from { hours: 0 }
  nonZero <- Duration.from { hours: 1 }
  Console.log ("Zero is blank: " <> show (Duration.blank zero))
  Console.log ("1h is blank: " <> show (Duration.blank nonZero))

-- | Reverses the sign of the duration. Pure, does not throw.
exampleNegated :: Effect Unit
exampleNegated = do
  locale <- JS.Intl.Locale.new_ "en-US"
  duration <- Duration.from { hours: 2, minutes: 30 }
  let neg = Duration.negated duration
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter neg)

-- | Returns the duration with positive sign. Pure, does not throw.
exampleAbs :: Effect Unit
exampleAbs = do
  locale <- JS.Intl.Locale.new_ "en-US"
  duration <- Duration.from { hours: 2 }
  let neg = Duration.negated duration
  let positive = Duration.abs neg
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter positive)

-- | Returns the total length of the duration in the given unit. Use relativeTo
-- | for calendar durations. Corresponds to `Temporal.Duration.prototype.total()`.
exampleTotal :: Effect Unit
exampleTotal = do
  locale <- JS.Intl.Locale.new_ "en-US"
  duration <- Duration.from { hours: 2, minutes: 30 }
  totalHours <- Duration.total { unit: TemporalUnit.Hour } duration
  numberFormatter <- JS.Intl.NumberFormat.new [ locale ] { minimumFractionDigits: 1, maximumFractionDigits: 1 }
  Console.log ("Total hours: " <> JS.Intl.NumberFormat.format numberFormatter totalHours)

-- | Adds two durations. Result is balanced to the largest unit of the inputs.
-- | Throws if either duration contains calendar units (years, months, weeks).
-- | Corresponds to `Temporal.Duration.prototype.add()`.
exampleAdd :: Effect Unit
exampleAdd = do
  locale <- JS.Intl.Locale.new_ "en-US"
  twoHours <- Duration.from { hours: 2 }
  thirtyMinutes <- Duration.from { minutes: 30 }
  combined <- Duration.add twoHours thirtyMinutes
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter combined)

-- | Subtracts the second duration from the first. Same balancing/constraints as add.
-- | Corresponds to `Temporal.Duration.prototype.subtract()`.
exampleSubtract :: Effect Unit
exampleSubtract = do
  locale <- JS.Intl.Locale.new_ "en-US"
  threeHours <- Duration.from { hours: 3 }
  oneHour <- Duration.from { hours: 1 }
  remainder <- Duration.subtract threeHours oneHour
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter remainder)

-- | Returns a new duration with specified fields replaced. Mixed signs invalid.
-- | Corresponds to `Temporal.Duration.prototype.with()`.
exampleWith :: Effect Unit
exampleWith = do
  locale <- JS.Intl.Locale.new_ "en-US"
  duration <- Duration.from { hours: 2, minutes: 30 }
  updated <- Duration.with { minutes: 45 } duration
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter updated)

-- | Compares two durations. Returns LT if first is shorter, GT if longer, EQ if equal.
-- | Throws for calendar durations without relativeTo. Corresponds to
-- | `Temporal.Duration.compare()`.
exampleCompare :: Effect Unit
exampleCompare = do
  shorter <- Duration.from { hours: 1 }
  longer <- Duration.from { hours: 2 }
  ordering <- Duration.compare longer shorter
  Console.log ("Comparison result: " <> show ordering)

-- | Rounds the duration to the given smallest/largest units. Use relativeTo for
-- | calendar durations. Corresponds to `Temporal.Duration.prototype.round()`.
exampleRound :: Effect Unit
exampleRound = do
  roundedSource <- Duration.from { hours: 1, minutes: 30, seconds: 45 }
  rounded <- Duration.round { largestUnit: TemporalUnit.Hour, smallestUnit: TemporalUnit.Second } roundedSource
  Console.log (Duration.toString rounded)

-- | Same as [`toStringWithOptions`](#v:toStringWithOptions) with default options.
exampleToString :: Effect Unit
exampleToString = do
  duration <- Duration.from { hours: 2, minutes: 30, seconds: 15, milliseconds: 400 }
  Console.log (Duration.toString duration)

-- | Serializes the duration to ISO 8601 format (e.g. `"PT1H30M"`).
exampleToStringWithOptions :: Effect Unit
exampleToStringWithOptions = do
  duration <- Duration.from { hours: 2, minutes: 30, seconds: 15, milliseconds: 400 }
  Console.log (Duration.toStringWithOptions { smallestUnit: TemporalUnit.Second } duration)

-- | Creates a Temporal Duration from purescript-datetime `Milliseconds`.
exampleFromMilliseconds :: Effect Unit
exampleFromMilliseconds = do
  duration <- Duration.fromMilliseconds (Milliseconds 5000.0)
  Console.log (Duration.toString duration)

-- | Converts a Temporal Duration to purescript-datetime `Milliseconds`. Returns
-- | `Nothing` if the duration contains calendar units (years, months, weeks).
-- | Microseconds and nanoseconds are dropped.
exampleToMilliseconds :: Effect Unit
exampleToMilliseconds = do
  duration <- Duration.from { seconds: 5 }
  case Duration.toMilliseconds duration of
    Just (Milliseconds ms) -> Console.log ("Milliseconds: " <> show ms)
    Nothing -> Console.log "Cannot convert (has calendar units)"
