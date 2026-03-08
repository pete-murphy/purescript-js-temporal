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
import JS.Temporal.Duration.Internal (Duration)
import JS.Temporal.Options.CalendarName (CalendarName)
import JS.Temporal.Options.CalendarName as CalendarName
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
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | yearMonth <- PlainYearMonth.new 2024 6
-- | firstDay <- PlainYearMonth.toPlainDate { day: 1 } yearMonth
-- | formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
-- | Console.log (JS.Intl.DateTimeFormat.format formatter firstDay)
-- | ```
-- |
-- | ```text
-- | June 1, 2024
-- | ```

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

-- | Creates a PlainYearMonth from an RFC 9557 / ISO 8601 year-month string (e.g. `"2024-01"`).
-- | Options: overflow.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | yearMonth <- PlainYearMonth.from { overflow: Overflow.Constrain } "2024-06"
-- | firstDay <- PlainYearMonth.toPlainDate { day: 1 } yearMonth
-- | formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
-- | Console.log (JS.Intl.DateTimeFormat.format formatter firstDay)
-- | ```
-- |
-- | ```text
-- | June 1, 2024
-- | ```

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

-- | Same as [`from`](#from) with default options.

from_ :: String -> Effect PlainYearMonth
from_ = Effect.Uncurried.runEffectFn1 _fromNoOpts

-- Properties

-- | ISO calendar year number.
foreign import year :: PlainYearMonth -> Int
-- | Month number within the year.
foreign import month :: PlainYearMonth -> Int
-- | Calendar-specific month code, such as `M06`.
foreign import monthCode :: PlainYearMonth -> String
-- | Number of days in the represented month.
foreign import daysInMonth :: PlainYearMonth -> Int
-- | Number of days in the represented year.
foreign import daysInYear :: PlainYearMonth -> Int
-- | Number of months in the represented year for this calendar.
foreign import monthsInYear :: PlainYearMonth -> Int
-- | Whether the represented year is a leap year in this calendar.
foreign import inLeapYear :: PlainYearMonth -> Boolean
-- | Calendar identifier, such as `"iso8601"`.
foreign import calendarId :: PlainYearMonth -> String

foreign import _era :: PlainYearMonth -> Nullable String

-- | Era identifier when the calendar uses eras.
era :: PlainYearMonth -> Maybe String
era = toMaybe <<< _era

foreign import _eraYear :: PlainYearMonth -> Nullable Int

-- | Year number within the current era when available.
eraYear :: PlainYearMonth -> Maybe Int
eraYear = toMaybe <<< _eraYear

-- Arithmetic

foreign import _add :: forall r. EffectFn3 { | r } Duration PlainYearMonth PlainYearMonth

-- | Adds a duration. Options: overflow.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | yearMonth <- PlainYearMonth.from_ "2024-06"
-- | threeMonths <- Duration.new { months: 3 }
-- | later <- PlainYearMonth.add { overflow: Overflow.Constrain } threeMonths yearMonth
-- | firstDay <- PlainYearMonth.toPlainDate { day: 1 } later
-- | formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
-- | Console.log (JS.Intl.DateTimeFormat.format formatter firstDay)
-- | ```
-- |
-- | ```text
-- | September 1, 2024
-- | ```

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

-- | Same as [`add`](#add) with default options.

add_ :: Duration -> PlainYearMonth -> Effect PlainYearMonth
add_ = Effect.Uncurried.runEffectFn2 _addNoOpts

foreign import _subtract :: forall r. EffectFn3 { | r } Duration PlainYearMonth PlainYearMonth

-- | Subtracts a duration. Options: overflow.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | yearMonth <- PlainYearMonth.from_ "2024-06"
-- | twoMonths <- Duration.new { months: 2 }
-- | earlier <- PlainYearMonth.subtract { overflow: Overflow.Constrain } twoMonths yearMonth
-- | firstDay <- PlainYearMonth.toPlainDate { day: 1 } earlier
-- | formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
-- | Console.log (JS.Intl.DateTimeFormat.format formatter firstDay)
-- | ```
-- |
-- | ```text
-- | April 1, 2024
-- | ```

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

-- | Same as [`subtract`](#subtract) with default options.

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
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | yearMonth <- PlainYearMonth.from_ "2024-06"
-- | changed <- PlainYearMonth.with { overflow: Overflow.Constrain } { month: 12 } yearMonth
-- | firstDay <- PlainYearMonth.toPlainDate { day: 1 } changed
-- | formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
-- | Console.log (JS.Intl.DateTimeFormat.format formatter firstDay)
-- | ```
-- |
-- | ```text
-- | December 1, 2024
-- | ```

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

-- | Same as [`with`](#with) with default options.

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
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | yearMonth <- PlainYearMonth.from_ "2024-01"
-- | firstDay <- PlainYearMonth.toPlainDate { day: 1 } yearMonth
-- | formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
-- | Console.log (JS.Intl.DateTimeFormat.format formatter firstDay)
-- | ```
-- |
-- | ```text
-- | January 1, 2024
-- | ```

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

-- | Duration from `subject` (last arg) until `other` (second arg). Arg order: `until options other subject`.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | start <- PlainYearMonth.from_ "2024-01"
-- | end <- PlainYearMonth.from_ "2025-06"
-- | duration <- PlainYearMonth.until { largestUnit: TemporalUnit.Year } end start
-- | formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
-- | Console.log (JS.Intl.DurationFormat.format formatter duration)
-- | ```
-- |
-- | ```text
-- | 1 year, 5 months
-- | ```

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

-- | Same as [`until`](#until) with default options.

until_ :: PlainYearMonth -> PlainYearMonth -> Effect Duration
until_ = Effect.Uncurried.runEffectFn2 _untilNoOpts

foreign import _since :: forall r. EffectFn3 { | r } PlainYearMonth PlainYearMonth Duration

-- | Duration from `other` to `subject` (inverse of until). Arg order: `since options other subject`.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | earlier <- PlainYearMonth.from_ "2022-06"
-- | later <- PlainYearMonth.from_ "2024-06"
-- | duration <- PlainYearMonth.since { largestUnit: TemporalUnit.Year } earlier later
-- | formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
-- | Console.log (JS.Intl.DurationFormat.format formatter duration)
-- | ```
-- |
-- | ```text
-- | 2 years
-- | ```

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

-- | Same as [`since`](#since) with default options.

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

-- | Same as [`toString`](#tostring) with default options.

toString_ :: PlainYearMonth -> String
toString_ plainYearMonth = Function.Uncurried.runFn2 _toString defaultToStringOptions plainYearMonth

-- | Serializes to ISO 8601 year-month format. Options: calendarName.
-- |
-- | ```purescript
-- | yearMonth <- PlainYearMonth.from_ "2024-06"
-- | Console.log (PlainYearMonth.toString {} yearMonth)
-- | ```
-- |
-- | ```text
-- | 2024-06
-- | ```

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
