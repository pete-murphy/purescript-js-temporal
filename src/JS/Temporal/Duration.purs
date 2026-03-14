-- | A duration representing the difference between two time points. Can be used
-- | in date/time arithmetic. Represented as years, months, weeks, days, hours,
-- | minutes, seconds, milliseconds, microseconds, and nanoseconds.
-- |
-- | Calendar durations (years, months, weeks) require a reference date for
-- | arithmetic; use `PlainDate.add`, `PlainDate.subtract`, `PlainDateTime.add`,
-- | or `PlainDateTime.subtract` for those. Non-calendar
-- | durations can be added/subtracted directly.
-- |
-- | See <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Temporal/Duration>
module JS.Temporal.Duration
  ( module JS.Temporal.Duration.Internal
  -- * Construction
  , from
  , fromString
  -- * Properties
  , years
  , months
  , weeks
  , days
  , hours
  , minutes
  , seconds
  , milliseconds
  , microseconds
  , nanoseconds
  , sign
  , blank
  -- * Arithmetic
  , add
  , subtract
  , negated
  , abs
  -- * Manipulation
  , with
  -- * Comparison
  , compare
  -- * Round and Total
  , round
  , total
  , DurationRoundOptions
  , ToDurationRoundOptions
  , DurationTotalOptions
  , ToDurationTotalOptions
  , DurationToStringOptions
  , ToDurationToStringOptions
  -- * Serialization
  , toString
  , toString_
  -- * purescript-datetime interop
  , fromMilliseconds
  , toMilliseconds
  ) where

import Prelude hiding (add, compare)

import ConvertableOptions (class ConvertOption, class ConvertOptionsWithDefaults)
import ConvertableOptions as ConvertableOptions
import Data.Function.Uncurried (Fn2)
import Data.Function.Uncurried as Function.Uncurried
import Data.Int as Int
import Data.Maybe (Maybe(..))
import Data.Newtype (unwrap)
import Data.Time.Duration (Milliseconds(..))
import Effect (Effect)
import Effect.Uncurried (EffectFn1, EffectFn2)
import Effect.Uncurried as Effect.Uncurried
import Foreign (Foreign)
import Foreign as Foreign
import JS.Temporal.Duration.Internal (Duration)
import JS.Temporal.Internal (intToOrdering)
import JS.Temporal.Options.RoundingMode (RoundingMode)
import JS.Temporal.Options.RoundingMode as RoundingMode
import JS.Temporal.Options.TemporalUnit (TemporalUnit)
import JS.Temporal.Options.TemporalUnit as TemporalUnit
import Prim.Row (class Union)
import Unsafe.Coerce as Unsafe.Coerce

-- Construction

