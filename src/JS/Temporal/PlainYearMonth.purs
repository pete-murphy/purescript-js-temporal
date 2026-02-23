-- | A year and month without day or time zone. Use for month-level values
-- | (e.g. "January 2024"). Requires a reference day for some operations.
-- |
-- | See <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Temporal/PlainYearMonth>
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
  , with_
  -- * Conversions
  , toPlainDate
  -- * Difference
  , until
  , until_
  , since
  , since_
  -- * Serialization
  , toString
  , toString_
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
import JS.Temporal.Options.CalendarName (CalendarName)
import JS.Temporal.Options.CalendarName as CalendarName
import JS.Temporal.Duration.Internal (Duration)
import JS.Temporal.Options.Overflow (Overflow)
import JS.Temporal.Options.Overflow as Overflow
import JS.Temporal.Options.RoundingMode (RoundingMode)
import JS.Temporal.Options.RoundingMode as RoundingMode
import JS.Temporal.Options.TemporalUnit (TemporalUnit)
import JS.Temporal.Options.TemporalUnit as TemporalUnit
import JS.Temporal.PlainDate.Internal (PlainDate)
import JS.Temporal.PlainYearMonth.Internal (PlainYearMonth)
import Prim.Row (class Union)
import Unsafe.Coerce as Unsafe.Coerce

-- Construction

foreign import _new :: EffectFn2 Int Int PlainYearMonth

-- | Creates a PlainYearMonth from year and month.
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

-- | Parses a year-month string (e.g. `"2024-01"`). Options: overflow.
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

-- | Same as from with default options.
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

-- | Adds a duration. Options: overflow.
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

-- | Same as add with default options.
add_ :: Duration -> PlainYearMonth -> Effect PlainYearMonth
add_ = Effect.Uncurried.runEffectFn2 _addNoOpts

foreign import _subtract :: forall r. EffectFn3 { | r } Duration PlainYearMonth PlainYearMonth

-- | Subtracts a duration. Options: overflow.
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

-- | Same as subtract with default options.
subtract_ :: Duration -> PlainYearMonth -> Effect PlainYearMonth
subtract_ = Effect.Uncurried.runEffectFn2 _subtractNoOpts

-- Manipulation

type WithFields =
  ( year :: Int
  , month :: Int
  , monthCode :: String
  )

foreign import _with :: forall ro rf. EffectFn3 { | ro } { | rf } PlainYearMonth PlainYearMonth

-- | Returns a new PlainYearMonth with specified fields replaced. Options: overflow.
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
  -> PlainYearMonth
  -> Effect PlainYearMonth
with options fields plainYearMonth =
  Effect.Uncurried.runEffectFn3
    _with
    ( ConvertableOptions.convertOptionsWithDefaults
        ToOverflowOptions
        defaultOverflowOptions
        options
    )
    fields
    plainYearMonth

foreign import _withNoOpts :: forall r. EffectFn2 { | r } PlainYearMonth PlainYearMonth

-- | Same as with with default options.
with_
  :: forall fields rest
   . Union fields rest WithFields
  => { | fields }
  -> PlainYearMonth
  -> Effect PlainYearMonth
with_ = Effect.Uncurried.runEffectFn2 _withNoOpts

-- Conversions

foreign import _toPlainDate :: EffectFn2 { day :: Int } PlainYearMonth PlainDate

-- | Converts to PlainDate by supplying a day.
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

-- | Duration from this year-month until the other.
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

-- | Same as until with default options.
until_ :: PlainYearMonth -> PlainYearMonth -> Effect Duration
until_ = Effect.Uncurried.runEffectFn2 _untilNoOpts

foreign import _since :: forall r. EffectFn3 { | r } PlainYearMonth PlainYearMonth Duration

-- | Duration from the other year-month to this one.
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

-- | Same as since with default options.
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

-- | Default ISO 8601 serialization (no options). Prefer over `toString {}`.
toString_ :: PlainYearMonth -> String
toString_ plainYearMonth = Function.Uncurried.runFn2 _toString defaultToStringOptions plainYearMonth

-- | Serializes to ISO 8601 year-month format. Options: calendarName.
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
