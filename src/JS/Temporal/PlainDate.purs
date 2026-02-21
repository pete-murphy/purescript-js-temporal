-- | A calendar date (year, month, day) without time or time zone. Use for
-- | date-only values (e.g. birthdays, all-day events). Uses ISO 8601 calendar
-- | by default.
-- |
-- | See <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Temporal/PlainDate>
module JS.Temporal.PlainDate
  ( module JS.Temporal.PlainDate.Internal
  -- * Construction
  , new
  , from
  , from_
  -- * Properties
  , year
  , month
  , day
  , monthCode
  , dayOfWeek
  , dayOfYear
  , weekOfYear
  , yearOfWeek
  , daysInMonth
  , daysInYear
  , daysInWeek
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
  , withCalendar
  -- * Conversions
  , fromDate
  , toDate
  , toPlainYearMonth
  , toPlainMonthDay
  , toPlainDateTime
  , toZonedDateTime
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
import Data.Function.Uncurried (Fn1, Fn2)
import Data.Function.Uncurried as Function.Uncurried
import Data.Date (Date)
import Data.Date as Date
import Data.Enum (fromEnum, toEnum)
import Data.Maybe (Maybe, fromJust)
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
import JS.Temporal.PlainDate.Internal (PlainDate)
import JS.Temporal.PlainDateTime.Internal (PlainDateTime)
import JS.Temporal.PlainMonthDay.Internal (PlainMonthDay)
import JS.Temporal.PlainTime.Internal (PlainTime)
import JS.Temporal.PlainYearMonth.Internal (PlainYearMonth)
import JS.Temporal.ZonedDateTime.Internal (ZonedDateTime)
import JS.Temporal.TemporalUnit as TemporalUnit
import Partial.Unsafe (unsafePartial)
import Prim.Row (class Union)
import Unsafe.Coerce as Unsafe.Coerce

-- Construction

foreign import _new :: EffectFn3 Int Int Int PlainDate

-- | Creates a PlainDate from year, month, day. Throws if invalid.
new :: Int -> Int -> Int -> Effect PlainDate
new = Effect.Uncurried.runEffectFn3 _new

type OverflowOptions = (overflow :: String)

data ToOverflowOptions = ToOverflowOptions

defaultOverflowOptions :: { | OverflowOptions }
defaultOverflowOptions = Unsafe.Coerce.unsafeCoerce {}

instance ConvertOption ToOverflowOptions "overflow" Overflow String where
  convertOption _ _ = Overflow.toString

instance ConvertOption ToOverflowOptions "overflow" String String where
  convertOption _ _ = identity

foreign import _from :: forall r. EffectFn2 { | r } String PlainDate

-- | Parses a date string (e.g. `"2024-01-15"`). Options: overflow.
from
  :: forall provided
   . ConvertOptionsWithDefaults
       ToOverflowOptions
       { | OverflowOptions }
       { | provided }
       { | OverflowOptions }
  => { | provided }
  -> String
  -> Effect PlainDate
from providedOptions str =
  Effect.Uncurried.runEffectFn2
    _from
    ( ConvertableOptions.convertOptionsWithDefaults
        ToOverflowOptions
        defaultOverflowOptions
        providedOptions
    )
    str

foreign import _fromNoOpts :: EffectFn1 String PlainDate

-- | Same as from with default options.
from_ :: String -> Effect PlainDate
from_ = Effect.Uncurried.runEffectFn1 _fromNoOpts

-- Properties

foreign import year :: PlainDate -> Int
foreign import month :: PlainDate -> Int
foreign import day :: PlainDate -> Int
foreign import monthCode :: PlainDate -> String
foreign import dayOfWeek :: PlainDate -> Int
foreign import dayOfYear :: PlainDate -> Int
foreign import daysInMonth :: PlainDate -> Int
foreign import daysInYear :: PlainDate -> Int
foreign import daysInWeek :: PlainDate -> Int
foreign import monthsInYear :: PlainDate -> Int
foreign import inLeapYear :: PlainDate -> Boolean
foreign import calendarId :: PlainDate -> String

foreign import _weekOfYear :: PlainDate -> Nullable Int

weekOfYear :: PlainDate -> Maybe Int
weekOfYear = toMaybe <<< _weekOfYear

foreign import _yearOfWeek :: PlainDate -> Nullable Int

yearOfWeek :: PlainDate -> Maybe Int
yearOfWeek = toMaybe <<< _yearOfWeek

foreign import _era :: PlainDate -> Nullable String

era :: PlainDate -> Maybe String
era = toMaybe <<< _era

foreign import _eraYear :: PlainDate -> Nullable Int

eraYear :: PlainDate -> Maybe Int
eraYear = toMaybe <<< _eraYear

-- Arithmetic

foreign import _add :: forall r. EffectFn3 { | r } Duration PlainDate PlainDate

-- | Adds a duration to a date. Supports calendar durations. Options: overflow.
add
  :: forall provided
   . ConvertOptionsWithDefaults
       ToOverflowOptions
       { | OverflowOptions }
       { | provided }
       { | OverflowOptions }
  => { | provided }
  -> Duration
  -> PlainDate
  -> Effect PlainDate
add providedOptions duration plainDate =
  Effect.Uncurried.runEffectFn3
    _add
    ( ConvertableOptions.convertOptionsWithDefaults
        ToOverflowOptions
        defaultOverflowOptions
        providedOptions
    )
    duration
    plainDate

foreign import _addNoOpts :: EffectFn2 Duration PlainDate PlainDate

-- | Same as add with default options.
add_ :: Duration -> PlainDate -> Effect PlainDate
add_ = Effect.Uncurried.runEffectFn2 _addNoOpts

foreign import _subtract :: forall r. EffectFn3 { | r } Duration PlainDate PlainDate

-- | Subtracts a duration from a date. Options: overflow.
subtract
  :: forall provided
   . ConvertOptionsWithDefaults
       ToOverflowOptions
       { | OverflowOptions }
       { | provided }
       { | OverflowOptions }
  => { | provided }
  -> Duration
  -> PlainDate
  -> Effect PlainDate
subtract providedOptions duration plainDate =
  Effect.Uncurried.runEffectFn3
    _subtract
    ( ConvertableOptions.convertOptionsWithDefaults
        ToOverflowOptions
        defaultOverflowOptions
        providedOptions
    )
    duration
    plainDate

foreign import _subtractNoOpts :: EffectFn2 Duration PlainDate PlainDate

-- | Same as subtract with default options.
subtract_ :: Duration -> PlainDate -> Effect PlainDate
subtract_ = Effect.Uncurried.runEffectFn2 _subtractNoOpts

-- Manipulation

type WithFields =
  ( year :: Int
  , month :: Int
  , day :: Int
  , monthCode :: String
  )

foreign import _with :: forall ro rf. EffectFn3 { | ro } { | rf } PlainDate PlainDate

-- | Returns a new PlainDate with specified fields replaced. Options: overflow.
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
  -> PlainDate
  -> Effect PlainDate
with options fields plainDate =
  Effect.Uncurried.runEffectFn3
    _with
    ( ConvertableOptions.convertOptionsWithDefaults
        ToOverflowOptions
        defaultOverflowOptions
        options
    )
    fields
    plainDate

foreign import _withNoOpts :: forall r. EffectFn2 { | r } PlainDate PlainDate

-- | Same as with with default options.
with_
  :: forall fields rest
   . Union fields rest WithFields
  => { | fields }
  -> PlainDate
  -> Effect PlainDate
with_ = Effect.Uncurried.runEffectFn2 _withNoOpts

foreign import _withCalendar :: EffectFn2 String PlainDate PlainDate

-- | Returns a new PlainDate with the given calendar (e.g. `"iso8601"`).
withCalendar :: String -> PlainDate -> Effect PlainDate
withCalendar = Effect.Uncurried.runEffectFn2 _withCalendar

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

foreign import _until :: forall r. EffectFn3 { | r } PlainDate PlainDate Duration

-- | Duration from this date until the other. Options: largestUnit, smallestUnit, roundingIncrement, roundingMode.
until
  :: forall provided
   . ConvertOptionsWithDefaults
       ToDifferenceOptions
       { | DifferenceOptions }
       { | provided }
       { | DifferenceOptions }
  => { | provided }
  -> PlainDate
  -> PlainDate
  -> Effect Duration
until providedOptions other plainDate =
  Effect.Uncurried.runEffectFn3
    _until
    ( ConvertableOptions.convertOptionsWithDefaults
        ToDifferenceOptions
        defaultDifferenceOptions
        providedOptions
    )
    other
    plainDate

foreign import _untilNoOpts :: EffectFn2 PlainDate PlainDate Duration

-- | Same as until with default options.
until_ :: PlainDate -> PlainDate -> Effect Duration
until_ = Effect.Uncurried.runEffectFn2 _untilNoOpts

foreign import _since :: forall r. EffectFn3 { | r } PlainDate PlainDate Duration

-- | Duration from the other date to this one (inverse of until).
since
  :: forall provided
   . ConvertOptionsWithDefaults
       ToDifferenceOptions
       { | DifferenceOptions }
       { | provided }
       { | DifferenceOptions }
  => { | provided }
  -> PlainDate
  -> PlainDate
  -> Effect Duration
since providedOptions other plainDate =
  Effect.Uncurried.runEffectFn3
    _since
    ( ConvertableOptions.convertOptionsWithDefaults
        ToDifferenceOptions
        defaultDifferenceOptions
        providedOptions
    )
    other
    plainDate

foreign import _sinceNoOpts :: EffectFn2 PlainDate PlainDate Duration

-- | Same as since with default options.
since_ :: PlainDate -> PlainDate -> Effect Duration
since_ = Effect.Uncurried.runEffectFn2 _sinceNoOpts

-- Conversions

-- | Converts a purescript-datetime `Date` to a `PlainDate`.
-- | See docs/purescript-datetime-interop.md.
fromDate :: Date -> Effect PlainDate
fromDate date = new (fromEnum (Date.year date)) (fromEnum (Date.month date)) (fromEnum (Date.day date))

-- | Converts a `PlainDate` to a purescript-datetime `Date`.
-- | See docs/purescript-datetime-interop.md.
toDate :: PlainDate -> Date
toDate plainDate =
  Date.canonicalDate
    (unsafePartial fromJust (toEnum (year plainDate)))
    (unsafePartial fromJust (toEnum (month plainDate)))
    (unsafePartial fromJust (toEnum (day plainDate)))

foreign import _toPlainYearMonth :: Fn1 PlainDate PlainYearMonth

-- | Drops the day component.
toPlainYearMonth :: PlainDate -> PlainYearMonth
toPlainYearMonth = Function.Uncurried.runFn1 _toPlainYearMonth

foreign import _toPlainMonthDay :: Fn1 PlainDate PlainMonthDay

-- | Drops the year component.
toPlainMonthDay :: PlainDate -> PlainMonthDay
toPlainMonthDay = Function.Uncurried.runFn1 _toPlainMonthDay

foreign import _toPlainDateTime :: Fn2 PlainTime PlainDate PlainDateTime

-- | Combines a PlainTime with this date to form a PlainDateTime.
toPlainDateTime :: PlainTime -> PlainDate -> PlainDateTime
toPlainDateTime = Function.Uncurried.runFn2 _toPlainDateTime

foreign import _toZonedDateTime :: EffectFn2 String PlainDate ZonedDateTime

-- | Converts to ZonedDateTime at midnight in the given time zone.
toZonedDateTime :: String -> PlainDate -> Effect ZonedDateTime
toZonedDateTime = Effect.Uncurried.runEffectFn2 _toZonedDateTime

-- Serialization (toString_ from Internal)

type ToStringOptions = (calendarName :: String)

data ToToStringOptions = ToToStringOptions

defaultToStringOptions :: { | ToStringOptions }
defaultToStringOptions = Unsafe.Coerce.unsafeCoerce {}

instance ConvertOption ToToStringOptions "calendarName" CalendarName String where
  convertOption _ _ = CalendarName.toString

instance ConvertOption ToToStringOptions "calendarName" String String where
  convertOption _ _ = identity

foreign import _toString :: forall r. Fn2 { | r } PlainDate String

-- | Serializes to ISO 8601 date format. Options: calendarName.
toString
  :: forall provided
   . ConvertOptionsWithDefaults
       ToToStringOptions
       { | ToStringOptions }
       { | provided }
       { | ToStringOptions }
  => { | provided }
  -> PlainDate
  -> String
toString providedOptions plainDate =
  Function.Uncurried.runFn2
    _toString
    ( ConvertableOptions.convertOptionsWithDefaults
        ToToStringOptions
        defaultToStringOptions
        providedOptions
    )
    plainDate

-- Instances (Eq, Ord, Show from Internal)
