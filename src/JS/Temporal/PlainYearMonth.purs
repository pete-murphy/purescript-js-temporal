module JS.Temporal.PlainYearMonth
  ( module JS.Temporal.PlainYearMonth.Internal
  -- * Construction
  , new
  , from
  , from_
  -- * Properties
  , year
  , month
  , monthCode
  , daysInMonth
  , daysInYear
  , monthsInYear
  , inLeapYear
  , calendarId
  , era
  , eraYear
  -- * Arithmetic
  , add
  , add_
  , subtract
  , subtract_
  -- * Manipulation
  , with
  -- * Conversions
  , toPlainDate
  -- * Difference
  , until
  , until_
  , since
  , since_
  -- * Serialization
  , toString
  -- * Options
  , ToOverflowOptions
  , ToDifferenceOptions
  , ToToStringOptions
  ) where

import Prelude hiding (add, compare)

import ConvertableOptions (class ConvertOption, class ConvertOptionsWithDefaults)
import ConvertableOptions as ConvertableOptions
import Data.Function.Uncurried (Fn2)
import Data.Function.Uncurried as Function.Uncurried
import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import Effect (Effect)
import Effect.Uncurried (EffectFn1, EffectFn2, EffectFn3)
import Effect.Uncurried as Effect.Uncurried
import JS.Temporal.CalendarName (CalendarName)
import JS.Temporal.CalendarName as CalendarName
import JS.Temporal.Duration.Internal (Duration)
import JS.Temporal.Overflow (Overflow)
import JS.Temporal.Overflow as Overflow
import JS.Temporal.RoundingMode (RoundingMode)
import JS.Temporal.RoundingMode as RoundingMode
import JS.Temporal.TemporalUnit (TemporalUnit)
import JS.Temporal.TemporalUnit as TemporalUnit
import JS.Temporal.PlainDate.Internal (PlainDate)
import JS.Temporal.PlainYearMonth.Internal (PlainYearMonth)
import Prim.Row (class Union)
import Unsafe.Coerce as Unsafe.Coerce

-- Construction

foreign import _new :: EffectFn2 Int Int PlainYearMonth

new :: Int -> Int -> Effect PlainYearMonth
new = Effect.Uncurried.runEffectFn2 _new

type OverflowOptions = (overflow :: String)

data ToOverflowOptions = ToOverflowOptions

defaultOverflowOptions :: { | OverflowOptions }
defaultOverflowOptions = Unsafe.Coerce.unsafeCoerce {}

instance ConvertOption ToOverflowOptions "overflow" Overflow String where
  convertOption _ _ = Overflow.toString

instance ConvertOption ToOverflowOptions "overflow" String String where
  convertOption _ _ = identity

foreign import _from :: forall r. EffectFn2 { | r } String PlainYearMonth

from
  :: forall provided
   . ConvertOptionsWithDefaults
       ToOverflowOptions
       { | OverflowOptions }
       { | provided }
       { | OverflowOptions }
  => { | provided }
  -> String
  -> Effect PlainYearMonth
from providedOptions str =
  Effect.Uncurried.runEffectFn2 _from
    ( ConvertableOptions.convertOptionsWithDefaults
        ToOverflowOptions
        defaultOverflowOptions
        providedOptions
    )
    str

foreign import _fromNoOpts :: EffectFn1 String PlainYearMonth

from_ :: String -> Effect PlainYearMonth
from_ = Effect.Uncurried.runEffectFn1 _fromNoOpts

-- Properties

foreign import year :: PlainYearMonth -> Int
foreign import month :: PlainYearMonth -> Int
foreign import monthCode :: PlainYearMonth -> String
foreign import daysInMonth :: PlainYearMonth -> Int
foreign import daysInYear :: PlainYearMonth -> Int
foreign import monthsInYear :: PlainYearMonth -> Int
foreign import inLeapYear :: PlainYearMonth -> Boolean
foreign import calendarId :: PlainYearMonth -> String

foreign import _era :: PlainYearMonth -> Nullable String

era :: PlainYearMonth -> Maybe String
era = toMaybe <<< _era

foreign import _eraYear :: PlainYearMonth -> Nullable Int

eraYear :: PlainYearMonth -> Maybe Int
eraYear = toMaybe <<< _eraYear

-- Arithmetic

foreign import _add :: forall r. EffectFn3 { | r } Duration PlainYearMonth PlainYearMonth

add
  :: forall provided
   . ConvertOptionsWithDefaults
       ToOverflowOptions
       { | OverflowOptions }
       { | provided }
       { | OverflowOptions }
  => { | provided }
  -> Duration
  -> PlainYearMonth
  -> Effect PlainYearMonth
add providedOptions duration plainYearMonth =
  Effect.Uncurried.runEffectFn3
    _add
    ( ConvertableOptions.convertOptionsWithDefaults
        ToOverflowOptions
        defaultOverflowOptions
        providedOptions
    )
    duration
    plainYearMonth

