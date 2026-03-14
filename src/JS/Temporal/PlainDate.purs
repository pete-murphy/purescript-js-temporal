-- | A calendar date (year, month, day) without time or time zone. Use for
-- | date-only values (e.g. birthdays, all-day events). Uses ISO 8601 calendar
-- | by default.
-- |
-- | See <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Temporal/PlainDate>
module JS.Temporal.PlainDate
  ( PlainDateComponents
  , ToDifferenceOptions
  , ToOverflowOptions
  , ToToStringOptions
  , add
  , add_
  , calendarId
  , day
  , dayOfWeek
  , dayOfYear
  , daysInMonth
  , daysInWeek
  , daysInYear
  , era
  , eraYear
  , from
  , fromDate
  , fromString
  , fromString_
  , from_
  , inLeapYear
  , module JS.Temporal.PlainDate.Internal
  , month
  , monthCode
  , monthsInYear
  , since
  , since_
  , subtract
  , subtract_
  , toDate
  , toPlainDateTime
  , toPlainMonthDay
  , toZonedDateTime
  , toPlainYearMonth
  , toString
  , toString_
  , until
  , until_
  , weekOfYear
  , with
  , withCalendar
  , with_
  , year
  , yearOfWeek
  ) where

import Prelude hiding (add, compare)

import ConvertableOptions (class ConvertOption, class ConvertOptionsWithDefaults)
import ConvertableOptions as ConvertableOptions
import Data.Date (Date)
import Data.Date as Date
import Data.Enum (fromEnum, toEnum)
import Data.Function.Uncurried (Fn1, Fn2)
import Data.Function.Uncurried as Function.Uncurried
import Data.Maybe (Maybe, fromJust)
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
import JS.Temporal.PlainDateTime.Internal (PlainDateTime)
import JS.Temporal.PlainMonthDay.Internal (PlainMonthDay)
import JS.Temporal.PlainTime.Internal (PlainTime)
import JS.Temporal.PlainYearMonth.Internal (PlainYearMonth)
import JS.Temporal.ZonedDateTime.Internal (ZonedDateTime)
import Partial.Unsafe (unsafePartial)
import Prim.Row (class Union)
import Unsafe.Coerce as Unsafe.Coerce

-- Construction

type PlainDateComponents =
  ( year :: Int
  , month :: Int
  , day :: Int
  )

type OverflowOptions = (overflow :: String)

data ToOverflowOptions = ToOverflowOptions

defaultOverflowOptions :: { | OverflowOptions }
defaultOverflowOptions = Unsafe.Coerce.unsafeCoerce {}

instance ConvertOption ToOverflowOptions "overflow" Overflow String where
  convertOption _ _ = Overflow.toString

instance ConvertOption ToOverflowOptions "overflow" String String where
  convertOption _ _ = identity

foreign import _fromRecord :: forall ro rc. EffectFn2 { | ro } { | rc } PlainDate

-- | Creates a PlainDate from component fields. Options: overflow.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | date <- PlainDate.from { overflow: Overflow.Constrain } { year: 2024, month: 7, day: 1 }
-- | formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
-- | Console.log (JS.Intl.DateTimeFormat.format formatter date)
-- | ```
-- |
-- | ```text
-- | July 1, 2024
-- | ```

from
  :: forall optsProvided provided rest
   . Union provided rest PlainDateComponents
  => ConvertOptionsWithDefaults
       ToOverflowOptions
       { | OverflowOptions }
       { | optsProvided }
       { | OverflowOptions }
  => { | optsProvided }
  -> { | provided }
  -> Effect PlainDate
from providedOptions components =
  Effect.Uncurried.runEffectFn2
    _fromRecord
    ( ConvertableOptions.convertOptionsWithDefaults
        ToOverflowOptions
        defaultOverflowOptions
        providedOptions
    )
    components

foreign import _fromRecordNoOpts :: forall r. EffectFn1 { | r } PlainDate

-- | Same as [`from`](#from) with default options.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | date <- PlainDate.from_ { year: 2024, month: 7, day: 1 }
-- | formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
-- | Console.log (JS.Intl.DateTimeFormat.format formatter date)
-- | ```
-- |
-- | ```text
-- | July 1, 2024
-- | ```

