-- | A point in time with nanosecond precision, represented as nanoseconds since
-- | the Unix epoch (1970-01-01T00:00:00Z). No time zone or calendar. Use
-- | toZonedDateTimeISO to interpret in a time zone.
-- |
-- | See <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Temporal/Instant>
module JS.Temporal.Instant
  ( module JS.Temporal.Instant.Internal
  -- * Construction
  , new
  , from
  , fromEpochMilliseconds
  , fromEpochNanoseconds
  -- * Properties
  , epochMilliseconds
  , epochNanoseconds
  -- * Arithmetic
  , add
  , subtract
  -- * Difference
  , until
  , until_
  , since
  , since_
  -- * Round
  , round
  -- * Conversions
  , toZonedDateTimeISO
  -- * Serialization
  , toString
  -- * Options
  , ToDifferenceOptions
  , ToRoundOptions
  , ToToStringOptions
  ) where

import Prelude hiding (add, compare)

import ConvertableOptions (class ConvertOption, class ConvertOptionsWithDefaults)
import ConvertableOptions as ConvertableOptions
import Data.Function.Uncurried (Fn2)
import Data.Function.Uncurried as Function.Uncurried
import Effect (Effect)
import Effect.Uncurried (EffectFn1, EffectFn2, EffectFn3)
import Effect.Uncurried as Effect.Uncurried
import Foreign (Foreign)
import Foreign as Foreign
import JS.BigInt (BigInt)
import JS.Temporal.Duration.Internal (Duration)
import JS.Temporal.RoundingMode (RoundingMode)
import JS.Temporal.RoundingMode as RoundingMode
import JS.Temporal.TemporalUnit (TemporalUnit)
import JS.Temporal.TemporalUnit as TemporalUnit
import JS.Temporal.Instant.Internal (Instant)
import JS.Temporal.ZonedDateTime.Internal (ZonedDateTime)
import Unsafe.Coerce as Unsafe.Coerce

-- Construction

foreign import _new :: EffectFn1 BigInt Instant

-- | Creates an Instant from epoch nanoseconds. Corresponds to `Temporal.Instant()`.
new :: BigInt -> Effect Instant
new = Effect.Uncurried.runEffectFn1 _new

foreign import _from :: EffectFn1 String Instant

-- | Parses an ISO 8601 instant string (e.g. `"2024-01-15T12:00:00Z"`). Throws on invalid input.
from :: String -> Effect Instant
from = Effect.Uncurried.runEffectFn1 _from

foreign import _fromEpochMilliseconds :: EffectFn1 Number Instant

-- | Creates an Instant from epoch milliseconds.
fromEpochMilliseconds :: Number -> Effect Instant
fromEpochMilliseconds = Effect.Uncurried.runEffectFn1 _fromEpochMilliseconds

foreign import _fromEpochNanoseconds :: EffectFn1 BigInt Instant

-- | Creates an Instant from epoch nanoseconds.
fromEpochNanoseconds :: BigInt -> Effect Instant
fromEpochNanoseconds = Effect.Uncurried.runEffectFn1 _fromEpochNanoseconds

-- Properties

foreign import epochMilliseconds :: Instant -> Number
foreign import epochNanoseconds :: Instant -> BigInt

-- Arithmetic

foreign import _add :: EffectFn2 Duration Instant Instant

-- | Adds a duration to an instant. Throws for calendar durations.
add :: Duration -> Instant -> Effect Instant
add = Effect.Uncurried.runEffectFn2 _add

foreign import _subtract :: EffectFn2 Duration Instant Instant

-- | Subtracts a duration from an instant. Throws for calendar durations.
subtract :: Duration -> Instant -> Effect Instant
subtract = Effect.Uncurried.runEffectFn2 _subtract

-- Difference

type DifferenceOptions =
  ( largestUnit :: String
  , smallestUnit :: String
  , roundingIncrement :: Int
  , roundingMode :: String
  )

data ToDifferenceOptions = ToDifferenceOptions

defaultDifferenceOptions :: { | DifferenceOptions }
defaultDifferenceOptions = Unsafe.Coerce.unsafeCoerce {}

instance ConvertOption ToDifferenceOptions "largestUnit" TemporalUnit String where
  convertOption _ _ = TemporalUnit.toString

instance ConvertOption ToDifferenceOptions "largestUnit" String String where
  convertOption _ _ = identity

instance ConvertOption ToDifferenceOptions "smallestUnit" TemporalUnit String where
  convertOption _ _ = TemporalUnit.toString

instance ConvertOption ToDifferenceOptions "smallestUnit" String String where
  convertOption _ _ = identity

instance ConvertOption ToDifferenceOptions "roundingIncrement" Int Int where
  convertOption _ _ = identity

instance ConvertOption ToDifferenceOptions "roundingMode" RoundingMode String where
  convertOption _ _ = RoundingMode.toString

instance ConvertOption ToDifferenceOptions "roundingMode" String String where
  convertOption _ _ = identity

foreign import _until :: forall r. EffectFn3 { | r } Instant Instant Duration

-- | Returns the duration from this instant until the other. Options: largestUnit, smallestUnit, roundingIncrement, roundingMode.
until
  :: forall provided
   . ConvertOptionsWithDefaults
       ToDifferenceOptions
       { | DifferenceOptions }
       { | provided }
       { | DifferenceOptions }
  => { | provided }
  -> Instant
  -> Instant
  -> Effect Duration