foreign import _addNoOpts :: EffectFn2 Duration PlainYearMonth PlainYearMonth

add_ :: Duration -> PlainYearMonth -> Effect PlainYearMonth
add_ = Effect.Uncurried.runEffectFn2 _addNoOpts

foreign import _subtract :: forall r. EffectFn3 { | r } Duration PlainYearMonth PlainYearMonth

subtract
  :: forall provided
   . ConvertOptionsWithDefaults
       ToOverflowOptions
       { | OverflowOptions }
       { | provided }
       { | OverflowOptions }
  => { | provided }
  -> Duration
  -> PlainYearMonth
  -> Effect PlainYearMonth
subtract providedOptions duration plainYearMonth =
  Effect.Uncurried.runEffectFn3
    _subtract
    ( ConvertableOptions.convertOptionsWithDefaults
        ToOverflowOptions
        defaultOverflowOptions
        providedOptions
    )
    duration
    plainYearMonth

foreign import _subtractNoOpts :: EffectFn2 Duration PlainYearMonth PlainYearMonth

subtract_ :: Duration -> PlainYearMonth -> Effect PlainYearMonth
subtract_ = Effect.Uncurried.runEffectFn2 _subtractNoOpts

-- Manipulation

type WithFields =
  ( year :: Int
  , month :: Int
  , monthCode :: String
  )

foreign import _with :: forall r. EffectFn2 { | r } PlainYearMonth PlainYearMonth

with
  :: forall fields rest
   . Union fields rest WithFields
  => { | fields }
  -> PlainYearMonth
  -> Effect PlainYearMonth
with = Effect.Uncurried.runEffectFn2 _with

-- Conversions

foreign import _toPlainDate :: EffectFn2 { day :: Int } PlainYearMonth PlainDate

toPlainDate :: { day :: Int } -> PlainYearMonth -> Effect PlainDate
toPlainDate = Effect.Uncurried.runEffectFn2 _toPlainDate

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

foreign import _until :: forall r. EffectFn3 { | r } PlainYearMonth PlainYearMonth Duration

until
  :: forall provided
   . ConvertOptionsWithDefaults
       ToDifferenceOptions
       { | DifferenceOptions }
       { | provided }
       { | DifferenceOptions }
  => { | provided }
  -> PlainYearMonth
  -> PlainYearMonth
  -> Effect Duration
until providedOptions other plainYearMonth =
  Effect.Uncurried.runEffectFn3
    _until
    ( ConvertableOptions.convertOptionsWithDefaults
        ToDifferenceOptions
        defaultDifferenceOptions
        providedOptions
    )
    other
    plainYearMonth

foreign import _untilNoOpts :: EffectFn2 PlainYearMonth PlainYearMonth Duration

until_ :: PlainYearMonth -> PlainYearMonth -> Effect Duration
until_ = Effect.Uncurried.runEffectFn2 _untilNoOpts

foreign import _since :: forall r. EffectFn3 { | r } PlainYearMonth PlainYearMonth Duration

since
  :: forall provided
   . ConvertOptionsWithDefaults
       ToDifferenceOptions
       { | DifferenceOptions }
       { | provided }
       { | DifferenceOptions }
  => { | provided }
  -> PlainYearMonth
  -> PlainYearMonth
  -> Effect Duration
since providedOptions other plainYearMonth =
  Effect.Uncurried.runEffectFn3
    _since
    ( ConvertableOptions.convertOptionsWithDefaults
        ToDifferenceOptions
        defaultDifferenceOptions
        providedOptions
    )
    other
    plainYearMonth

foreign import _sinceNoOpts :: EffectFn2 PlainYearMonth PlainYearMonth Duration

since_ :: PlainYearMonth -> PlainYearMonth -> Effect Duration
since_ = Effect.Uncurried.runEffectFn2 _sinceNoOpts

-- Comparison

-- Serialization (toString_ from Internal)

type ToStringOptions = (calendarName :: String)

data ToToStringOptions = ToToStringOptions

defaultToStringOptions :: { | ToStringOptions }
defaultToStringOptions = Unsafe.Coerce.unsafeCoerce {}

instance ConvertOption ToToStringOptions "calendarName" CalendarName String where
  convertOption _ _ = CalendarName.toString

instance ConvertOption ToToStringOptions "calendarName" String String where
  convertOption _ _ = identity

foreign import _toString :: forall r. Fn2 { | r } PlainYearMonth String

toString
  :: forall provided
   . ConvertOptionsWithDefaults
       ToToStringOptions
       { | ToStringOptions }
       { | provided }
       { | ToStringOptions }
  => { | provided }
  -> PlainYearMonth
  -> String
toString providedOptions plainYearMonth =
  Function.Uncurried.runFn2
    _toString
    ( ConvertableOptions.convertOptionsWithDefaults
        ToToStringOptions
        defaultToStringOptions
        providedOptions
    )
    plainYearMonth

-- Instances (Eq, Ord, Show from Internal)
