-- | A point in time with nanosecond precision, represented as nanoseconds since
-- | the Unix epoch (1970-01-01T00:00:00Z). No time zone or calendar. Use
-- | [`toZonedDateTimeISO`](#tozoneddatetimeiso) to interpret in a time zone.
-- |
-- | See <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Temporal/Instant>
module JS.Temporal.Instant
  ( module JS.Temporal.Instant.Internal
  -- * Construction
  , fromString
  , fromEpochMilliseconds
  , fromEpochNanoseconds
  -- * Properties
  , epochMilliseconds
  , epochNanoseconds
  -- * Arithmetic
  , add
  , subtract
  -- * Difference
  , untilWithOptions
  , until
  , sinceWithOptions
  , since
  -- * Round
  , round
  -- * Conversions
  , toZonedDateTimeISO
  -- * Serialization
  , toStringWithOptions
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
import JS.Temporal.Instant.Internal (Instant)
import JS.Temporal.Options.RoundingMode (RoundingMode)
import JS.Temporal.Options.RoundingMode as RoundingMode
import JS.Temporal.Options.TemporalUnit (TemporalUnit)
import JS.Temporal.Options.TemporalUnit as TemporalUnit
import JS.Temporal.ZonedDateTime.Internal (ZonedDateTime)
import Unsafe.Coerce as Unsafe.Coerce

-- Construction

foreign import _fromString :: EffectFn1 String Instant

-- | Parses an ISO 8601 instant string (e.g. `"2024-01-15T12:00:00Z"`). Throws on invalid input.
-- |
-- | ```purescript
-- | exampleFromString :: Effect Unit
-- | exampleFromString = do
-- |   locale <- JS.Intl.Locale.new_ "en-US"
-- |   instant <- Instant.fromString "2024-01-15T12:00:00Z"
-- |   formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium", timeZone: "UTC" }
-- |   Console.log (JS.Intl.DateTimeFormat.format formatter instant)
-- | ```
-- | ---
-- | ```text
-- | January 15, 2024 at 12:00:00 PM
-- | ```
fromString :: String -> Effect Instant
fromString = Effect.Uncurried.runEffectFn1 _fromString

foreign import _fromEpochMilliseconds :: EffectFn1 Number Instant

-- | Creates an Instant from epoch milliseconds.
-- |
-- | ```purescript
-- | exampleFromEpochMilliseconds :: Effect Unit
-- | exampleFromEpochMilliseconds = do
-- |   instant <- Instant.fromEpochMilliseconds 1000.0
-- |   Console.log (Instant.toString instant)
-- | ```
-- | ---
-- | ```text
-- | 1970-01-01T00:00:01Z
-- | ```
fromEpochMilliseconds :: Number -> Effect Instant
fromEpochMilliseconds = Effect.Uncurried.runEffectFn1 _fromEpochMilliseconds

foreign import _fromEpochNanoseconds :: EffectFn1 BigInt Instant

-- | Creates an Instant from epoch nanoseconds.
-- |
-- | ```purescript
-- | exampleFromEpochNanoseconds :: Effect Unit
-- | exampleFromEpochNanoseconds = do
-- |   instant <- Instant.fromEpochNanoseconds (BigInt.fromInt 1000000000)
-- |   Console.log (Instant.toString instant)
-- | ```
-- | ---
-- | ```text
-- | 1970-01-01T00:00:01Z
-- | ```
fromEpochNanoseconds :: BigInt -> Effect Instant
fromEpochNanoseconds = Effect.Uncurried.runEffectFn1 _fromEpochNanoseconds

-- Properties

-- | Milliseconds since the Unix epoch.
-- |
-- | ```purescript
-- | exampleEpochMilliseconds :: Effect Unit
-- | exampleEpochMilliseconds = do
-- |   instant <- Instant.fromString "1970-01-01T00:00:01Z"
-- |   Console.log ("Epoch ms: " <> show (Instant.epochMilliseconds instant))
-- | ```
-- | ---
-- | ```text
-- | Epoch ms: 1000.0
-- | ```
foreign import epochMilliseconds :: Instant -> Number

-- | Nanoseconds since the Unix epoch.
-- |
-- | ```purescript
-- | exampleEpochNanoseconds :: Effect Unit
-- | exampleEpochNanoseconds = do
-- |   instant <- Instant.fromString "1970-01-01T00:00:01Z"
-- |   Console.log ("Epoch ns: " <> show (Instant.epochNanoseconds instant))
-- | ```
-- | ---
-- | ```text
-- | Epoch ns: 1000000000
-- | ```
foreign import epochNanoseconds :: Instant -> BigInt

-- Arithmetic

foreign import _add :: EffectFn2 Duration Instant Instant

-- | Adds a duration to an instant. Throws for calendar durations.
-- |
-- | ```purescript
-- | exampleAdd :: Effect Unit
-- | exampleAdd = do
-- |   instant <- Instant.fromString "2024-01-15T12:00:00Z"
-- |   oneHour <- Duration.from { hours: 1 }
-- |   later <- Instant.add oneHour instant
-- |   Console.log (Instant.toString later)
-- | ```
-- | ---
-- | ```text
-- | 2024-01-15T13:00:00Z
-- | ```
add :: Duration -> Instant -> Effect Instant
add = Effect.Uncurried.runEffectFn2 _add

foreign import _subtract :: EffectFn2 Duration Instant Instant

-- | Subtracts a duration. Arg order: `subtract duration instant`.
-- |
-- | ```purescript
-- | exampleSubtract :: Effect Unit
-- | exampleSubtract = do
-- |   instant <- Instant.fromString "2024-01-15T12:00:00Z"
-- |   oneHour <- Duration.from { hours: 1 }
-- |   earlier <- Instant.subtract oneHour instant
-- |   Console.log (Instant.toString earlier)
-- | ```
-- | ---
-- | ```text
-- | 2024-01-15T11:00:00Z
-- | ```
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

foreign import _untilWithOptions :: forall r. EffectFn3 { | r } Instant Instant Duration

-- | Duration from `subject` (last arg) until `other` (second arg). Arg order: `untilWithOptions options other subject`.
-- |
-- | ```purescript
-- | exampleUntilWithOptions :: Effect Unit
-- | exampleUntilWithOptions = do
-- |   locale <- JS.Intl.Locale.new_ "en-US"
-- |   earlier <- Instant.fromString "2020-01-09T00:00Z"
-- |   later <- Instant.fromString "2020-01-09T04:00Z"
-- |   result <- Instant.untilWithOptions { largestUnit: TemporalUnit.Hour } later earlier
-- |   formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
-- |   Console.log ("4 hours: " <> JS.Intl.DurationFormat.format formatter result)
-- | ```
-- | ---
-- | ```text
-- | 4 hours: 4 hours
-- | ```
untilWithOptions
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
untilWithOptions providedOptions other instant =
  Effect.Uncurried.runEffectFn3
    _untilWithOptions
    ( ConvertableOptions.convertOptionsWithDefaults
        ToDifferenceOptions
        defaultDifferenceOptions
        providedOptions
    )
    other
    instant

foreign import _until :: EffectFn2 Instant Instant Duration

-- | Same as [`untilWithOptions`](#v:untilWithOptions) with default options.
-- |
-- | ```purescript
-- | exampleUntil :: Effect Unit
-- | exampleUntil = do
-- |   earlier <- Instant.fromString "2020-01-09T00:00Z"
-- |   later <- Instant.fromString "2020-01-09T04:00Z"
-- |   result <- Instant.until later earlier
-- |   Console.log (Duration.toString result)
-- | ```
-- | ---
-- | ```text
-- | PT14400S
-- | ```
until :: Instant -> Instant -> Effect Duration
until = Effect.Uncurried.runEffectFn2 _until

foreign import _sinceWithOptions :: forall r. EffectFn3 { | r } Instant Instant Duration

-- | Duration from `other` to `subject` (inverse of `untilWithOptions`). Arg order: `sinceWithOptions options other subject`.
-- |
-- | ```purescript
-- | exampleSinceWithOptions :: Effect Unit
-- | exampleSinceWithOptions = do
-- |   locale <- JS.Intl.Locale.new_ "en-US"
-- |   earlier <- Instant.fromString "2020-01-09T00:00Z"
-- |   later <- Instant.fromString "2020-01-09T04:00Z"
-- |   elapsed <- Instant.sinceWithOptions { largestUnit: TemporalUnit.Hour } earlier later
-- |   formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
-- |   Console.log ("Elapsed: " <> JS.Intl.DurationFormat.format formatter elapsed)
-- | ```
-- | ---
-- | ```text
-- | Elapsed: 4 hours
-- | ```
sinceWithOptions
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
sinceWithOptions providedOptions other instant =
  Effect.Uncurried.runEffectFn3
    _sinceWithOptions
    ( ConvertableOptions.convertOptionsWithDefaults
        ToDifferenceOptions
        defaultDifferenceOptions
        providedOptions
    )
    other
    instant

foreign import _since :: EffectFn2 Instant Instant Duration

-- | Same as [`sinceWithOptions`](#v:sinceWithOptions) with default options.
-- |
-- | ```purescript
-- | exampleSince :: Effect Unit
-- | exampleSince = do
-- |   earlier <- Instant.fromString "2020-01-09T00:00Z"
-- |   later <- Instant.fromString "2020-01-09T04:00Z"
-- |   elapsed <- Instant.since earlier later
-- |   Console.log (Duration.toString elapsed)
-- | ```
-- | ---
-- | ```text
-- | PT14400S
-- | ```
since :: Instant -> Instant -> Effect Duration
since = Effect.Uncurried.runEffectFn2 _since

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
-- |
-- | ```purescript
-- | exampleRound :: Effect Unit
-- | exampleRound = do
-- |   instant <- Instant.fromString "2024-01-15T12:00:00.789Z"
-- |   rounded <- Instant.round
-- |     { smallestUnit: TemporalUnit.Second
-- |     , roundingMode: RoundingMode.HalfExpand
-- |     }
-- |     instant
-- |   Console.log (Instant.toString rounded)
-- | ```
-- | ---
-- | ```text
-- | 2024-01-15T12:00:01Z
-- | ```
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
-- |
-- | ```purescript
-- | exampleToZonedDateTimeISO :: Effect Unit
-- | exampleToZonedDateTimeISO = do
-- |   instant <- Instant.fromString "2024-01-15T12:00:00Z"
-- |   zoned <- pure (Instant.toZonedDateTimeISO "America/New_York" instant)
-- |   Console.log (ZonedDateTime.toString zoned)
-- | ```
-- | ---
-- | ```text
-- | 2024-01-15T07:00:00-05:00[America/New_York]
-- | ```
toZonedDateTimeISO :: String -> Instant -> ZonedDateTime
toZonedDateTimeISO = Function.Uncurried.runFn2 _toZonedDateTimeISO

-- Serialization (toString from Internal)

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

-- | Same as [`toStringWithOptions`](#v:toStringWithOptions) with default options.
-- |
-- | ```purescript
-- | exampleToString :: Effect Unit
-- | exampleToString = do
-- |   instant <- Instant.fromString "2024-01-15T12:00:00.789Z"
-- |   Console.log (Instant.toString instant)
-- | ```
-- | ---
-- | ```text
-- | 2024-01-15T12:00:00.789Z
-- | ```
toString :: Instant -> String
toString instant = Function.Uncurried.runFn2 _toString defaultToStringOptions instant

-- | Serializes the instant to ISO 8601 format. Options: fractionalSecondDigits, smallestUnit, roundingMode, timeZone.
-- |
-- | ```purescript
-- | exampleToStringWithOptions :: Effect Unit
-- | exampleToStringWithOptions = do
-- |   instant <- Instant.fromString "2024-01-15T12:00:00.789Z"
-- |   Console.log
-- |     ( Instant.toStringWithOptions
-- |         { smallestUnit: TemporalUnit.Second
-- |         , timeZone: "UTC"
-- |         }
-- |         instant
-- |     )
-- | ```
-- | ---
-- | ```text
-- | 2024-01-15T12:00:00+00:00
-- | ```
toStringWithOptions
  :: forall provided
   . ConvertOptionsWithDefaults
       ToToStringOptions
       { | ToStringOptions }
       { | provided }
       { | ToStringOptions }
  => { | provided }
  -> Instant
  -> String
toStringWithOptions providedOptions instant =
  Function.Uncurried.runFn2
    _toString
    ( ConvertableOptions.convertOptionsWithDefaults
        ToToStringOptions
        defaultToStringOptions
        providedOptions
    )
    instant

-- Instances (Eq, Ord, Show from Internal)
