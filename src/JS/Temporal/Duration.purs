module JS.Temporal.Duration
  ( module JS.Temporal.Duration.Internal
  -- * Construction
  , new
  , from
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
  ) where

import Prelude hiding (add, compare)

import ConvertableOptions (class ConvertOption, class ConvertOptionsWithDefaults)
import ConvertableOptions as ConvertableOptions
import Data.Function.Uncurried (Fn2)
import Data.Function.Uncurried as Function.Uncurried
import Effect (Effect)
import Effect.Uncurried (EffectFn1, EffectFn2)
import Effect.Uncurried as Effect.Uncurried
import Foreign (Foreign)
import Foreign as Foreign
import JS.Temporal.Internal (intToOrdering)
import JS.Temporal.RoundingMode (RoundingMode)
import JS.Temporal.RoundingMode as RoundingMode
import JS.Temporal.TemporalUnit (TemporalUnit)
import JS.Temporal.TemporalUnit as TemporalUnit
import JS.Temporal.Duration.Internal (Duration)
import Prim.Row (class Union)
import Unsafe.Coerce as Unsafe.Coerce

-- Construction

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

foreign import _new :: forall r. EffectFn1 { | r } Duration

new
  :: forall provided rest
   . Union provided rest DurationComponents
  => { | provided }
  -> Effect Duration
new = Effect.Uncurried.runEffectFn1 _new

foreign import _from :: EffectFn1 String Duration

from :: String -> Effect Duration
from = Effect.Uncurried.runEffectFn1 _from

-- Properties

foreign import years :: Duration -> Int
foreign import months :: Duration -> Int
foreign import weeks :: Duration -> Int
foreign import days :: Duration -> Int
foreign import hours :: Duration -> Int
foreign import minutes :: Duration -> Int
foreign import seconds :: Duration -> Int
foreign import milliseconds :: Duration -> Int
foreign import microseconds :: Duration -> Int
foreign import nanoseconds :: Duration -> Int
foreign import sign :: Duration -> Int
foreign import blank :: Duration -> Boolean

-- Arithmetic

foreign import _add :: EffectFn2 Duration Duration Duration

add :: Duration -> Duration -> Effect Duration
add = Effect.Uncurried.runEffectFn2 _add

foreign import _subtract :: EffectFn2 Duration Duration Duration

subtract :: Duration -> Duration -> Effect Duration
subtract = Effect.Uncurried.runEffectFn2 _subtract

foreign import negated :: Duration -> Duration
foreign import abs :: Duration -> Duration

foreign import _with :: forall r. EffectFn2 { | r } Duration Duration

with
  :: forall provided rest
   . Union provided rest DurationComponents
  => { | provided }
  -> Duration
  -> Effect Duration
with = Effect.Uncurried.runEffectFn2 _with

-- Comparison

foreign import _compare :: EffectFn2 Duration Duration Int

compare :: Duration -> Duration -> Effect Ordering
compare a b = intToOrdering <$> Effect.Uncurried.runEffectFn2 _compare a b

-- Round

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

-- Instances (Eq, Show from Internal)
