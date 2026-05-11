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
  , addWithOptions
  , add
  , calendarId
  , day
  , dayOfWeek
  , dayOfYear
  , daysInMonth
  , daysInWeek
  , daysInYear
  , era
  , eraYear
  , fromWithOptions
  , fromDate
  , fromStringWithOptions
  , fromString
  , from
  , inLeapYear
  , module JS.Temporal.PlainDate.Internal
  , month
  , monthCode
  , monthsInYear
  , sinceWithOptions
  , since
  , subtractWithOptions
  , subtract
  , toDate
  , toPlainDateTime
  , toPlainMonthDay
  , toZonedDateTimeWithPlainTime
  , toZonedDateTime
  , toPlainYearMonth
  , toStringWithOptions
  , toString
  , untilWithOptions
  , until
  , weekOfYear
  , withWithOptions
  , withCalendar
  , with
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

foreign import _fromRecordWithOptions :: forall ro rc. EffectFn2 { | ro } { | rc } PlainDate

-- | Creates a PlainDate from component fields. Options: overflow.
-- |
-- | ```purescript
-- | exampleFromWithOptions :: Effect Unit
-- | exampleFromWithOptions = do
-- |   locale <- JS.Intl.Locale.new_ "en-US"
-- |   date <- PlainDate.fromWithOptions { overflow: Overflow.Constrain } { year: 2024, month: 7, day: 1 }
-- |   formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
-- |   Console.log (JS.Intl.DateTimeFormat.format formatter date)
-- | ```
-- | ---
-- | ```text
-- | July 1, 2024
-- | ```
fromWithOptions
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
fromWithOptions providedOptions components =
  Effect.Uncurried.runEffectFn2
    _fromRecordWithOptions
    ( ConvertableOptions.convertOptionsWithDefaults
        ToOverflowOptions
        defaultOverflowOptions
        providedOptions
    )
    components

foreign import _fromRecord :: forall r. EffectFn1 { | r } PlainDate

