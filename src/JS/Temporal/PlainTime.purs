-- | A wall-clock time (hour, minute, second, etc.) without date or time zone.
-- | Use for recurring times (e.g. "3:30 PM") or when combining with PlainDate.
-- |
-- | See <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Temporal/PlainTime>
module JS.Temporal.PlainTime
  ( module JS.Temporal.PlainTime.Internal
  -- * Construction
  , new
  , from
  , from_
  -- * Properties
  , hour
  , minute
  , second
  , millisecond
  , microsecond
  , nanosecond
  -- * Arithmetic
  , add
  , subtract
  -- * Manipulation
  , with
  , with_
  -- * Difference
  , until
  , until_
  , since
  , since_
  -- * Round
  , round
  -- * Serialization
  , toString
  -- * Options
  , ToOverflowOptions
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
import JS.Temporal.Duration.Internal (Duration)
import JS.Temporal.Overflow (Overflow)
import JS.Temporal.Overflow as Overflow
import JS.Temporal.RoundingMode (RoundingMode)
import JS.Temporal.RoundingMode as RoundingMode
import JS.Temporal.TemporalUnit (TemporalUnit)
import JS.Temporal.TemporalUnit as TemporalUnit
import JS.Temporal.PlainTime.Internal (PlainTime)
import Prim.Row (class Union)
import Unsafe.Coerce as Unsafe.Coerce

-- Construction

type PlainTimeComponents =
  ( hour :: Int
  , minute :: Int
  , second :: Int
  , millisecond :: Int
  , microsecond :: Int
  , nanosecond :: Int
  )

foreign import _new :: forall r. EffectFn1 { | r } PlainTime

-- | Creates a PlainTime from component fields. Corresponds to `Temporal.PlainTime()`.
new
  :: forall provided rest
   . Union provided rest PlainTimeComponents
  => { | provided }
  -> Effect PlainTime
new = Effect.Uncurried.runEffectFn1 _new

type OverflowOptions = (overflow :: String)

data ToOverflowOptions = ToOverflowOptions

defaultOverflowOptions :: { | OverflowOptions }
defaultOverflowOptions = Unsafe.Coerce.unsafeCoerce {}

instance ConvertOption ToOverflowOptions "overflow" Overflow String where
  convertOption _ _ = Overflow.toString

instance ConvertOption ToOverflowOptions "overflow" String String where
  convertOption _ _ = identity

foreign import _from :: forall r. EffectFn2 { | r } String PlainTime

-- | Parses a time string (e.g. `"15:30:00"`). Options: overflow. Throws on invalid input.
from
  :: forall provided
   . ConvertOptionsWithDefaults
       ToOverflowOptions
       { | OverflowOptions }
       { | provided }
       { | OverflowOptions }
  => { | provided }
  -> String
  -> Effect PlainTime
from providedOptions str =
  Effect.Uncurried.runEffectFn2
    _from
    ( ConvertableOptions.convertOptionsWithDefaults
        ToOverflowOptions
        defaultOverflowOptions
        providedOptions
    )
    str

foreign import _fromNoOpts :: EffectFn1 String PlainTime

-- | Same as from with default options.
from_ :: String -> Effect PlainTime
from_ = Effect.Uncurried.runEffectFn1 _fromNoOpts

-- Properties

foreign import hour :: PlainTime -> Int
foreign import minute :: PlainTime -> Int
foreign import second :: PlainTime -> Int
foreign import millisecond :: PlainTime -> Int
foreign import microsecond :: PlainTime -> Int
foreign import nanosecond :: PlainTime -> Int

-- Arithmetic

foreign import _add :: EffectFn2 Duration PlainTime PlainTime

-- | Adds a duration. Wraps at 24 hours. Throws for calendar durations.
add :: Duration -> PlainTime -> Effect PlainTime
add = Effect.Uncurried.runEffectFn2 _add

foreign import _subtract :: EffectFn2 Duration PlainTime PlainTime

-- | Subtracts a duration. Wraps at 24 hours. Throws for calendar durations.
subtract :: Duration -> PlainTime -> Effect PlainTime
subtract = Effect.Uncurried.runEffectFn2 _subtract

-- Manipulation

type WithFields =
  ( hour :: Int
  , minute :: Int
  , second :: Int
  , millisecond :: Int
  , microsecond :: Int
  , nanosecond :: Int
  )

foreign import _with :: forall ro rf. EffectFn3 { | ro } { | rf } PlainTime PlainTime

-- | Returns a new PlainTime with specified fields replaced. Options: overflow.
with
  :: forall optsProvided fields rest
   . Union fields rest WithFields
  => ConvertOptionsWithDefaults
       ToOverflowOptions
       { | OverflowOptions }
       { | optsProvided }
       { | OverflowOptions }
  => { | optsProvided }
  -> { | fields }
  -> PlainTime
  -> Effect PlainTime
with options fields plainTime =
  Effect.Uncurried.runEffectFn3
    _with
    ( ConvertableOptions.convertOptionsWithDefaults
        ToOverflowOptions
        defaultOverflowOptions
        options
    )
    fields
    plainTime

foreign import _withNoOpts :: forall r. EffectFn2 { | r } PlainTime PlainTime

-- | Same as with with default options.
with_
  :: forall fields rest
   . Union fields rest WithFields
  => { | fields }
  -> PlainTime
  -> Effect PlainTime
with_ = Effect.Uncurried.runEffectFn2 _withNoOpts

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

foreign import _until :: forall r. EffectFn3 { | r } PlainTime PlainTime Duration

-- | Duration from this time until the other (positive if other is later same day).
until
  :: forall provided
   . ConvertOptionsWithDefaults
       ToDifferenceOptions
       { | DifferenceOptions }
       { | provided }
       { | DifferenceOptions }
  => { | provided }
  -> PlainTime
  -> PlainTime
  -> Effect Duration
until providedOptions other plainTime =
  Effect.Uncurried.runEffectFn3
    _until
    ( ConvertableOptions.convertOptionsWithDefaults
        ToDifferenceOptions
        defaultDifferenceOptions
        providedOptions
    )
    other
    plainTime

foreign import _untilNoOpts :: EffectFn2 PlainTime PlainTime Duration

-- | Same as until with default options.
until_ :: PlainTime -> PlainTime -> Effect Duration
until_ = Effect.Uncurried.runEffectFn2 _untilNoOpts

foreign import _since :: forall r. EffectFn3 { | r } PlainTime PlainTime Duration

-- | Duration from the other time to this one (inverse of until).
since
  :: forall provided
   . ConvertOptionsWithDefaults
       ToDifferenceOptions
       { | DifferenceOptions }
       { | provided }
       { | DifferenceOptions }
  => { | provided }
  -> PlainTime
  -> PlainTime
  -> Effect Duration
since providedOptions other plainTime =
  Effect.Uncurried.runEffectFn3
    _since
    ( ConvertableOptions.convertOptionsWithDefaults
        ToDifferenceOptions
        defaultDifferenceOptions
        providedOptions
    )
    other
    plainTime

foreign import _sinceNoOpts :: EffectFn2 PlainTime PlainTime Duration

-- | Same as since with default options.
since_ :: PlainTime -> PlainTime -> Effect Duration
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

foreign import _round :: forall r. EffectFn2 { | r } PlainTime PlainTime

-- | Rounds the time to the given smallest unit.
round
  :: forall provided
   . ConvertOptionsWithDefaults
       ToRoundOptions
       { | RoundOptions }
       { | provided }
       { | RoundOptions }
  => { | provided }
  -> PlainTime
  -> Effect PlainTime
round providedOptions plainTime =
  Effect.Uncurried.runEffectFn2
    _round
    ( ConvertableOptions.convertOptionsWithDefaults
        ToRoundOptions
        defaultRoundOptions
        providedOptions
    )
    plainTime

-- Comparison

-- Serialization (toString_ from Internal)

type ToStringOptions =
  ( fractionalSecondDigits :: Foreign
  , smallestUnit :: String
  , roundingMode :: String
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

foreign import _toString :: forall r. Fn2 { | r } PlainTime String

-- | Serializes to ISO 8601 time format. Options: fractionalSecondDigits, smallestUnit, roundingMode.
toString
  :: forall provided
   . ConvertOptionsWithDefaults
       ToToStringOptions
       { | ToStringOptions }
       { | provided }
       { | ToStringOptions }
  => { | provided }
  -> PlainTime
  -> String
toString providedOptions plainTime =
  Function.Uncurried.runFn2
    _toString
    ( ConvertableOptions.convertOptionsWithDefaults
        ToToStringOptions
        defaultToStringOptions
        providedOptions
    )
    plainTime

-- Instances (Eq, Ord, Show from Internal)