from_
  :: forall provided rest
   . Union provided rest PlainDateComponents
  => { | provided }
  -> Effect PlainDate
from_ = Effect.Uncurried.runEffectFn1 _fromRecordNoOpts

foreign import _fromString :: forall r. EffectFn2 { | r } String PlainDate

-- | Creates a PlainDate from an RFC 9557 / ISO 8601 date string (e.g. `"2024-01-15"`).
-- | Options: overflow.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | date <- PlainDate.fromString { overflow: Overflow.Constrain } "2024-01-15"
-- | formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
-- | Console.log (JS.Intl.DateTimeFormat.format formatter date)
-- | ```
-- |
-- | ```text
-- | January 15, 2024
-- | ```

fromString
  :: forall provided
   . ConvertOptionsWithDefaults
       ToOverflowOptions
       { | OverflowOptions }
       { | provided }
       { | OverflowOptions }
  => { | provided }
  -> String
  -> Effect PlainDate
fromString providedOptions str =
  Effect.Uncurried.runEffectFn2
    _fromString
    ( ConvertableOptions.convertOptionsWithDefaults
        ToOverflowOptions
        defaultOverflowOptions
        providedOptions
    )
    str

foreign import _fromStringNoOpts :: EffectFn1 String PlainDate

-- | Same as [`fromString`](#fromstring) with default options.

fromString_ :: String -> Effect PlainDate
fromString_ = Effect.Uncurried.runEffectFn1 _fromStringNoOpts

-- Properties

-- | Calendar year.
foreign import year :: PlainDate -> Int
-- | Calendar month number.
foreign import month :: PlainDate -> Int
-- | Day of the month.
foreign import day :: PlainDate -> Int
-- | Calendar-specific month code (for example `"M01"`).
foreign import monthCode :: PlainDate -> String
-- | ISO day of week, from `1` (Monday) to `7` (Sunday).
foreign import dayOfWeek :: PlainDate -> Int
-- | Day number within the year.
foreign import dayOfYear :: PlainDate -> Int
-- | Number of days in the current month.
foreign import daysInMonth :: PlainDate -> Int
-- | Number of days in the current year.
foreign import daysInYear :: PlainDate -> Int
-- | Number of days in the current week according to the calendar.
foreign import daysInWeek :: PlainDate -> Int
-- | Number of months in the current year.
foreign import monthsInYear :: PlainDate -> Int
-- | Whether the current year is a leap year in this calendar.
foreign import inLeapYear :: PlainDate -> Boolean
-- | Identifier of the associated calendar (for example `"iso8601"`).
foreign import calendarId :: PlainDate -> String

foreign import _weekOfYear :: PlainDate -> Nullable Int

-- | Week number within the year, if the calendar defines week numbering.
weekOfYear :: PlainDate -> Maybe Int
weekOfYear = toMaybe <<< _weekOfYear

foreign import _yearOfWeek :: PlainDate -> Nullable Int

-- | Week-numbering year, if the calendar defines week numbering.
yearOfWeek :: PlainDate -> Maybe Int
yearOfWeek = toMaybe <<< _yearOfWeek

foreign import _era :: PlainDate -> Nullable String

-- | Calendar era name, if this calendar uses eras.
era :: PlainDate -> Maybe String
era = toMaybe <<< _era

foreign import _eraYear :: PlainDate -> Nullable Int

-- | Year number within the current era, if this calendar uses eras.
eraYear :: PlainDate -> Maybe Int
eraYear = toMaybe <<< _eraYear

-- Arithmetic

foreign import _add :: forall r. EffectFn3 { | r } Duration PlainDate PlainDate

-- | Adds a duration to a date. Supports calendar durations. Options: overflow.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | date <- PlainDate.fromString_ "2024-03-15"
-- | oneWeek <- Duration.from { weeks: 1 }
-- | later <- PlainDate.add { overflow: Overflow.Constrain } oneWeek date
-- | formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
-- | Console.log (JS.Intl.DateTimeFormat.format formatter later)
-- | ```
-- |
-- | ```text
-- | March 22, 2024
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

-- | Same as [`add`](#add) with default options.
add_ :: Duration -> PlainDate -> Effect PlainDate
add_ = Effect.Uncurried.runEffectFn2 _addNoOpts

foreign import _subtract :: forall r. EffectFn3 { | r } Duration PlainDate PlainDate

-- | Subtracts a duration. Arg order: `subtract options duration subject`. Options: overflow.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | date <- PlainDate.fromString_ "2024-03-15"
-- | oneWeek <- Duration.from { weeks: 1 }
-- | earlier <- PlainDate.subtract { overflow: Overflow.Constrain } oneWeek date
-- | formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
-- | Console.log (JS.Intl.DateTimeFormat.format formatter earlier)
-- | ```
-- |
-- | ```text
-- | March 8, 2024
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

-- | Same as [`subtract`](#subtract) with default options.

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

-- | Returns a new PlainDate with specified fields replaced. Because PlainDate is
-- | immutable, this is the way to "set" fields. Options: overflow.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | date <- PlainDate.fromString_ "2021-07-06"
-- | lastDayOfMonth <- PlainDate.with { overflow: Overflow.Constrain } { day: PlainDate.daysInMonth date } date
-- | formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
-- | Console.log (JS.Intl.DateTimeFormat.format formatter lastDayOfMonth)
-- | ```
-- |
-- | ```text
-- | July 31, 2021
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

-- | Same as [`with`](#with) with default options.

with_
  :: forall fields rest
   . Union fields rest WithFields
  => { | fields }
  -> PlainDate
  -> Effect PlainDate
with_ = Effect.Uncurried.runEffectFn2 _withNoOpts

foreign import _withCalendar :: EffectFn2 String PlainDate PlainDate

-- | Returns a new PlainDate with the given calendar (for example `"iso8601"`).
-- |
-- | ```purescript
-- | date <- PlainDate.fromString_ "2024-01-15"
-- | gregory <- PlainDate.withCalendar "gregory" date
-- | Console.log (PlainDate.toString { calendarName: CalendarName.Always } gregory)
-- | ```
-- |
-- | ```text
-- | 2024-01-15[u-ca=gregory]
-- | ```

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

-- | Duration from `subject` (last arg) until `other` (second arg). Arg order: `until options other subject`.
-- | Options: largestUnit, smallestUnit, roundingIncrement, roundingMode.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | today <- Now.plainDateISO_
-- | futureDate <- PlainDate.fromString_ "2026-12-25"
-- | untilDuration <- PlainDate.until { smallestUnit: TemporalUnit.Day } futureDate today
-- | formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
-- | Console.log (JS.Intl.DurationFormat.format formatter untilDuration <> " until Christmas 2026")
-- | ```
-- |
-- | ```text
-- | 286 days until Christmas 2026
-- | ```

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

