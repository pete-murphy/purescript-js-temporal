-- | A wall-clock time (hour, minute, second, etc.) without date or time zone.
-- | Use for recurring times (e.g. "3:30 PM") or when combining with PlainDate.
-- |
-- | See <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Temporal/PlainTime>
module JS.Temporal.PlainTime
  ( module JS.Temporal.PlainTime.Internal
  -- * Construction
  , PlainTimeComponents
  , fromWithOptions
  , from
  , fromStringWithOptions
  , fromString
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
  , withWithOptions
  , with
  -- * Difference
  , untilWithOptions
  , until
  , sinceWithOptions
  , since
  -- * Round
  , round
  -- * Conversions
  , fromTime
  , toTime
  -- * Serialization
  , toStringWithOptions
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
import Data.Enum (fromEnum, toEnum)
import Data.Function.Uncurried (Fn2)
import Data.Function.Uncurried as Function.Uncurried
import Data.Maybe (fromJust)
import Data.Time (Time(..))
import Data.Time as Time
import Effect (Effect)
import Effect.Uncurried (EffectFn1, EffectFn2, EffectFn3)
import Effect.Uncurried as Effect.Uncurried
import Foreign (Foreign)
import Foreign as Foreign
import JS.Temporal.Duration.Internal (Duration)
import JS.Temporal.Options.Overflow (Overflow)
import JS.Temporal.Options.Overflow as Overflow
import JS.Temporal.Options.RoundingMode (RoundingMode)
import JS.Temporal.Options.RoundingMode as RoundingMode
import JS.Temporal.Options.TemporalUnit (TemporalUnit)
import JS.Temporal.Options.TemporalUnit as TemporalUnit
import JS.Temporal.PlainTime.Internal (PlainTime)
import Partial.Unsafe (unsafePartial)
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

type OverflowOptions = (overflow :: String)

data ToOverflowOptions = ToOverflowOptions

defaultOverflowOptions :: { | OverflowOptions }
defaultOverflowOptions = Unsafe.Coerce.unsafeCoerce {}

instance ConvertOption ToOverflowOptions "overflow" Overflow String where
  convertOption _ _ = Overflow.toString

instance ConvertOption ToOverflowOptions "overflow" String String where
  convertOption _ _ = identity

foreign import _fromRecordWithOptions :: forall ro rc. EffectFn2 { | ro } { | rc } PlainTime

-- | Creates a PlainTime from component fields. Options: overflow.
-- |
-- | ```purescript
-- | exampleFromWithOptions :: Effect Unit
-- | exampleFromWithOptions = do
-- |   time <- PlainTime.fromWithOptions { overflow: Overflow.Constrain }
-- |     { hour: 9, minute: 30, second: 0 }
-- |   Console.log (PlainTime.toString time)
-- | ```
-- |
-- | ```text
-- | 09:30:00
-- | ```

fromWithOptions
  :: forall optsProvided provided rest
   . Union provided rest PlainTimeComponents
  => ConvertOptionsWithDefaults
       ToOverflowOptions
       { | OverflowOptions }
       { | optsProvided }
       { | OverflowOptions }
  => { | optsProvided }
  -> { | provided }
  -> Effect PlainTime
fromWithOptions providedOptions components =
  Effect.Uncurried.runEffectFn2
    _fromRecordWithOptions
    ( ConvertableOptions.convertOptionsWithDefaults
        ToOverflowOptions
        defaultOverflowOptions
        providedOptions
    )
    components

foreign import _fromRecord :: forall r. EffectFn1 { | r } PlainTime

-- | Same as [`fromWithOptions`](#fromWithOptions) with default options.
-- |
-- | ```purescript
-- | exampleFrom :: Effect Unit
-- | exampleFrom = do
-- |   locale <- JS.Intl.Locale.new_ "en-US"
-- |   time <- PlainTime.from { hour: 9, minute: 30, second: 0 }
-- |   formatter <- JS.Intl.DateTimeFormat.new [ locale ] { timeStyle: "medium" }
-- |   Console.log (JS.Intl.DateTimeFormat.format formatter time)
-- |
-- | exampleFromStringWithOptions :: Effect Unit
-- | exampleFromStringWithOptions = do
-- |   time <- PlainTime.fromStringWithOptions { overflow: Overflow.Constrain } "15:30:00"
-- |   Console.log (PlainTime.toString time)
-- |
-- | exampleFromString :: Effect Unit
-- | exampleFromString = do
-- |   locale <- JS.Intl.Locale.new_ "en-US"
-- |   time <- PlainTime.fromString "15:30:00"
-- |   formatter <- JS.Intl.DateTimeFormat.new [ locale ] { timeStyle: "medium" }
-- |   Console.log (JS.Intl.DateTimeFormat.format formatter time)
-- | ```
-- |
-- | ```text
-- | 9:30:00 AM
-- | ```

from
  :: forall provided rest
   . Union provided rest PlainTimeComponents
  => { | provided }
  -> Effect PlainTime
from = Effect.Uncurried.runEffectFn1 _fromRecord

foreign import _fromStringWithOptions :: forall r. EffectFn2 { | r } String PlainTime

-- | Parses a time string (e.g. `"15:30:00"`). Options: overflow. Throws on invalid input.
-- |
-- | ```purescript
-- | exampleFromStringWithOptions :: Effect Unit
-- | exampleFromStringWithOptions = do
-- |   time <- PlainTime.fromStringWithOptions { overflow: Overflow.Constrain } "15:30:00"
-- |   Console.log (PlainTime.toString time)
-- | ```
-- |
-- | ```text
-- | 15:30:00
-- | ```

fromStringWithOptions
  :: forall provided
   . ConvertOptionsWithDefaults
       ToOverflowOptions
       { | OverflowOptions }
       { | provided }
       { | OverflowOptions }
  => { | provided }
  -> String
  -> Effect PlainTime
fromStringWithOptions providedOptions str =
  Effect.Uncurried.runEffectFn2
    _fromStringWithOptions
    ( ConvertableOptions.convertOptionsWithDefaults
        ToOverflowOptions
        defaultOverflowOptions
        providedOptions
    )
    str

foreign import _fromString :: EffectFn1 String PlainTime

-- | Same as [`fromStringWithOptions`](#fromstring) with default options.
-- |
-- | ```purescript
-- | exampleFromString :: Effect Unit
-- | exampleFromString = do
-- |   locale <- JS.Intl.Locale.new_ "en-US"
-- |   time <- PlainTime.fromString "15:30:00"
-- |   formatter <- JS.Intl.DateTimeFormat.new [ locale ] { timeStyle: "medium" }
-- |   Console.log (JS.Intl.DateTimeFormat.format formatter time)
-- | ```
-- |
-- | ```text
-- | 3:30:00 PM
-- | ```

fromString :: String -> Effect PlainTime
fromString = Effect.Uncurried.runEffectFn1 _fromString

-- Properties

-- | Hour component.
-- |
-- | ```purescript
-- | exampleHour :: Effect Unit
-- | exampleHour = do
-- |   time <- PlainTime.fromString "14:30:45"
-- |   Console.log ("Hour: " <> show (PlainTime.hour time))
-- | ```
-- |
-- | ```text
-- | Hour: 14
-- | ```

foreign import hour :: PlainTime -> Int
-- | Minute component.
-- |
-- | ```purescript
-- | exampleMinute :: Effect Unit
-- | exampleMinute = do
-- |   time <- PlainTime.fromString "14:30:45"
-- |   Console.log ("Minute: " <> show (PlainTime.minute time))
-- | ```
-- |
-- | ```text
-- | Minute: 30
-- | ```

foreign import minute :: PlainTime -> Int
-- | Second component.
-- |
-- | ```purescript
-- | exampleSecond :: Effect Unit
-- | exampleSecond = do
-- |   time <- PlainTime.fromString "14:30:45"
-- |   Console.log ("Second: " <> show (PlainTime.second time))
-- | ```
-- |
-- | ```text
-- | Second: 45
-- | ```

foreign import second :: PlainTime -> Int
-- | Millisecond component.
-- |
-- | ```purescript
-- | exampleMillisecond :: Effect Unit
-- | exampleMillisecond = do
-- |   time <- PlainTime.fromString "14:30:45.123"
-- |   Console.log ("Millisecond: " <> show (PlainTime.millisecond time))
-- | ```
-- |
-- | ```text
-- | Millisecond: 123
-- | ```

foreign import millisecond :: PlainTime -> Int
-- | Microsecond component.
-- |
-- | ```purescript
-- | exampleMicrosecond :: Effect Unit
-- | exampleMicrosecond = do
-- |   time <- PlainTime.fromString "14:30:45.123456"
-- |   Console.log ("Microsecond: " <> show (PlainTime.microsecond time))
-- | ```
-- |
-- | ```text
-- | Microsecond: 456
-- | ```

foreign import microsecond :: PlainTime -> Int
-- | Nanosecond component.
-- |
-- | ```purescript
-- | exampleNanosecond :: Effect Unit
-- | exampleNanosecond = do
-- |   time <- PlainTime.fromString "14:30:45.123456789"
-- |   Console.log ("Nanosecond: " <> show (PlainTime.nanosecond time))
-- | ```
-- |
-- | ```text
-- | Nanosecond: 789
-- | ```

foreign import nanosecond :: PlainTime -> Int

-- Arithmetic

foreign import _add :: EffectFn2 Duration PlainTime PlainTime

-- | Adds a duration. Wraps at 24 hours. Throws for calendar durations.
-- |
-- | ```purescript
-- | exampleAdd :: Effect Unit
-- | exampleAdd = do
-- |   time <- PlainTime.fromString "14:30:00"
-- |   twoHours <- Duration.from { hours: 2 }
-- |   later <- PlainTime.add twoHours time
-- |   Console.log (PlainTime.toString later)
-- | ```
-- |
-- | ```text
-- | 16:30:00
-- | ```

add :: Duration -> PlainTime -> Effect PlainTime
add = Effect.Uncurried.runEffectFn2 _add

foreign import _subtract :: EffectFn2 Duration PlainTime PlainTime

-- | Subtracts a duration. Arg order: `subtract duration subject`. Wraps at 24 hours.
-- |
-- | ```purescript
-- | exampleSubtract :: Effect Unit
-- | exampleSubtract = do
-- |   time <- PlainTime.fromString "14:30:00"
-- |   twoHours <- Duration.from { hours: 2 }
-- |   earlier <- PlainTime.subtract twoHours time
-- |   Console.log (PlainTime.toString earlier)
-- | ```
-- |
-- | ```text
-- | 12:30:00
-- | ```

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

foreign import _withWithOptions :: forall ro rf. EffectFn3 { | ro } { | rf } PlainTime PlainTime

-- | Returns a new PlainTime with specified fields replaced. Options: overflow.
-- |
-- | ```purescript
-- | exampleWithWithOptions :: Effect Unit
-- | exampleWithWithOptions = do
-- |   time <- PlainTime.fromString "15:30:45"
-- |   noon <- PlainTime.withWithOptions { overflow: Overflow.Constrain } { hour: 12, minute: 0, second: 0 } time
-- |   Console.log (PlainTime.toString noon)
-- | ```
-- |
-- | ```text
-- | 12:00:00
-- | ```

withWithOptions
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
withWithOptions options fields plainTime =
  Effect.Uncurried.runEffectFn3
    _withWithOptions
    ( ConvertableOptions.convertOptionsWithDefaults
        ToOverflowOptions
        defaultOverflowOptions
        options
    )
    fields
    plainTime

foreign import _with :: forall r. EffectFn2 { | r } PlainTime PlainTime

-- | Same as [`withWithOptions`](#withWithOptions) with default options.
-- |
-- | ```purescript
-- | exampleWith :: Effect Unit
-- | exampleWith = do
-- |   time <- PlainTime.fromString "15:30:45"
-- |   noon <- PlainTime.with { hour: 12, minute: 0, second: 0 } time
-- |   Console.log (PlainTime.toString noon)
-- | ```
-- |
-- | ```text
-- | 12:00:00
-- | ```

with
  :: forall fields rest
   . Union fields rest WithFields
  => { | fields }
  -> PlainTime
  -> Effect PlainTime
with = Effect.Uncurried.runEffectFn2 _with

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

foreign import _untilWithOptions :: forall r. EffectFn3 { | r } PlainTime PlainTime Duration

-- | Duration from `subject` (last arg) until `other` (second arg). Arg order: `untilWithOptions options other subject`.
-- |
-- | ```purescript
-- | exampleUntilWithOptions :: Effect Unit
-- | exampleUntilWithOptions = do
-- |   locale <- JS.Intl.Locale.new_ "en-US"
-- |   start <- PlainTime.fromString "09:00:00"
-- |   end <- PlainTime.fromString "17:30:00"
-- |   duration <- PlainTime.untilWithOptions { largestUnit: TemporalUnit.Hour } end start
-- |   formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
-- |   Console.log (JS.Intl.DurationFormat.format formatter duration)
-- | ```
-- |
-- | ```text
-- | 8 hours, 30 minutes
-- | ```

untilWithOptions
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
untilWithOptions providedOptions other plainTime =
  Effect.Uncurried.runEffectFn3
    _untilWithOptions
    ( ConvertableOptions.convertOptionsWithDefaults
        ToDifferenceOptions
        defaultDifferenceOptions
        providedOptions
    )
    other
    plainTime

foreign import _until :: EffectFn2 PlainTime PlainTime Duration

-- | Same as [`untilWithOptions`](#untilWithOptions) with default options.
-- |
-- | ```purescript
-- | exampleUntil :: Effect Unit
-- | exampleUntil = do
-- |   start <- PlainTime.fromString "09:00:00"
-- |   end <- PlainTime.fromString "17:30:00"
-- |   duration <- PlainTime.until end start
-- |   Console.log (Duration.toString duration)
-- | ```
-- |
-- | ```text
-- | PT8H30M
-- | ```

until :: PlainTime -> PlainTime -> Effect Duration
until = Effect.Uncurried.runEffectFn2 _until

foreign import _sinceWithOptions :: forall r. EffectFn3 { | r } PlainTime PlainTime Duration

-- | Duration from `other` to `subject` (inverse of `untilWithOptions`). Arg order: `sinceWithOptions options other subject`.
-- |
-- | ```purescript
-- | exampleSinceWithOptions :: Effect Unit
-- | exampleSinceWithOptions = do
-- |   locale <- JS.Intl.Locale.new_ "en-US"
-- |   earlier <- PlainTime.fromString "08:00:00"
-- |   later <- PlainTime.fromString "12:30:00"
-- |   duration <- PlainTime.sinceWithOptions { largestUnit: TemporalUnit.Hour } earlier later
-- |   formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
-- |   Console.log (JS.Intl.DurationFormat.format formatter duration)
-- | ```
-- |
-- | ```text
-- | 4 hours, 30 minutes
-- | ```

sinceWithOptions
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
sinceWithOptions providedOptions other plainTime =
  Effect.Uncurried.runEffectFn3
    _sinceWithOptions
    ( ConvertableOptions.convertOptionsWithDefaults
        ToDifferenceOptions
        defaultDifferenceOptions
        providedOptions
    )
    other
    plainTime

foreign import _since :: EffectFn2 PlainTime PlainTime Duration

-- | Same as [`sinceWithOptions`](#sinceWithOptions) with default options.
-- |
-- | ```purescript
-- | exampleSince :: Effect Unit
-- | exampleSince = do
-- |   earlier <- PlainTime.fromString "08:00:00"
-- |   later <- PlainTime.fromString "12:30:00"
-- |   duration <- PlainTime.since earlier later
-- |   Console.log (Duration.toString duration)
-- | ```
-- |
-- | ```text
-- | PT4H30M
-- | ```

since :: PlainTime -> PlainTime -> Effect Duration
since = Effect.Uncurried.runEffectFn2 _since

-- Conversions

-- | Converts a purescript-datetime `Time` to a `PlainTime`. Microsecond and
-- | nanosecond components are set to zero.
-- |
-- | ```purescript
-- | exampleFromTime :: Effect Unit
-- | exampleFromTime = do
-- |   time <- PlainTime.fromString "14:30:00"
-- |   roundTripped <- PlainTime.fromTime (PlainTime.toTime time)
-- |   Console.log (PlainTime.toString roundTripped)
-- | ```
-- |
-- | ```text
-- | 14:30:00
-- | ```

fromTime :: Time -> Effect PlainTime
fromTime time =
  from
    { hour: fromEnum (Time.hour time)
    , minute: fromEnum (Time.minute time)
    , second: fromEnum (Time.second time)
    , millisecond: fromEnum (Time.millisecond time)
    }

-- | Converts a `PlainTime` to a purescript-datetime `Time`.
-- | Microsecond and nanosecond are dropped (treated as zero).
-- |
-- | ```purescript
-- | exampleToTime :: Effect Unit
-- | exampleToTime = do
-- |   time <- PlainTime.fromString "14:30:00"
-- |   Console.log (show (PlainTime.toTime time))
-- | ```
-- |
-- | ```text
-- | (Time (Hour 14) (Minute 30) (Second 0) (Millisecond 0))
-- | ```

toTime :: PlainTime -> Time
toTime plain =
  unsafePartial fromJust
    ( Time
        <$> toEnum (hour plain)
        <*> toEnum (minute plain)
        <*> toEnum (second plain)
        <*> toEnum (millisecond plain)
    )

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
-- |
-- | ```purescript
-- | exampleRound :: Effect Unit
-- | exampleRound = do
-- |   time <- PlainTime.fromString "09:30:45.123"
-- |   rounded <- PlainTime.round { smallestUnit: TemporalUnit.Minute } time
-- |   Console.log (PlainTime.toString rounded)
-- | ```
-- |
-- | ```text
-- | 09:31:00
-- | ```

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

-- Serialization (toString fromWithOptions Internal)

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

-- | Same as [`toStringWithOptions`](#tostring) with default options.
-- |
-- | ```purescript
-- | exampleToString :: Effect Unit
-- | exampleToString = do
-- |   time <- PlainTime.fromString "14:30:45.123"
-- |   Console.log (PlainTime.toString time)
-- | ```
-- |
-- | ```text
-- | 14:30:45.123
-- | ```

toString :: PlainTime -> String
toString plainTime = Function.Uncurried.runFn2 _toString defaultToStringOptions plainTime

-- | Serializes to ISO 8601 time format. Options: fractionalSecondDigits, smallestUnit, roundingMode.
-- |
-- | ```purescript
-- | exampleToStringWithOptions :: Effect Unit
-- | exampleToStringWithOptions = do
-- |   time <- PlainTime.fromString "14:30:45.123"
-- |   Console.log (PlainTime.toStringWithOptions { smallestUnit: TemporalUnit.Millisecond } time)
-- | ```
-- |
-- | ```text
-- | 14:30:45.123
-- | ```

toStringWithOptions
  :: forall provided
   . ConvertOptionsWithDefaults
       ToToStringOptions
       { | ToStringOptions }
       { | provided }
       { | ToStringOptions }
  => { | provided }
  -> PlainTime
  -> String
toStringWithOptions providedOptions plainTime =
  Function.Uncurried.runFn2
    _toString
    ( ConvertableOptions.convertOptionsWithDefaults
        ToToStringOptions
        defaultToStringOptions
        providedOptions
    )
    plainTime

-- Instances (Eq, Ord, Show from Internal)