until providedOptions other instant =
  Effect.Uncurried.runEffectFn3
    _until
    ( ConvertableOptions.convertOptionsWithDefaults
        ToDifferenceOptions
        defaultDifferenceOptions
        providedOptions
    )
    other
    instant

foreign import _untilNoOpts :: EffectFn2 Instant Instant Duration

-- | Same as until with default options.
until_ :: Instant -> Instant -> Effect Duration
until_ = Effect.Uncurried.runEffectFn2 _untilNoOpts

foreign import _since :: forall r. EffectFn3 { | r } Instant Instant Duration

-- | Returns the duration from the other instant to this one (inverse of until).
since
  :: forall provided
   . ConvertOptionsWithDefaults
       ToDifferenceOptions
       { | DifferenceOptions }
       { | provided }
       { | DifferenceOptions }
  => { | provided }
  -> Instant
  -> Instant
  -> Effect Duration
since providedOptions other instant =
  Effect.Uncurried.runEffectFn3
    _since
    ( ConvertableOptions.convertOptionsWithDefaults
        ToDifferenceOptions
        defaultDifferenceOptions
        providedOptions
    )
    other
    instant

foreign import _sinceNoOpts :: EffectFn2 Instant Instant Duration

-- | Same as since with default options.
since_ :: Instant -> Instant -> Effect Duration
since_ = Effect.Uncurried.runEffectFn2 _sinceNoOpts

-- Round

type RoundOptions =
  ( smallestUnit :: String
  , roundingIncrement :: Int
  , roundingMode :: String
  )

data ToRoundOptions = ToRoundOptions

defaultRoundOptions :: { | RoundOptions }
defaultRoundOptions = Unsafe.Coerce.unsafeCoerce {}

instance ConvertOption ToRoundOptions "smallestUnit" TemporalUnit String where
  convertOption _ _ = TemporalUnit.toString

instance ConvertOption ToRoundOptions "smallestUnit" String String where
  convertOption _ _ = identity

instance ConvertOption ToRoundOptions "roundingIncrement" Int Int where
  convertOption _ _ = identity

instance ConvertOption ToRoundOptions "roundingMode" RoundingMode String where
  convertOption _ _ = RoundingMode.toString

instance ConvertOption ToRoundOptions "roundingMode" String String where
  convertOption _ _ = identity

foreign import _round :: forall r. EffectFn2 { | r } Instant Instant

-- | Rounds the instant to the given smallest unit. Options: smallestUnit, roundingIncrement, roundingMode.
round
  :: forall provided
   . ConvertOptionsWithDefaults
       ToRoundOptions
       { | RoundOptions }
       { | provided }
       { | RoundOptions }
  => { | provided }
  -> Instant
  -> Effect Instant
round providedOptions instant =
  Effect.Uncurried.runEffectFn2
    _round
    ( ConvertableOptions.convertOptionsWithDefaults
        ToRoundOptions
        defaultRoundOptions
        providedOptions
    )
    instant

-- Conversions

foreign import _toZonedDateTimeISO :: Fn2 String Instant ZonedDateTime

-- | Converts the instant to a ZonedDateTime in the given time zone (e.g. `"America/New_York"`).
toZonedDateTimeISO :: String -> Instant -> ZonedDateTime
toZonedDateTimeISO = Function.Uncurried.runFn2 _toZonedDateTimeISO

-- Serialization (toString_ from Internal)

type ToStringOptions =
  ( fractionalSecondDigits :: Foreign
  , smallestUnit :: String
  , roundingMode :: String
  , timeZone :: String
  )

data ToToStringOptions = ToToStringOptions

defaultToStringOptions :: { | ToStringOptions }
defaultToStringOptions = Unsafe.Coerce.unsafeCoerce {}

instance ConvertOption ToToStringOptions "fractionalSecondDigits" Int Foreign where
  convertOption _ _ = Foreign.unsafeToForeign

instance ConvertOption ToToStringOptions "fractionalSecondDigits" String Foreign where
  convertOption _ _ = Foreign.unsafeToForeign

instance ConvertOption ToToStringOptions "smallestUnit" TemporalUnit String where
  convertOption _ _ = TemporalUnit.toString

instance ConvertOption ToToStringOptions "smallestUnit" String String where
  convertOption _ _ = identity

instance ConvertOption ToToStringOptions "roundingMode" RoundingMode String where
  convertOption _ _ = RoundingMode.toString

instance ConvertOption ToToStringOptions "roundingMode" String String where
  convertOption _ _ = identity

instance ConvertOption ToToStringOptions "timeZone" String String where
  convertOption _ _ = identity

foreign import _toString :: forall r. Fn2 { | r } Instant String

-- | Serializes the instant to ISO 8601 format. Options: fractionalSecondDigits, smallestUnit, roundingMode, timeZone.
toString
  :: forall provided
   . ConvertOptionsWithDefaults
       ToToStringOptions
       { | ToStringOptions }
       { | provided }
       { | ToStringOptions }
  => { | provided }
  -> Instant
  -> String
toString providedOptions instant =
  Function.Uncurried.runFn2
    _toString
    ( ConvertableOptions.convertOptionsWithDefaults
        ToToStringOptions
        defaultToStringOptions
        providedOptions
    )
    instant

-- Instances (Eq, Ord, Show from Internal)