-- | Row type for duration component fields. All fields optional in [`from`](#from)
-- | and [`with`](#with).
type DurationComponents =
  ( years :: Int
  , months :: Int
  , weeks :: Int
  , days :: Int
  , hours :: Int
  , minutes :: Int
  , seconds :: Int
  , milliseconds :: Int
  , microseconds :: Int
  , nanoseconds :: Int
  )

foreign import _from :: forall r. EffectFn1 { | r } Duration

-- | Creates a Duration from component fields. At least one component must be
-- | provided. Mixed signs are invalid.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | twoHours <- Duration.from { hours: 2 }
-- | formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
-- | Console.log (JS.Intl.DurationFormat.format formatter twoHours)
-- | ```
-- |
-- | ```text
-- | 2 hours
-- | ```

from
  :: forall provided rest
   . Union provided rest DurationComponents
  => { | provided }
  -> Effect Duration
from = Effect.Uncurried.runEffectFn1 _from

foreign import _fromString :: EffectFn1 String Duration

-- | Parses an ISO 8601 duration string (e.g. `"PT1H30M"`). Throws on invalid
-- | input. Corresponds to `Temporal.Duration.from()`.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | duration <- Duration.fromString "PT2H30M"
-- | formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
-- | Console.log (JS.Intl.DurationFormat.format formatter duration)
-- | ```
-- |
-- | ```text
-- | 2 hours, 30 minutes
-- | ```

fromString :: String -> Effect Duration
fromString = Effect.Uncurried.runEffectFn1 _fromString

-- Properties

-- | Year component of the duration.
foreign import years :: Duration -> Int
-- | Month component of the duration.
foreign import months :: Duration -> Int
-- | Week component of the duration.
foreign import weeks :: Duration -> Int
-- | Day component of the duration.
foreign import days :: Duration -> Int
-- | Hour component of the duration.
foreign import hours :: Duration -> Int
-- | Minute component of the duration.
foreign import minutes :: Duration -> Int
-- | Second component of the duration.
foreign import seconds :: Duration -> Int
-- | Millisecond component of the duration.
foreign import milliseconds :: Duration -> Int
-- | Microsecond component of the duration.
foreign import microseconds :: Duration -> Int
-- | Nanosecond component of the duration.
foreign import nanoseconds :: Duration -> Int

-- | Returns 1 if positive, -1 if negative, 0 if zero.
foreign import sign :: Duration -> Int

-- | True if all components are zero.
foreign import blank :: Duration -> Boolean

-- Arithmetic

foreign import _add :: EffectFn2 Duration Duration Duration

-- | Adds two durations. Result is balanced to the largest unit of the inputs.
-- | Throws if either duration contains calendar units (years, months, weeks).
-- | Corresponds to `Temporal.Duration.prototype.add()`.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | twoHours <- Duration.from { hours: 2 }
-- | thirtyMinutes <- Duration.from { minutes: 30 }
-- | combined <- Duration.add twoHours thirtyMinutes
-- | formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
-- | Console.log (JS.Intl.DurationFormat.format formatter combined)
-- | ```
-- |
-- | ```text
-- | 2 hours, 30 minutes
-- | ```

add :: Duration -> Duration -> Effect Duration
add = Effect.Uncurried.runEffectFn2 _add

foreign import _subtract :: EffectFn2 Duration Duration Duration

-- | Subtracts the second duration from the first. Same balancing/constraints as add.
-- | Corresponds to `Temporal.Duration.prototype.subtract()`.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | threeHours <- Duration.from { hours: 3 }
-- | oneHour <- Duration.from { hours: 1 }
-- | remainder <- Duration.subtract threeHours oneHour
-- | formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
-- | Console.log (JS.Intl.DurationFormat.format formatter remainder)
-- | ```
-- |
-- | ```text
-- | -2 hours
-- | ```

subtract :: Duration -> Duration -> Effect Duration
subtract = Effect.Uncurried.runEffectFn2 _subtract

-- | Reverses the sign of the duration. Pure, does not throw.
foreign import negated :: Duration -> Duration

-- | Returns the duration with positive sign. Pure, does not throw.
foreign import abs :: Duration -> Duration

foreign import _with :: forall r. EffectFn2 { | r } Duration Duration

-- | Returns a new duration with specified fields replaced. Mixed signs invalid.
-- | Corresponds to `Temporal.Duration.prototype.with()`.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | duration <- Duration.from { hours: 2, minutes: 30 }
-- | updated <- Duration.with { minutes: 45 } duration
-- | formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
-- | Console.log (JS.Intl.DurationFormat.format formatter updated)
-- | ```
-- |
-- | ```text
-- | 2 hours, 45 minutes
-- | ```

with
  :: forall provided rest
   . Union provided rest DurationComponents
  => { | provided }
  -> Duration
  -> Effect Duration
with = Effect.Uncurried.runEffectFn2 _with

-- Comparison

foreign import _compare :: EffectFn2 Duration Duration Int

-- | Compares two durations. Returns LT if first is shorter, GT if longer, EQ if equal.
-- | Throws for calendar durations without relativeTo. Corresponds to
-- | `Temporal.Duration.compare()`.
-- |
-- | ```purescript
-- | shorter <- Duration.from { hours: 1 }
-- | longer <- Duration.from { hours: 2 }
-- | ordering <- Duration.compare longer shorter
-- | Console.log ("Comparison result: " <> show ordering)
-- | ```
-- |
-- | ```text
-- | Comparison result: GT
-- | ```

compare :: Duration -> Duration -> Effect Ordering
compare a b = intToOrdering <$> Effect.Uncurried.runEffectFn2 _compare a b

-- Round

-- | Options for [`round`](#round): largestUnit, smallestUnit,
-- | roundingIncrement, roundingMode,
-- | relativeTo (`PlainDate`, `PlainDateTime`, or `ZonedDateTime` for calendar
-- | units).
type DurationRoundOptions =
  ( largestUnit :: String
  , smallestUnit :: String
  , roundingIncrement :: Int
  , roundingMode :: String
  , relativeTo :: Foreign
  )

data ToDurationRoundOptions = ToDurationRoundOptions

defaultDurationRoundOptions :: { | DurationRoundOptions }
defaultDurationRoundOptions = Unsafe.Coerce.unsafeCoerce {}

instance ConvertOption ToDurationRoundOptions "largestUnit" TemporalUnit String where
  convertOption _ _ = TemporalUnit.toString

instance ConvertOption ToDurationRoundOptions "largestUnit" String String where
  convertOption _ _ = identity

instance ConvertOption ToDurationRoundOptions "smallestUnit" TemporalUnit String where
  convertOption _ _ = TemporalUnit.toString

instance ConvertOption ToDurationRoundOptions "smallestUnit" String String where
  convertOption _ _ = identity

instance ConvertOption ToDurationRoundOptions "roundingIncrement" Int Int where
  convertOption _ _ = identity

instance ConvertOption ToDurationRoundOptions "roundingMode" RoundingMode String where
  convertOption _ _ = RoundingMode.toString

instance ConvertOption ToDurationRoundOptions "roundingMode" String String where
  convertOption _ _ = identity

instance ConvertOption ToDurationRoundOptions "relativeTo" Foreign Foreign where
  convertOption _ _ = identity

instance ConvertOption ToDurationRoundOptions "relativeTo" String Foreign where
  convertOption _ _ = Foreign.unsafeToForeign

foreign import _round :: forall r. EffectFn2 { | r } Duration Duration

-- | Rounds the duration to the given smallest/largest units. Use relativeTo for
-- | calendar durations. Corresponds to `Temporal.Duration.prototype.round()`.
-- |
-- | ```purescript
-- | roundedSource <- Duration.from { hours: 1, minutes: 30, seconds: 45 }
-- | rounded <- Duration.round { smallestUnit: TemporalUnit.Minute } roundedSource
-- | Console.log (Duration.toString_ rounded)
-- | ```
-- |
-- | ```text
-- | PT1H31M
-- | ```

round
  :: forall provided
   . ConvertOptionsWithDefaults
       ToDurationRoundOptions
       { | DurationRoundOptions }
       { | provided }
       { | DurationRoundOptions }
  => { | provided }
  -> Duration
  -> Effect Duration
round providedOptions duration =
  Effect.Uncurried.runEffectFn2
    _round
    ( ConvertableOptions.convertOptionsWithDefaults
        ToDurationRoundOptions
        defaultDurationRoundOptions
        providedOptions
    )
    duration

-- Total

-- | Options for [`total`](#total): unit (required), relativeTo for calendar units.
type DurationTotalOptions =
  ( unit :: String
  , relativeTo :: Foreign
  )

data ToDurationTotalOptions = ToDurationTotalOptions

defaultDurationTotalOptions :: { | DurationTotalOptions }
defaultDurationTotalOptions = Unsafe.Coerce.unsafeCoerce {}

instance ConvertOption ToDurationTotalOptions "unit" TemporalUnit String where
  convertOption _ _ = TemporalUnit.toString

instance ConvertOption ToDurationTotalOptions "unit" String String where
  convertOption _ _ = identity

instance ConvertOption ToDurationTotalOptions "relativeTo" Foreign Foreign where
  convertOption _ _ = identity

instance ConvertOption ToDurationTotalOptions "relativeTo" String Foreign where
  convertOption _ _ = Foreign.unsafeToForeign

foreign import _total :: forall r. EffectFn2 { | r } Duration Number

-- | Returns the total length of the duration in the given unit. Use relativeTo
-- | for calendar durations. Corresponds to `Temporal.Duration.prototype.total()`.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | duration <- Duration.from { hours: 2, minutes: 30 }
-- | totalHours <- Duration.total { unit: TemporalUnit.Hour } duration
-- | numberFormatter <- JS.Intl.NumberFormat.new [ locale ] { minimumFractionDigits: 1, maximumFractionDigits: 1 }
-- | Console.log ("Total hours: " <> JS.Intl.NumberFormat.format numberFormatter totalHours)
-- | ```
-- |
-- | ```text
-- | Total hours: 2.5
-- | ```

total
  :: forall provided
   . ConvertOptionsWithDefaults
       ToDurationTotalOptions
       { | DurationTotalOptions }
       { | provided }
       { | DurationTotalOptions }
  => { | provided }
  -> Duration
  -> Effect Number
total providedOptions duration =
  Effect.Uncurried.runEffectFn2
    _total
    ( ConvertableOptions.convertOptionsWithDefaults
        ToDurationTotalOptions
        defaultDurationTotalOptions
        providedOptions
    )
    duration

-- Serialization (toString_ from Internal)

foreign import _toString :: forall r. Fn2 { | r } Duration String

-- | Options: fractionalSecondDigits, smallestUnit.
type DurationToStringOptions =
  ( fractionalSecondDigits :: Foreign
  , smallestUnit :: String
  )

data ToDurationToStringOptions = ToDurationToStringOptions

defaultDurationToStringOptions :: { | DurationToStringOptions }
defaultDurationToStringOptions = Unsafe.Coerce.unsafeCoerce {}

instance ConvertOption ToDurationToStringOptions "fractionalSecondDigits" Int Foreign where
  convertOption _ _ = Foreign.unsafeToForeign

instance ConvertOption ToDurationToStringOptions "fractionalSecondDigits" String Foreign where
  convertOption _ _ = Foreign.unsafeToForeign

instance ConvertOption ToDurationToStringOptions "smallestUnit" TemporalUnit String where
  convertOption _ _ = TemporalUnit.toString

instance ConvertOption ToDurationToStringOptions "smallestUnit" String String where
  convertOption _ _ = identity

-- | Same as [`toString`](#tostring) with default options.
toString_ :: Duration -> String
toString_ duration = Function.Uncurried.runFn2 _toString defaultDurationToStringOptions duration

-- | Serializes the duration to ISO 8601 format (e.g. `"PT1H30M"`).
-- |
-- | ```purescript
-- | duration <- Duration.from { hours: 2, minutes: 30, seconds: 15, milliseconds: 400 }
-- | Console.log (Duration.toString { smallestUnit: TemporalUnit.Second } duration)
-- | ```
-- |
-- | ```text
-- | PT2H30M15S
-- | ```

toString
  :: forall provided
   . ConvertOptionsWithDefaults
       ToDurationToStringOptions
       { | DurationToStringOptions }
       { | provided }
       { | DurationToStringOptions }
  => { | provided }
  -> Duration
  -> String
toString providedOptions duration =
  Function.Uncurried.runFn2
    _toString
    ( ConvertableOptions.convertOptionsWithDefaults
        ToDurationToStringOptions
        defaultDurationToStringOptions
        providedOptions
    )
    duration

-- purescript-datetime interop (fixed-unit durations only)

millisecondsPerDay :: Int
millisecondsPerDay = 86400000

millisecondsPerHour :: Int
millisecondsPerHour = 3600000

millisecondsPerMinute :: Int
millisecondsPerMinute = 60000

millisecondsPerSecond :: Int
millisecondsPerSecond = 1000

-- | Converts a Temporal Duration to purescript-datetime `Milliseconds`. Returns
-- | `Nothing` if the duration contains calendar units (years, months, weeks).
-- | Microseconds and nanoseconds are dropped. See
-- | [./docs/purescript-datetime-interop.md](./docs/purescript-datetime-interop.md).
toMilliseconds :: Duration -> Maybe Milliseconds
toMilliseconds duration
  | years duration /= 0 = Nothing
  | months duration /= 0 = Nothing
  | weeks duration /= 0 = Nothing
  | otherwise =
      let
        totalMs :: Number
        totalMs =
          Int.toNumber (days duration) * Int.toNumber millisecondsPerDay
            + Int.toNumber (hours duration) * Int.toNumber millisecondsPerHour
            + Int.toNumber (minutes duration) * Int.toNumber millisecondsPerMinute
            + Int.toNumber (seconds duration) * Int.toNumber millisecondsPerSecond
            + Int.toNumber (milliseconds duration)
        signed =
          case sign duration of
            -1 -> negate totalMs
            _ -> totalMs
      in
        Just (Milliseconds signed)

decomposeMilliseconds :: Number -> { days :: Int, hours :: Int, minutes :: Int, seconds :: Int, milliseconds :: Int }
decomposeMilliseconds totalMs =
  let
    msPerDay = Int.toNumber millisecondsPerDay
    msPerHour = Int.toNumber millisecondsPerHour
    msPerMinute = Int.toNumber millisecondsPerMinute
    msPerSecond = Int.toNumber millisecondsPerSecond
    daysVal = Int.floor (totalMs / msPerDay)
    afterDays = totalMs - Int.toNumber daysVal * msPerDay
    hoursVal = Int.floor (afterDays / msPerHour)
    afterHours = afterDays - Int.toNumber hoursVal * msPerHour
    minutesVal = Int.floor (afterHours / msPerMinute)
    afterMinutes = afterHours - Int.toNumber minutesVal * msPerMinute
    secondsVal = Int.floor (afterMinutes / msPerSecond)
    millisecondsVal = Int.floor (afterMinutes - Int.toNumber secondsVal * msPerSecond)
  in
    { days: daysVal, hours: hoursVal, minutes: minutesVal, seconds: secondsVal, milliseconds: millisecondsVal }

-- | Creates a Temporal Duration from purescript-datetime `Milliseconds`. See
-- | [./docs/purescript-datetime-interop.md](./docs/purescript-datetime-interop.md).
fromMilliseconds :: Milliseconds -> Effect Duration
fromMilliseconds ms =
  let
    totalMs = unwrap ms
    absolute = if totalMs < 0.0 then negate totalMs else totalMs
    components = decomposeMilliseconds absolute
    signMultiplier = if totalMs < 0.0 then -1 else 1
    fields =
      { days: signMultiplier * components.days
      , hours: signMultiplier * components.hours
      , minutes: signMultiplier * components.minutes
      , seconds: signMultiplier * components.seconds
      , milliseconds: signMultiplier * components.milliseconds
      }
  in
    from fields

-- Instances (Eq, Show from Internal)