-- | Same as [`fromWithOptions`](#v:fromWithOptions) with default options.
-- |
-- | ```purescript
-- | exampleFrom :: Effect Unit
-- | exampleFrom = do
-- |   locale <- JS.Intl.Locale.new_ "en-US"
-- |   date <- PlainDate.from { year: 2024, month: 7, day: 1 }
-- |   formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
-- |   Console.log (JS.Intl.DateTimeFormat.format formatter date)
-- | ```
-- | ---
-- | ```text
-- | July 1, 2024
-- | ```
from
  :: forall provided rest
   . Union provided rest PlainDateComponents
  => { | provided }
  -> Effect PlainDate
from = Effect.Uncurried.runEffectFn1 _fromRecord

foreign import _fromStringWithOptions :: forall r. EffectFn2 { | r } String PlainDate

-- | Creates a PlainDate from an RFC 9557 / ISO 8601 date string (e.g. `"2024-01-15"`).
-- | Options: overflow.
-- |
-- | ```purescript
-- | exampleFromStringWithOptions :: Effect Unit
-- | exampleFromStringWithOptions = do
-- |   date <- PlainDate.fromStringWithOptions { overflow: Overflow.Constrain } "2024-01-15"
-- |   Console.log (PlainDate.toString date)
-- | ```
-- | ---
-- | ```text
-- | 2024-01-15
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
  -> Effect PlainDate
fromStringWithOptions providedOptions str =
  Effect.Uncurried.runEffectFn2
    _fromStringWithOptions
    ( ConvertableOptions.convertOptionsWithDefaults
        ToOverflowOptions
        defaultOverflowOptions
        providedOptions
    )
    str

foreign import _fromString :: EffectFn1 String PlainDate

-- | Same as [`fromStringWithOptions`](#v:fromStringWithOptions) with default options.
-- |
-- | ```purescript
-- | exampleFromString :: Effect Unit
-- | exampleFromString = do
-- |   locale <- JS.Intl.Locale.new_ "en-US"
-- |   date <- PlainDate.fromString "2024-01-15"
-- |   formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
-- |   Console.log (JS.Intl.DateTimeFormat.format formatter date)
-- | ```
-- | ---
-- | ```text
-- | January 15, 2024
-- | ```
fromString :: String -> Effect PlainDate
fromString = Effect.Uncurried.runEffectFn1 _fromString

-- Properties

-- | Calendar year.
-- |
-- | ```purescript
-- | exampleYear :: Effect Unit
-- | exampleYear = do
-- |   date <- PlainDate.fromString "2024-07-01"
-- |   Console.log ("Year: " <> show (PlainDate.year date))
-- | ```
-- | ---
-- | ```text
-- | Year: 2024
-- | ```
foreign import year :: PlainDate -> Int

-- | Calendar month number.
-- |
-- | ```purescript
-- | exampleMonth :: Effect Unit
-- | exampleMonth = do
-- |   date <- PlainDate.fromString "2024-07-01"
-- |   Console.log ("Month: " <> show (PlainDate.month date))
-- | ```
-- | ---
-- | ```text
-- | Month: 7
-- | ```
foreign import month :: PlainDate -> Int

-- | Day of the month.
-- |
-- | ```purescript
-- | exampleDay :: Effect Unit
-- | exampleDay = do
-- |   date <- PlainDate.fromString "2024-07-01"
-- |   Console.log ("Day: " <> show (PlainDate.day date))
-- | ```
-- | ---
-- | ```text
-- | Day: 1
-- | ```
foreign import day :: PlainDate -> Int

-- | Calendar-specific month code (for example `"M01"`).
-- |
-- | ```purescript
-- | exampleMonthCode :: Effect Unit
-- | exampleMonthCode = do
-- |   date <- PlainDate.fromString "2024-07-01"
-- |   Console.log ("Month code: " <> PlainDate.monthCode date)
-- | ```
-- | ---
-- | ```text
-- | Month code: M07
-- | ```
foreign import monthCode :: PlainDate -> String

-- | ISO day of week, from `1` (Monday) to `7` (Sunday).
-- |
-- | ```purescript
-- | exampleDayOfWeek :: Effect Unit
-- | exampleDayOfWeek = do
-- |   date <- PlainDate.fromString "2024-07-01"
-- |   Console.log ("Day of week: " <> show (PlainDate.dayOfWeek date))
-- | ```
-- | ---
-- | ```text
-- | Day of week: 1
-- | ```
foreign import dayOfWeek :: PlainDate -> Int

-- | Day number within the year.
-- |
-- | ```purescript
-- | exampleDayOfYear :: Effect Unit
-- | exampleDayOfYear = do
-- |   date <- PlainDate.fromString "2024-07-01"
-- |   Console.log ("Day of year: " <> show (PlainDate.dayOfYear date))
-- | ```
-- | ---
-- | ```text
-- | Day of year: 183
-- | ```
foreign import dayOfYear :: PlainDate -> Int

-- | Number of days in the current month.
-- |
-- | ```purescript
-- | exampleDaysInMonth :: Effect Unit
-- | exampleDaysInMonth = do
-- |   date <- PlainDate.fromString "2024-02-01"
-- |   Console.log ("Days in Feb 2024: " <> show (PlainDate.daysInMonth date))
-- | ```
-- | ---
-- | ```text
-- | Days in Feb 2024: 29
-- | ```
foreign import daysInMonth :: PlainDate -> Int

-- | Number of days in the current year.
-- |
-- | ```purescript
-- | exampleDaysInYear :: Effect Unit
-- | exampleDaysInYear = do
-- |   date <- PlainDate.fromString "2024-07-01"
-- |   Console.log ("Days in 2024: " <> show (PlainDate.daysInYear date))
-- | ```
-- | ---
-- | ```text
-- | Days in 2024: 366
-- | ```
foreign import daysInYear :: PlainDate -> Int

-- | Number of days in the current week according to the calendar.
-- |
-- | ```purescript
-- | exampleDaysInWeek :: Effect Unit
-- | exampleDaysInWeek = do
-- |   date <- PlainDate.fromString "2024-07-01"
-- |   Console.log ("Days in week: " <> show (PlainDate.daysInWeek date))
-- | ```
-- | ---
-- | ```text
-- | Days in week: 7
-- | ```
foreign import daysInWeek :: PlainDate -> Int

-- | Number of months in the current year.
-- |
-- | ```purescript
-- | exampleMonthsInYear :: Effect Unit
-- | exampleMonthsInYear = do
-- |   date <- PlainDate.fromString "2024-07-01"
-- |   Console.log ("Months in year: " <> show (PlainDate.monthsInYear date))
-- | ```
-- | ---
-- | ```text
-- | Months in year: 12
-- | ```
foreign import monthsInYear :: PlainDate -> Int

-- | Whether the current year is a leap year in this calendar.
-- |
-- | ```purescript
-- | exampleInLeapYear :: Effect Unit
-- | exampleInLeapYear = do
-- |   date <- PlainDate.fromString "2024-07-01"
-- |   Console.log ("2024 is leap year: " <> show (PlainDate.inLeapYear date))
-- | ```
-- | ---
-- | ```text
-- | 2024 is leap year: true
-- | ```
foreign import inLeapYear :: PlainDate -> Boolean

-- | Identifier of the associated calendar (for example `"iso8601"`).
-- |
-- | ```purescript
-- | exampleCalendarId :: Effect Unit
-- | exampleCalendarId = do
-- |   date <- PlainDate.fromString "2024-07-01"
-- |   Console.log ("Calendar: " <> PlainDate.calendarId date)
-- | ```
-- | ---
-- | ```text
-- | Calendar: iso8601
-- | ```
foreign import calendarId :: PlainDate -> String

foreign import _weekOfYear :: PlainDate -> Nullable Int

-- | Week number within the year, if the calendar defines week numbering.
-- |
-- | ```purescript
-- | exampleWeekOfYear :: Effect Unit
-- | exampleWeekOfYear = do
-- |   date <- PlainDate.fromString "2024-07-01"
-- |   Console.log ("Week of year: " <> show (PlainDate.weekOfYear date))
-- | ```
-- | ---
-- | ```text
-- | Week of year: (Just 27)
-- | ```
weekOfYear :: PlainDate -> Maybe Int
weekOfYear = toMaybe <<< _weekOfYear

foreign import _yearOfWeek :: PlainDate -> Nullable Int

-- | Week-numbering year, if the calendar defines week numbering.
-- |
-- | ```purescript
-- | exampleYearOfWeek :: Effect Unit
-- | exampleYearOfWeek = do
-- |   date <- PlainDate.fromString "2024-07-01"
-- |   Console.log ("Year of week: " <> show (PlainDate.yearOfWeek date))
-- | ```
-- | ---
-- | ```text
-- | Year of week: (Just 2024)
-- | ```
yearOfWeek :: PlainDate -> Maybe Int
yearOfWeek = toMaybe <<< _yearOfWeek

foreign import _era :: PlainDate -> Nullable String

-- | Calendar era name, if this calendar uses eras.
-- |
-- | ```purescript
-- | exampleEra :: Effect Unit
-- | exampleEra = do
-- |   date <- PlainDate.fromString "2024-07-01"
-- |   Console.log ("Era: " <> show (PlainDate.era date))
-- | ```
-- | ---
-- | ```text
-- | Era: Nothing
-- | ```
era :: PlainDate -> Maybe String
era = toMaybe <<< _era

foreign import _eraYear :: PlainDate -> Nullable Int

-- | Year number within the current era, if this calendar uses eras.
-- |
-- | ```purescript
-- | exampleEraYear :: Effect Unit
-- | exampleEraYear = do
-- |   date <- PlainDate.fromString "2024-07-01"
-- |   Console.log ("Era year: " <> show (PlainDate.eraYear date))
-- | ```
-- | ---
-- | ```text
-- | Era year: Nothing
-- | ```
eraYear :: PlainDate -> Maybe Int
eraYear = toMaybe <<< _eraYear

-- Arithmetic

foreign import _addWithOptions :: forall r. EffectFn3 { | r } Duration PlainDate PlainDate

-- | Adds a duration to a date. Supports calendar durations. Options: overflow.
-- |
-- | ```purescript
-- | exampleAddWithOptions :: Effect Unit
-- | exampleAddWithOptions = do
-- |   locale <- JS.Intl.Locale.new_ "en-US"
-- |   date <- PlainDate.fromString "2024-03-15"
-- |   oneWeek <- Duration.from { weeks: 1 }
-- |   later <- PlainDate.addWithOptions { overflow: Overflow.Constrain } oneWeek date
-- |   formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
-- |   Console.log (JS.Intl.DateTimeFormat.format formatter later)
-- | ```
-- | ---
-- | ```text
-- | March 22, 2024
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
  -> PlainDate
  -> Effect PlainDate
addWithOptions providedOptions duration plainDate =
  Effect.Uncurried.runEffectFn3
    _addWithOptions
    ( ConvertableOptions.convertOptionsWithDefaults
        ToOverflowOptions
        defaultOverflowOptions
        providedOptions
    )
    duration
    plainDate

foreign import _add :: EffectFn2 Duration PlainDate PlainDate

-- | Same as [`addWithOptions`](#v:addWithOptions) with default options.
-- |
-- | ```purescript
-- | exampleAdd :: Effect Unit
-- | exampleAdd = do
-- |   locale <- JS.Intl.Locale.new_ "en-US"
-- |   date <- PlainDate.fromString "2024-03-15"
-- |   oneWeek <- Duration.from { weeks: 1 }
-- |   later <- PlainDate.add oneWeek date
-- |   formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
-- |   Console.log (JS.Intl.DateTimeFormat.format formatter later)
-- | ```
-- | ---
-- | ```text
-- | March 22, 2024
-- | ```
add :: Duration -> PlainDate -> Effect PlainDate
add = Effect.Uncurried.runEffectFn2 _add

foreign import _subtractWithOptions :: forall r. EffectFn3 { | r } Duration PlainDate PlainDate

-- | Subtracts a duration. Arg order: `subtractWithOptions options duration subject`. Options: overflow.
-- |
-- | ```purescript
-- | exampleSubtractWithOptions :: Effect Unit
-- | exampleSubtractWithOptions = do
-- |   locale <- JS.Intl.Locale.new_ "en-US"
-- |   date <- PlainDate.fromString "2024-03-15"
-- |   oneWeek <- Duration.from { weeks: 1 }
-- |   earlier <- PlainDate.subtractWithOptions { overflow: Overflow.Constrain } oneWeek date
-- |   formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
-- |   Console.log (JS.Intl.DateTimeFormat.format formatter earlier)
-- | ```
-- | ---
-- | ```text
-- | March 8, 2024
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
  -> PlainDate
  -> Effect PlainDate
subtractWithOptions providedOptions duration plainDate =
  Effect.Uncurried.runEffectFn3
    _subtractWithOptions
    ( ConvertableOptions.convertOptionsWithDefaults
        ToOverflowOptions
        defaultOverflowOptions
        providedOptions
    )
    duration
    plainDate

foreign import _subtract :: EffectFn2 Duration PlainDate PlainDate

-- | Same as [`subtractWithOptions`](#v:subtractWithOptions) with default options.
-- |
-- | ```purescript
-- | exampleSubtract :: Effect Unit
-- | exampleSubtract = do
-- |   locale <- JS.Intl.Locale.new_ "en-US"
-- |   date <- PlainDate.fromString "2024-03-15"
-- |   oneWeek <- Duration.from { weeks: 1 }
-- |   earlier <- PlainDate.subtract oneWeek date
-- |   formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
-- |   Console.log (JS.Intl.DateTimeFormat.format formatter earlier)
-- | ```
-- | ---
-- | ```text
-- | March 8, 2024
-- | ```
subtract :: Duration -> PlainDate -> Effect PlainDate
subtract = Effect.Uncurried.runEffectFn2 _subtract

-- Manipulation

type WithFields =
  ( year :: Int
  , month :: Int
  , day :: Int
  , monthCode :: String
  )

foreign import _withWithOptions :: forall ro rf. EffectFn3 { | ro } { | rf } PlainDate PlainDate

-- | Returns a new PlainDate with specified fields replaced. Because PlainDate is
-- | immutable, this is the way to "set" fields. Options: overflow.
-- |
-- | ```purescript
-- | exampleWithWithOptions :: Effect Unit
-- | exampleWithWithOptions = do
-- |   date <- PlainDate.fromString "2021-07-06"
-- |   lastDay <- PlainDate.withWithOptions { overflow: Overflow.Constrain } { day: PlainDate.daysInMonth date } date
-- |   Console.log (PlainDate.toString lastDay)
-- | ```
-- | ---
-- | ```text
-- | 2021-07-31
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
  -> PlainDate
  -> Effect PlainDate
withWithOptions options fields plainDate =
  Effect.Uncurried.runEffectFn3
    _withWithOptions
    ( ConvertableOptions.convertOptionsWithDefaults
        ToOverflowOptions
        defaultOverflowOptions
        options
    )
    fields
    plainDate

foreign import _with :: forall r. EffectFn2 { | r } PlainDate PlainDate

-- | Same as [`withWithOptions`](#v:withWithOptions) with default options.
-- |
-- | ```purescript
-- | exampleWith :: Effect Unit
-- | exampleWith = do
-- |   date <- PlainDate.fromString "2021-07-06"
-- |   lastDay <- PlainDate.with { day: PlainDate.daysInMonth date } date
-- |   Console.log (PlainDate.toString lastDay)
-- | ```
-- | ---
-- | ```text
-- | 2021-07-31
-- | ```
with
  :: forall fields rest
   . Union fields rest WithFields
  => { | fields }
  -> PlainDate
  -> Effect PlainDate
with = Effect.Uncurried.runEffectFn2 _with

foreign import _withCalendar :: EffectFn2 String PlainDate PlainDate

-- | Returns a new PlainDate with the given calendar (for example `"iso8601"`).
-- |
-- | ```purescript
-- | exampleWithCalendar :: Effect Unit
-- | exampleWithCalendar = do
-- |   date <- PlainDate.fromString "2024-01-15"
-- |   gregory <- PlainDate.withCalendar "gregory" date
-- |   Console.log (PlainDate.toStringWithOptions { calendarName: CalendarName.Always } gregory)
-- | ```
-- | ---
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

foreign import _untilWithOptions :: forall r. EffectFn3 { | r } PlainDate PlainDate Duration

-- | Duration from `subject` (last arg) until `other` (second arg). Arg order: `until options other subject`.
-- | Options: largestUnit, smallestUnit, roundingIncrement, roundingMode.
-- |
-- | ```purescript
-- | exampleUntilWithOptions :: Effect Unit
-- | exampleUntilWithOptions = do
-- |   locale <- JS.Intl.Locale.new_ "en-US"
-- |   today <- Now.plainDateISO
-- |   futureDate <- PlainDate.fromString "2026-12-25"
-- |   untilDuration <- PlainDate.untilWithOptions { smallestUnit: TemporalUnit.Day } futureDate today
-- |   formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
-- |   Console.log (JS.Intl.DurationFormat.format formatter untilDuration <> " until Christmas 2026")
-- | ```
-- | ---
-- | ```text
-- | 228 days until Christmas 2026
-- | ```
untilWithOptions
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
untilWithOptions providedOptions other plainDate =
  Effect.Uncurried.runEffectFn3
    _untilWithOptions
    ( ConvertableOptions.convertOptionsWithDefaults
        ToDifferenceOptions
        defaultDifferenceOptions
        providedOptions
    )
    other
    plainDate

foreign import _until :: EffectFn2 PlainDate PlainDate Duration

-- | Same as [`untilWithOptions`](#v:untilWithOptions) with default options.
-- |
-- | ```purescript
-- | exampleUntil :: Effect Unit
-- | exampleUntil = do
-- |   start <- PlainDate.fromString "2024-01-01"
-- |   end <- PlainDate.fromString "2024-03-15"
-- |   duration <- PlainDate.until end start
-- |   Console.log (Duration.toString duration)
-- | ```
-- | ---
-- | ```text
-- | P74D
-- | ```
until :: PlainDate -> PlainDate -> Effect Duration
until = Effect.Uncurried.runEffectFn2 _until

foreign import _sinceWithOptions :: forall r. EffectFn3 { | r } PlainDate PlainDate Duration

-- | Duration from `other` to `subject` (inverse of `untilWithOptions`). Arg order: `since options other subject`.
-- |
-- | ```purescript
-- | exampleSinceWithOptions :: Effect Unit
-- | exampleSinceWithOptions = do
-- |   locale <- JS.Intl.Locale.new_ "en-US"
-- |   start <- PlainDate.fromString "2024-01-01"
-- |   end <- PlainDate.fromString "2024-03-15"
-- |   elapsed <- PlainDate.sinceWithOptions { largestUnit: TemporalUnit.Day } start end
-- |   formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
-- |   Console.log ("Elapsed: " <> JS.Intl.DurationFormat.format formatter elapsed)
-- | ```
-- | ---
-- | ```text
-- | Elapsed: 74 days
-- | ```
sinceWithOptions
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
sinceWithOptions providedOptions other plainDate =
  Effect.Uncurried.runEffectFn3
    _sinceWithOptions
    ( ConvertableOptions.convertOptionsWithDefaults
        ToDifferenceOptions
        defaultDifferenceOptions
        providedOptions
    )
    other
    plainDate

foreign import _since :: EffectFn2 PlainDate PlainDate Duration

-- | Same as [`sinceWithOptions`](#v:sinceWithOptions) with default options.
-- |
-- | ```purescript
-- | exampleSince :: Effect Unit
-- | exampleSince = do
-- |   start <- PlainDate.fromString "2024-01-01"
-- |   end <- PlainDate.fromString "2024-03-15"
-- |   elapsed <- PlainDate.since start end
-- |   Console.log (Duration.toString elapsed)
-- | ```
-- | ---
-- | ```text
-- | P74D
-- | ```
since :: PlainDate -> PlainDate -> Effect Duration
since = Effect.Uncurried.runEffectFn2 _since

-- Conversions

-- | Converts a purescript-datetime `Date` to a `PlainDate`.
-- |
-- | ```purescript
-- | exampleFromDate :: Effect Unit
-- | exampleFromDate = do
-- |   date <- PlainDate.fromString "2024-07-01"
-- |   roundTripped <- PlainDate.fromDate (PlainDate.toDate date)
-- |   Console.log (PlainDate.toString roundTripped)
-- | ```
-- | ---
-- | ```text
-- | 2024-07-01
-- | ```
fromDate :: Date -> Effect PlainDate
fromDate date = from { year: fromEnum (Date.year date), month: fromEnum (Date.month date), day: fromEnum (Date.day date) }

-- | Converts a `PlainDate` to a purescript-datetime `Date`.
-- |
-- | ```purescript
-- | exampleToDate :: Effect Unit
-- | exampleToDate = do
-- |   date <- PlainDate.fromString "2024-07-01"
-- |   let d = PlainDate.toDate date
-- |   Console.log ("PureScript Date year: " <> show (fromEnum (Date.year d)))
-- | ```
-- | ---
-- | ```text
-- | PureScript Date year: 2024
-- | ```
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
-- | exampleToPlainYearMonth :: Effect Unit
-- | exampleToPlainYearMonth = do
-- |   date <- PlainDate.fromString "2024-01-15"
-- |   Console.log (PlainYearMonth.toString (PlainDate.toPlainYearMonth date))
-- | ```
-- | ---
-- | ```text
-- | 2024-01
-- | ```
toPlainYearMonth :: PlainDate -> PlainYearMonth
toPlainYearMonth = Function.Uncurried.runFn1 _toPlainYearMonth

foreign import _toPlainMonthDay :: Fn1 PlainDate PlainMonthDay

-- | Extracts the month and day.
-- |
-- | ```purescript
-- | exampleToPlainMonthDay :: Effect Unit
-- | exampleToPlainMonthDay = do
-- |   date <- PlainDate.fromString "2024-01-15"
-- |   Console.log (PlainMonthDay.toString (PlainDate.toPlainMonthDay date))
-- | ```
-- | ---
-- | ```text
-- | 01-15
-- | ```
toPlainMonthDay :: PlainDate -> PlainMonthDay
toPlainMonthDay = Function.Uncurried.runFn1 _toPlainMonthDay

foreign import _toPlainDateTime :: Fn2 PlainTime PlainDate PlainDateTime

-- | Combines a `PlainTime` with this date to form a `PlainDateTime`.
-- |
-- | ```purescript
-- | exampleToPlainDateTime :: Effect Unit
-- | exampleToPlainDateTime = do
-- |   date <- PlainDate.fromString "2024-01-15"
-- |   time <- PlainTime.fromString "09:30:00"
-- |   Console.log (PlainDateTime.toString (PlainDate.toPlainDateTime time date))
-- | ```
-- | ---
-- | ```text
-- | 2024-01-15T09:30:00
-- | ```
toPlainDateTime :: PlainTime -> PlainDate -> PlainDateTime
toPlainDateTime = Function.Uncurried.runFn2 _toPlainDateTime

foreign import _toZonedDateTimeWithPlainTime :: EffectFn3 String PlainTime PlainDate ZonedDateTime

-- | Converts to a `ZonedDateTime` at the given time in the given time zone.
-- |
-- | ```purescript
-- | exampleToZonedDateTimeWithPlainTime :: Effect Unit
-- | exampleToZonedDateTimeWithPlainTime = do
-- |   date <- PlainDate.fromString "2024-01-15"
-- |   time <- PlainTime.fromString "09:30:00"
-- |   zoned <- PlainDate.toZonedDateTimeWithPlainTime "America/New_York" time date
-- |   Console.log (ZonedDateTime.toString zoned)
-- | ```
-- | ---
-- | ```text
-- | 2024-01-15T09:30:00-05:00[America/New_York]
-- | ```
toZonedDateTimeWithPlainTime :: String -> PlainTime -> PlainDate -> Effect ZonedDateTime
toZonedDateTimeWithPlainTime = Effect.Uncurried.runEffectFn3 _toZonedDateTimeWithPlainTime

foreign import _toZonedDateTime :: EffectFn2 String PlainDate ZonedDateTime

-- | Converts to a `ZonedDateTime` at midnight in the given time zone.
-- |
-- | ```purescript
-- | exampleToZonedDateTime :: Effect Unit
-- | exampleToZonedDateTime = do
-- |   date <- PlainDate.fromString "2024-01-15"
-- |   zoned <- PlainDate.toZonedDateTime "America/New_York" date
-- |   Console.log (ZonedDateTime.toString zoned)
-- | ```
-- | ---
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

-- | Same as [`toStringWithOptions`](#v:toStringWithOptions) with default options.
-- |
-- | ```purescript
-- | exampleToString :: Effect Unit
-- | exampleToString = do
-- |   date <- PlainDate.fromString "2024-01-15"
-- |   Console.log (PlainDate.toString date)
-- | ```
-- | ---
-- | ```text
-- | 2024-01-15
-- | ```
toString :: PlainDate -> String
toString plainDate = Function.Uncurried.runFn2 _toString defaultToStringOptions plainDate

-- | Serializes to ISO 8601 date format. Options: calendarName.
-- |
-- | ```purescript
-- | exampleToStringWithOptions :: Effect Unit
-- | exampleToStringWithOptions = do
-- |   date <- PlainDate.fromString "2024-01-15"
-- |   Console.log (PlainDate.toStringWithOptions { calendarName: CalendarName.Always } date)
-- | ```
-- | ---
-- | ```text
-- | 2024-01-15[u-ca=iso8601]
-- | ```
toStringWithOptions
  :: forall provided
   . ConvertOptionsWithDefaults
       ToToStringOptions
       { | ToStringOptions }
       { | provided }
       { | ToStringOptions }
  => { | provided }
  -> PlainDate
  -> String
toStringWithOptions providedOptions plainDate =
  Function.Uncurried.runFn2
    _toString
    ( ConvertableOptions.convertOptionsWithDefaults
        ToToStringOptions
        defaultToStringOptions
        providedOptions
    )
    plainDate

-- Instances (Eq, Ord, Show from Internal)