-- | Same as [`until`](#until) with default options.

until_ :: PlainDate -> PlainDate -> Effect Duration
until_ = Effect.Uncurried.runEffectFn2 _untilNoOpts

foreign import _since :: forall r. EffectFn3 { | r } PlainDate PlainDate Duration

-- | Duration from `other` to `subject` (inverse of until). Arg order: `since options other subject`.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | start <- PlainDate.fromString_ "2024-01-01"
-- | end <- PlainDate.fromString_ "2024-03-15"
-- | elapsed <- PlainDate.since { largestUnit: TemporalUnit.Day } start end
-- | formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
-- | Console.log ("Elapsed: " <> JS.Intl.DurationFormat.format formatter elapsed)
-- | ```
-- |
-- | ```text
-- | Elapsed: 74 days
-- | ```

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

-- | Same as [`since`](#since) with default options.

since_ :: PlainDate -> PlainDate -> Effect Duration
since_ = Effect.Uncurried.runEffectFn2 _sinceNoOpts

-- Conversions

-- | Converts a purescript-datetime `Date` to a `PlainDate`.
fromDate :: Date -> Effect PlainDate
fromDate date = from_ { year: fromEnum (Date.year date), month: fromEnum (Date.month date), day: fromEnum (Date.day date) }

-- | Converts a `PlainDate` to a purescript-datetime `Date`.
toDate :: PlainDate -> Date
toDate plainDate =
  Date.canonicalDate
    (unsafePartial fromJust (toEnum (year plainDate)))
    (unsafePartial fromJust (toEnum (month plainDate)))
    (unsafePartial fromJust (toEnum (day plainDate)))

foreign import _toPlainYearMonth :: Fn1 PlainDate PlainYearMonth

-- | Extracts the year and month.
-- |
-- | ```purescript
-- | date <- PlainDate.fromString_ "2024-01-15"
-- | Console.log (PlainYearMonth.toString_ (PlainDate.toPlainYearMonth date))
-- | ```
-- |
-- | ```text
-- | 2024-01
-- | ```

toPlainYearMonth :: PlainDate -> PlainYearMonth
toPlainYearMonth = Function.Uncurried.runFn1 _toPlainYearMonth

foreign import _toPlainMonthDay :: Fn1 PlainDate PlainMonthDay

-- | Extracts the month and day.
-- |
-- | ```purescript
-- | date <- PlainDate.fromString_ "2024-01-15"
-- | Console.log (PlainMonthDay.toString_ (PlainDate.toPlainMonthDay date))
-- | ```
-- |
-- | ```text
-- | 01-15
-- | ```

toPlainMonthDay :: PlainDate -> PlainMonthDay
toPlainMonthDay = Function.Uncurried.runFn1 _toPlainMonthDay

foreign import _toPlainDateTime :: Fn2 PlainTime PlainDate PlainDateTime

-- | Combines a `PlainTime` with this date to form a `PlainDateTime`.
-- |
-- | ```purescript
-- | date <- PlainDate.fromString_ "2024-01-15"
-- | time <- PlainTime.fromString_ "09:30:00"
-- | Console.log (PlainDateTime.toString_ (PlainDate.toPlainDateTime time date))
-- | ```
-- |
-- | ```text
-- | 2024-01-15T09:30:00
-- | ```

toPlainDateTime :: PlainTime -> PlainDate -> PlainDateTime
toPlainDateTime = Function.Uncurried.runFn2 _toPlainDateTime

foreign import _toZonedDateTime :: EffectFn2 String PlainDate ZonedDateTime

-- | Converts to a `ZonedDateTime` at midnight in the given time zone.
-- |
-- | ```purescript
-- | date <- PlainDate.fromString_ "2024-01-15"
-- | zoned <- PlainDate.toZonedDateTime "America/New_York" date
-- | Console.log (ZonedDateTime.toString_ zoned)
-- | ```
-- |
-- | ```text
-- | 2024-01-15T00:00:00-05:00[America/New_York]
-- | ```

toZonedDateTime :: String -> PlainDate -> Effect ZonedDateTime
toZonedDateTime = Effect.Uncurried.runEffectFn2 _toZonedDateTime

-- Serialization

type ToStringOptions = (calendarName :: String)

data ToToStringOptions = ToToStringOptions

defaultToStringOptions :: { | ToStringOptions }
defaultToStringOptions = Unsafe.Coerce.unsafeCoerce {}

instance ConvertOption ToToStringOptions "calendarName" CalendarName String where
  convertOption _ _ = CalendarName.toString

instance ConvertOption ToToStringOptions "calendarName" String String where
  convertOption _ _ = identity

foreign import _toString :: forall r. Fn2 { | r } PlainDate String

-- | Same as [`toString`](#tostring) with default options.
toString_ :: PlainDate -> String
toString_ plainDate = Function.Uncurried.runFn2 _toString defaultToStringOptions plainDate

-- | Serializes to ISO 8601 date format. Options: calendarName.
-- |
-- | ```purescript
-- | date <- PlainDate.fromString_ "2024-01-15"
-- | Console.log (PlainDate.toString { calendarName: CalendarName.Never } date)
-- | ```
-- |
-- | ```text
-- | 2024-01-15
-- | ```

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
