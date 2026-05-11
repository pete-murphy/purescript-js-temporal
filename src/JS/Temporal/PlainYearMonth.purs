-- | A year and month without day or time zone. Use for month-level values
-- | (e.g. "January 2024"). Requires a reference day for some operations.
-- |
-- | See <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Temporal/PlainYearMonth>
module JS.Temporal.PlainYearMonth
  ( module JS.Temporal.PlainYearMonth.Internal
  -- * Construction
  , PlainYearMonthComponents
  , fromWithOptions
  , from
  , fromStringWithOptions
  , fromString
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
  , addWithOptions
  , add
  , subtractWithOptions
  , subtract
  -- * Manipulation
  , withWithOptions
  , with
  -- * Conversions
  , toPlainDate
  -- * Difference
  , untilWithOptions
  , until
  , sinceWithOptions
  , since
  -- * Serialization
  , toStringWithOptions
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

type PlainYearMonthComponents =
  ( year :: Int
  , month :: Int
  , era :: String
  , eraYear :: Int
  , monthCode :: String
  , calendar :: String
  )

type OverflowOptions = (overflow :: String)

data ToOverflowOptions = ToOverflowOptions

defaultOverflowOptions :: { | OverflowOptions }
defaultOverflowOptions = Unsafe.Coerce.unsafeCoerce {}

instance ConvertOption ToOverflowOptions "overflow" Overflow String where
  convertOption _ _ = Overflow.toString

instance ConvertOption ToOverflowOptions "overflow" String String where
  convertOption _ _ = identity

foreign import _fromRecordWithOptions :: forall ro rc. EffectFn2 { | ro } { | rc } PlainYearMonth

-- | Creates a PlainYearMonth from component fields. Options: overflow.
-- |
-- | ```purescript
-- | exampleFromWithOptions :: Effect Unit
-- | exampleFromWithOptions = do
-- |   ym <- PlainYearMonth.fromWithOptions { overflow: Overflow.Constrain } { year: 2024, month: 6 }
-- |   Console.log (PlainYearMonth.toString ym)
-- | ```
-- |
-- | ```text
-- | 2024-06
-- | ```

fromWithOptions
  :: forall optsProvided provided rest
   . Union provided rest PlainYearMonthComponents
  => ConvertOptionsWithDefaults
       ToOverflowOptions
       { | OverflowOptions }
       { | optsProvided }
       { | OverflowOptions }
  => { | optsProvided }
  -> { | provided }
  -> Effect PlainYearMonth
fromWithOptions providedOptions components =
  Effect.Uncurried.runEffectFn2
    _fromRecordWithOptions
    ( ConvertableOptions.convertOptionsWithDefaults
        ToOverflowOptions
        defaultOverflowOptions
        providedOptions
    )
    components

foreign import _fromRecord :: forall r. EffectFn1 { | r } PlainYearMonth

-- | Same as [`fromWithOptions`](#fromWithOptions) with default options.
-- |
-- | ```purescript
-- | exampleFrom :: Effect Unit
-- | exampleFrom = do
-- |   locale <- JS.Intl.Locale.new_ "en-US"
-- |   yearMonth <- PlainYearMonth.from { year: 2024, month: 6 }
-- |   firstDay <- PlainYearMonth.toPlainDate { day: 1 } yearMonth
-- |   formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
-- |   Console.log (JS.Intl.DateTimeFormat.format formatter firstDay)
-- |
-- | exampleFromStringWithOptions :: Effect Unit
-- | exampleFromStringWithOptions = do
-- |   ym <- PlainYearMonth.fromStringWithOptions { overflow: Overflow.Constrain } "2024-06"
-- |   Console.log (PlainYearMonth.toString ym)
-- |
-- | exampleFromString :: Effect Unit
-- | exampleFromString = do
-- |   yearMonth <- PlainYearMonth.fromString "2024-06"
-- |   Console.log (PlainYearMonth.toString yearMonth)
-- | ```
-- |
-- | ```text
-- | June 1, 2024
-- | ```

from
  :: forall provided rest
   . Union provided rest PlainYearMonthComponents
  => { | provided }
  -> Effect PlainYearMonth
from = Effect.Uncurried.runEffectFn1 _fromRecord

foreign import _fromStringWithOptions :: forall r. EffectFn2 { | r } String PlainYearMonth

-- | Creates a PlainYearMonth from an RFC 9557 / ISO 8601 year-month string (e.g. `"2024-01"`).
-- | Options: overflow.
-- |
-- | ```purescript
-- | exampleFromStringWithOptions :: Effect Unit
-- | exampleFromStringWithOptions = do
-- |   ym <- PlainYearMonth.fromStringWithOptions { overflow: Overflow.Constrain } "2024-06"
-- |   Console.log (PlainYearMonth.toString ym)
-- | ```
-- |
-- | ```text
-- | 2024-06
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
  -> Effect PlainYearMonth
fromStringWithOptions providedOptions str =
  Effect.Uncurried.runEffectFn2 _fromStringWithOptions
    ( ConvertableOptions.convertOptionsWithDefaults
        ToOverflowOptions
        defaultOverflowOptions
        providedOptions
    )
    str

foreign import _fromString :: EffectFn1 String PlainYearMonth

-- | Same as [`fromStringWithOptions`](#fromstring) with default options.
-- |
-- | ```purescript
-- | exampleFromString :: Effect Unit
-- | exampleFromString = do
-- |   yearMonth <- PlainYearMonth.fromString "2024-06"
-- |   Console.log (PlainYearMonth.toString yearMonth)
-- | ```
-- |
-- | ```text
-- | 2024-06
-- | ```

fromString :: String -> Effect PlainYearMonth
fromString = Effect.Uncurried.runEffectFn1 _fromString

-- Properties

-- | ISO calendar year number.
-- |
-- | ```purescript
-- | exampleYear :: Effect Unit
-- | exampleYear = do
-- |   ym <- PlainYearMonth.fromString "2024-06"
-- |   Console.log ("Year: " <> show (PlainYearMonth.year ym))
-- | ```
-- |
-- | ```text
-- | Year: 2024
-- | ```

foreign import year :: PlainYearMonth -> Int
-- | Month number within the year.
-- |
-- | ```purescript
-- | exampleMonth :: Effect Unit
-- | exampleMonth = do
-- |   ym <- PlainYearMonth.fromString "2024-06"
-- |   Console.log ("Month: " <> show (PlainYearMonth.month ym))
-- |
-- | exampleMonthCode :: Effect Unit
-- | exampleMonthCode = do
-- |   ym <- PlainYearMonth.fromString "2024-06"
-- |   Console.log ("Month code: " <> PlainYearMonth.monthCode ym)
-- | ```
-- |
-- | ```text
-- | Month: 6
-- | ```

foreign import month :: PlainYearMonth -> Int
-- | Calendar-specific month code, such as `M06`.
-- |
-- | ```purescript
-- | exampleMonthCode :: Effect Unit
-- | exampleMonthCode = do
-- |   ym <- PlainYearMonth.fromString "2024-06"
-- |   Console.log ("Month code: " <> PlainYearMonth.monthCode ym)
-- | ```
-- |
-- | ```text
-- | Month code: M06
-- | ```

foreign import monthCode :: PlainYearMonth -> String
-- | Number of days in the represented month.
-- |
-- | ```purescript
-- | exampleDaysInMonth :: Effect Unit
-- | exampleDaysInMonth = do
-- |   ym <- PlainYearMonth.fromString "2024-02"
-- |   Console.log ("Days in Feb 2024: " <> show (PlainYearMonth.daysInMonth ym))
-- | ```
-- |
-- | ```text
-- | Days in Feb 2024: 29
-- | ```

foreign import daysInMonth :: PlainYearMonth -> Int
-- | Number of days in the represented year.
-- |
-- | ```purescript
-- | exampleDaysInYear :: Effect Unit
-- | exampleDaysInYear = do
-- |   ym <- PlainYearMonth.fromString "2024-06"
-- |   Console.log ("Days in 2024: " <> show (PlainYearMonth.daysInYear ym))
-- | ```
-- |
-- | ```text
-- | Days in 2024: 366
-- | ```

foreign import daysInYear :: PlainYearMonth -> Int
-- | Number of months in the represented year for this calendar.
-- |
-- | ```purescript
-- | exampleMonthsInYear :: Effect Unit
-- | exampleMonthsInYear = do
-- |   ym <- PlainYearMonth.fromString "2024-06"
-- |   Console.log ("Months in year: " <> show (PlainYearMonth.monthsInYear ym))
-- | ```
-- |
-- | ```text
-- | Months in year: 12
-- | ```

foreign import monthsInYear :: PlainYearMonth -> Int
-- | Whether the represented year is a leap year in this calendar.
-- |
-- | ```purescript
-- | exampleInLeapYear :: Effect Unit
-- | exampleInLeapYear = do
-- |   ym <- PlainYearMonth.fromString "2024-06"
-- |   Console.log ("2024 is leap year: " <> show (PlainYearMonth.inLeapYear ym))
-- | ```
-- |
-- | ```text
-- | 2024 is leap year: true
-- | ```

foreign import inLeapYear :: PlainYearMonth -> Boolean
-- | Calendar identifier, such as `"iso8601"`.
-- |
-- | ```purescript
-- | exampleCalendarId :: Effect Unit
-- | exampleCalendarId = do
-- |   ym <- PlainYearMonth.fromString "2024-06"
-- |   Console.log ("Calendar: " <> PlainYearMonth.calendarId ym)
-- | ```
-- |
-- | ```text
-- | Calendar: iso8601
-- | ```

foreign import calendarId :: PlainYearMonth -> String

foreign import _era :: PlainYearMonth -> Nullable String

-- | Era identifier when the calendar uses eras.
-- |
-- | ```purescript
-- | exampleEra :: Effect Unit
-- | exampleEra = do
-- |   ym <- PlainYearMonth.fromString "2024-06"
-- |   Console.log ("Era: " <> show (PlainYearMonth.era ym))
-- |
-- | exampleEraYear :: Effect Unit
-- | exampleEraYear = do
-- |   ym <- PlainYearMonth.fromString "2024-06"
-- |   Console.log ("Era year: " <> show (PlainYearMonth.eraYear ym))
-- | ```
-- |
-- | ```text
-- | Era: Nothing
-- | ```

era :: PlainYearMonth -> Maybe String
era = toMaybe <<< _era

foreign import _eraYear :: PlainYearMonth -> Nullable Int

-- | Year number within the current era when available.
-- |
-- | ```purescript
-- | exampleEraYear :: Effect Unit
-- | exampleEraYear = do
-- |   ym <- PlainYearMonth.fromString "2024-06"
-- |   Console.log ("Era year: " <> show (PlainYearMonth.eraYear ym))
-- | ```
-- |
-- | ```text
-- | Era year: Nothing
-- | ```

eraYear :: PlainYearMonth -> Maybe Int
eraYear = toMaybe <<< _eraYear

-- Arithmetic

foreign import _addWithOptions :: forall r. EffectFn3 { | r } Duration PlainYearMonth PlainYearMonth

-- | Adds a duration. Options: overflow.
-- |
-- | ```purescript
-- | exampleAddWithOptions :: Effect Unit
-- | exampleAddWithOptions = do
-- |   ym <- PlainYearMonth.fromString "2024-06"
-- |   threeMonths <- Duration.from { months: 3 }
-- |   later <- PlainYearMonth.addWithOptions { overflow: Overflow.Constrain } threeMonths ym
-- |   Console.log (PlainYearMonth.toString later)
-- | ```
-- |
-- | ```text
-- | 2024-09
-- | ```

addWithOptions
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
addWithOptions providedOptions duration plainYearMonth =
  Effect.Uncurried.runEffectFn3
    _addWithOptions
    ( ConvertableOptions.convertOptionsWithDefaults
        ToOverflowOptions
        defaultOverflowOptions
        providedOptions
    )
    duration
    plainYearMonth

foreign import _add :: EffectFn2 Duration PlainYearMonth PlainYearMonth

-- | Same as [`addWithOptions`](#addWithOptions) with default options.
-- |
-- | ```purescript
-- | exampleAdd :: Effect Unit
-- | exampleAdd = do
-- |   ym <- PlainYearMonth.fromString "2024-06"
-- |   threeMonths <- Duration.from { months: 3 }
-- |   later <- PlainYearMonth.add threeMonths ym
-- |   Console.log (PlainYearMonth.toString later)
-- | ```
-- |
-- | ```text
-- | 2024-09
-- | ```

add :: Duration -> PlainYearMonth -> Effect PlainYearMonth
add = Effect.Uncurried.runEffectFn2 _add

foreign import _subtractWithOptions :: forall r. EffectFn3 { | r } Duration PlainYearMonth PlainYearMonth

-- | Subtracts a duration. Options: overflow.
-- |
-- | ```purescript
-- | exampleSubtractWithOptions :: Effect Unit
-- | exampleSubtractWithOptions = do
-- |   ym <- PlainYearMonth.fromString "2024-06"
-- |   twoMonths <- Duration.from { months: 2 }
-- |   earlier <- PlainYearMonth.subtractWithOptions { overflow: Overflow.Constrain } twoMonths ym
-- |   Console.log (PlainYearMonth.toString earlier)
-- | ```
-- |
-- | ```text
-- | 2024-04
-- | ```

subtractWithOptions
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
subtractWithOptions providedOptions duration plainYearMonth =
  Effect.Uncurried.runEffectFn3
    _subtractWithOptions
    ( ConvertableOptions.convertOptionsWithDefaults
        ToOverflowOptions
        defaultOverflowOptions
        providedOptions
    )
    duration
    plainYearMonth

foreign import _subtract :: EffectFn2 Duration PlainYearMonth PlainYearMonth

-- | Same as [`subtractWithOptions`](#subtractWithOptions) with default options.
-- |
-- | ```purescript
-- | exampleSubtract :: Effect Unit
-- | exampleSubtract = do
-- |   ym <- PlainYearMonth.fromString "2024-06"
-- |   twoMonths <- Duration.from { months: 2 }
-- |   earlier <- PlainYearMonth.subtract twoMonths ym
-- |   Console.log (PlainYearMonth.toString earlier)
-- | ```
-- |
-- | ```text
-- | 2024-04
-- | ```

subtract :: Duration -> PlainYearMonth -> Effect PlainYearMonth
subtract = Effect.Uncurried.runEffectFn2 _subtract

-- Manipulation

type WithFields =
  ( year :: Int
  , month :: Int
  , monthCode :: String
  )

foreign import _withWithOptions :: forall ro rf. EffectFn3 { | ro } { | rf } PlainYearMonth PlainYearMonth

-- | Returns a new PlainYearMonth with specified fields replaced. Options: overflow.
-- |
-- | ```purescript
-- | exampleWithWithOptions :: Effect Unit
-- | exampleWithWithOptions = do
-- |   ym <- PlainYearMonth.fromString "2024-06"
-- |   changed <- PlainYearMonth.withWithOptions { overflow: Overflow.Constrain } { month: 12 } ym
-- |   Console.log (PlainYearMonth.toString changed)
-- | ```
-- |
-- | ```text
-- | 2024-12
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
  -> PlainYearMonth
  -> Effect PlainYearMonth
withWithOptions options fields plainYearMonth =
  Effect.Uncurried.runEffectFn3
    _withWithOptions
    ( ConvertableOptions.convertOptionsWithDefaults
        ToOverflowOptions
        defaultOverflowOptions
        options
    )
    fields
    plainYearMonth

foreign import _with :: forall r. EffectFn2 { | r } PlainYearMonth PlainYearMonth

-- | Same as [`withWithOptions`](#withWithOptions) with default options.
-- |
-- | ```purescript
-- | exampleWith :: Effect Unit
-- | exampleWith = do
-- |   ym <- PlainYearMonth.fromString "2024-06"
-- |   changed <- PlainYearMonth.with { month: 12 } ym
-- |   Console.log (PlainYearMonth.toString changed)
-- | ```
-- |
-- | ```text
-- | 2024-12
-- | ```

with
  :: forall fields rest
   . Union fields rest WithFields
  => { | fields }
  -> PlainYearMonth
  -> Effect PlainYearMonth
with = Effect.Uncurried.runEffectFn2 _with

-- Conversions

foreign import _toPlainDate :: EffectFn2 { day :: Int } PlainYearMonth PlainDate

-- | Converts to PlainDate by supplying a day.
-- |
-- | ```purescript
-- | exampleToPlainDate :: Effect Unit
-- | exampleToPlainDate = do
-- |   locale <- JS.Intl.Locale.new_ "en-US"
-- |   yearMonth <- PlainYearMonth.fromString "2024-01"
-- |   firstDay <- PlainYearMonth.toPlainDate { day: 1 } yearMonth
-- |   formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
-- |   Console.log (JS.Intl.DateTimeFormat.format formatter firstDay)
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

foreign import _untilWithOptions :: forall r. EffectFn3 { | r } PlainYearMonth PlainYearMonth Duration

-- | Duration from `subject` (last arg) until `other` (second arg). Arg order: `untilWithOptions options other subject`.
-- |
-- | ```purescript
-- | exampleUntilWithOptions :: Effect Unit
-- | exampleUntilWithOptions = do
-- |   locale <- JS.Intl.Locale.new_ "en-US"
-- |   start <- PlainYearMonth.fromString "2024-01"
-- |   end <- PlainYearMonth.fromString "2025-06"
-- |   duration <- PlainYearMonth.untilWithOptions { largestUnit: TemporalUnit.Year } end start
-- |   formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
-- |   Console.log (JS.Intl.DurationFormat.format formatter duration)
-- | ```
-- |
-- | ```text
-- | 1 year, 5 months
-- | ```

untilWithOptions
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
untilWithOptions providedOptions other plainYearMonth =
  Effect.Uncurried.runEffectFn3
    _untilWithOptions
    ( ConvertableOptions.convertOptionsWithDefaults
        ToDifferenceOptions
        defaultDifferenceOptions
        providedOptions
    )
    other
    plainYearMonth

foreign import _until :: EffectFn2 PlainYearMonth PlainYearMonth Duration

-- | Same as [`untilWithOptions`](#untilWithOptions) with default options.
-- |
-- | ```purescript
-- | exampleUntil :: Effect Unit
-- | exampleUntil = do
-- |   start <- PlainYearMonth.fromString "2024-01"
-- |   end <- PlainYearMonth.fromString "2025-06"
-- |   duration <- PlainYearMonth.until end start
-- |   Console.log (Duration.toString duration)
-- | ```
-- |
-- | ```text
-- | P1Y5M
-- | ```

until :: PlainYearMonth -> PlainYearMonth -> Effect Duration
until = Effect.Uncurried.runEffectFn2 _until

foreign import _sinceWithOptions :: forall r. EffectFn3 { | r } PlainYearMonth PlainYearMonth Duration

-- | Duration from `other` to `subject` (inverse of `untilWithOptions`). Arg order: `sinceWithOptions options other subject`.
-- |
-- | ```purescript
-- | exampleSinceWithOptions :: Effect Unit
-- | exampleSinceWithOptions = do
-- |   locale <- JS.Intl.Locale.new_ "en-US"
-- |   earlier <- PlainYearMonth.fromString "2022-06"
-- |   later <- PlainYearMonth.fromString "2024-06"
-- |   duration <- PlainYearMonth.sinceWithOptions { largestUnit: TemporalUnit.Year } earlier later
-- |   formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
-- |   Console.log (JS.Intl.DurationFormat.format formatter duration)
-- | ```
-- |
-- | ```text
-- | 2 years
-- | ```

sinceWithOptions
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
sinceWithOptions providedOptions other plainYearMonth =
  Effect.Uncurried.runEffectFn3
    _sinceWithOptions
    ( ConvertableOptions.convertOptionsWithDefaults
        ToDifferenceOptions
        defaultDifferenceOptions
        providedOptions
    )
    other
    plainYearMonth

foreign import _since :: EffectFn2 PlainYearMonth PlainYearMonth Duration

-- | Same as [`sinceWithOptions`](#sinceWithOptions) with default options.
-- |
-- | ```purescript
-- | exampleSince :: Effect Unit
-- | exampleSince = do
-- |   earlier <- PlainYearMonth.fromString "2022-06"
-- |   later <- PlainYearMonth.fromString "2024-06"
-- |   duration <- PlainYearMonth.since earlier later
-- |   Console.log (Duration.toString duration)
-- | ```
-- |
-- | ```text
-- | P2Y
-- | ```

since :: PlainYearMonth -> PlainYearMonth -> Effect Duration
since = Effect.Uncurried.runEffectFn2 _since

-- Comparison

-- Serialization (toString fromWithOptions Internal)

type ToStringOptions = (calendarName :: String)

data ToToStringOptions = ToToStringOptions

defaultToStringOptions :: { | ToStringOptions }
defaultToStringOptions = Unsafe.Coerce.unsafeCoerce {}

instance ConvertOption ToToStringOptions "calendarName" CalendarName String where
  convertOption _ _ = CalendarName.toString

instance ConvertOption ToToStringOptions "calendarName" String String where
  convertOption _ _ = identity

foreign import _toString :: forall r. Fn2 { | r } PlainYearMonth String

-- | Same as [`toStringWithOptions`](#tostring) with default options.
-- |
-- | ```purescript
-- | exampleToString :: Effect Unit
-- | exampleToString = do
-- |   ym <- PlainYearMonth.fromString "2024-06"
-- |   Console.log (PlainYearMonth.toString ym)
-- | ```
-- |
-- | ```text
-- | 2024-06
-- | ```

toString :: PlainYearMonth -> String
toString plainYearMonth = Function.Uncurried.runFn2 _toString defaultToStringOptions plainYearMonth

-- | Serializes to ISO 8601 year-month format. Options: calendarName.
-- |
-- | ```purescript
-- | exampleToStringWithOptions :: Effect Unit
-- | exampleToStringWithOptions = do
-- |   ym <- PlainYearMonth.fromString "2024-06"
-- |   Console.log (PlainYearMonth.toStringWithOptions {} ym)
-- | ```
-- |
-- | ```text
-- | 2024-06
-- | ```

toStringWithOptions
  :: forall provided
   . ConvertOptionsWithDefaults
       ToToStringOptions
       { | ToStringOptions }
       { | provided }
       { | ToStringOptions }
  => { | provided }
  -> PlainYearMonth
  -> String
toStringWithOptions providedOptions plainYearMonth =
  Function.Uncurried.runFn2
    _toString
    ( ConvertableOptions.convertOptionsWithDefaults
        ToToStringOptions
        defaultToStringOptions
        providedOptions
    )
    plainYearMonth

-- Instances (Eq, Ord, Show from Internal)
