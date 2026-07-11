-- | A date and time (year, month, day, hour, minute, etc.) without time zone.
-- | Use for wall-clock times that are not tied to a specific instant (e.g. "Jan 15,
-- | 2024 at 3pm"). Combine with a time zone to get a ZonedDateTime.
-- |
-- | See <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Temporal/PlainDateTime>
module JS.Temporal.PlainDateTime
  ( module JS.Temporal.PlainDateTime.Internal
  -- * Construction
  , PlainDateTimeComponents
  , fromWithOptions
  , from
  , fromStringWithOptions
  , fromString
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
  , hour
  , minute
  , second
  , millisecond
  , microsecond
  , nanosecond
  -- * Arithmetic
  , addWithOptions
  , add
  , subtractWithOptions
  , subtract
  -- * Manipulation
  , withWithOptions
  , with
  , withPlainTime
  , withCalendar
  -- * Difference
  , untilWithOptions
  , until
  , sinceWithOptions
  , since
  -- * Round
  , round
  -- * Serialization
  , toStringWithOptions
  , toString
  -- * Conversions
  , toPlainDate
  , toPlainTime
  , toZonedDateTime
  -- * Options
  , ToOverflowOptions
  , ToDifferenceOptions
  , ToRoundOptions
  , ToToStringOptions
  ) where

import Prelude hiding (add, compare)

import ConvertableOptions (class ConvertOption, class ConvertOptionsWithDefaults)
import ConvertableOptions as ConvertableOptions
import Data.Function.Uncurried (Fn1, Fn2)
import Data.Function.Uncurried as Function.Uncurried
import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import Effect (Effect)
import Effect.Uncurried (EffectFn1, EffectFn2, EffectFn3)
import Effect.Uncurried as Effect.Uncurried
import Foreign (Foreign)
import Foreign as Foreign
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
import JS.Temporal.PlainTime.Internal (PlainTime)
import JS.Temporal.ZonedDateTime.Internal (ZonedDateTime)
import Prim.Row (class Union)
import Unsafe.Coerce as Unsafe.Coerce

-- Construction

type PlainDateTimeComponents =
  ( year :: Int
  , month :: Int
  , day :: Int
  , hour :: Int
  , minute :: Int
  , second :: Int
  , millisecond :: Int
  , microsecond :: Int
  , nanosecond :: Int
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

foreign import _fromRecordWithOptions :: forall ro rc. EffectFn2 { | ro } { | rc } PlainDateTime

-- | Creates a PlainDateTime from component fields. Options: overflow.
-- |
-- | ```purescript
-- | exampleFromWithOptions :: Effect Unit
-- | exampleFromWithOptions = do
-- |   locale <- JS.Intl.Locale.new_ "en-US"
-- |   dateTime <- PlainDateTime.fromWithOptions { overflow: Overflow.Constrain }
-- |     { year: 2024, month: 1, day: 15, hour: 9, minute: 30, second: 0 }
-- |   formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
-- |   Console.log (JS.Intl.DateTimeFormat.format formatter dateTime)
-- | ```
-- | ---
-- | ```text
-- | January 15, 2024 at 9:30:00 AM
-- | ```
fromWithOptions
  :: forall optsProvided provided rest
   . Union provided rest PlainDateTimeComponents
  => ConvertOptionsWithDefaults
       ToOverflowOptions
       { | OverflowOptions }
       { | optsProvided }
       { | OverflowOptions }
  => { | optsProvided }
  -> { | provided }
  -> Effect PlainDateTime
fromWithOptions providedOptions components =
  Effect.Uncurried.runEffectFn2
    _fromRecordWithOptions
    ( ConvertableOptions.convertOptionsWithDefaults
        ToOverflowOptions
        defaultOverflowOptions
        providedOptions
    )
    components

foreign import _fromRecord :: forall r. EffectFn1 { | r } PlainDateTime

-- | Same as [`fromWithOptions`](#v:fromWithOptions) withWithOptions default options.
-- |
-- | ```purescript
-- | exampleFrom :: Effect Unit
-- | exampleFrom = do
-- |   locale <- JS.Intl.Locale.new_ "en-US"
-- |   dateTime <- PlainDateTime.from
-- |     { year: 2024, month: 1, day: 15, hour: 9, minute: 30, second: 0 }
-- |   formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
-- |   Console.log (JS.Intl.DateTimeFormat.format formatter dateTime)
-- | ```
-- | ---
-- | ```text
-- | January 15, 2024 at 9:30:00 AM
-- | ```
from
  :: forall provided rest
   . Union provided rest PlainDateTimeComponents
  => { | provided }
  -> Effect PlainDateTime
from = Effect.Uncurried.runEffectFn1 _fromRecord

foreign import _fromStringWithOptions :: forall r. EffectFn2 { | r } String PlainDateTime

-- | Parses a date-time string (e.g. `"2024-01-15T15:30:00"`). Options: overflow.
-- |
-- | ```purescript
-- | exampleFromStringWithOptions :: Effect Unit
-- | exampleFromStringWithOptions = do
-- |   dateTime <- PlainDateTime.fromStringWithOptions { overflow: Overflow.Constrain } "2024-01-15T09:30:00"
-- |   Console.log (PlainDateTime.toString dateTime)
-- | ```
-- | ---
-- | ```text
-- | 2024-01-15T09:30:00
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
  -> Effect PlainDateTime
fromStringWithOptions providedOptions str =
  Effect.Uncurried.runEffectFn2
    _fromStringWithOptions
    ( ConvertableOptions.convertOptionsWithDefaults
        ToOverflowOptions
        defaultOverflowOptions
        providedOptions
    )
    str

foreign import _fromString :: EffectFn1 String PlainDateTime

-- | Same as [`fromStringWithOptions`](#v:fromStringWithOptions) withWithOptions default options.
-- |
-- | ```purescript
-- | exampleFromString :: Effect Unit
-- | exampleFromString = do
-- |   locale <- JS.Intl.Locale.new_ "en-US"
-- |   dateTime <- PlainDateTime.fromString "2024-01-15T09:30:00"
-- |   formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
-- |   Console.log (JS.Intl.DateTimeFormat.format formatter dateTime)
-- | ```
-- | ---
-- | ```text
-- | January 15, 2024 at 9:30:00 AM
-- | ```
fromString :: String -> Effect PlainDateTime
fromString = Effect.Uncurried.runEffectFn1 _fromString

-- Properties

-- | ISO calendar year number.
-- |
-- | ```purescript
-- | exampleYear :: Effect Unit
-- | exampleYear = do
-- |   dt <- PlainDateTime.fromString "2024-07-01T09:30:00"
-- |   Console.log ("Year: " <> show (PlainDateTime.year dt))
-- | ```
-- | ---
-- | ```text
-- | Year: 2024
-- | ```
foreign import year :: PlainDateTime -> Int

-- | Month number within the year.
-- |
-- | ```purescript
-- | exampleMonth :: Effect Unit
-- | exampleMonth = do
-- |   dt <- PlainDateTime.fromString "2024-07-01T09:30:00"
-- |   Console.log ("Month: " <> show (PlainDateTime.month dt))
-- | ```
-- | ---
-- | ```text
-- | Month: 7
-- | ```
foreign import month :: PlainDateTime -> Int

-- | Day of the month.
-- |
-- | ```purescript
-- | exampleDay :: Effect Unit
-- | exampleDay = do
-- |   dt <- PlainDateTime.fromString "2024-07-01T09:30:00"
-- |   Console.log ("Day: " <> show (PlainDateTime.day dt))
-- | ```
-- | ---
-- | ```text
-- | Day: 1
-- | ```
foreign import day :: PlainDateTime -> Int

-- | Calendar-specific month code, such as `M01`.
-- |
-- | ```purescript
-- | exampleMonthCode :: Effect Unit
-- | exampleMonthCode = do
-- |   dt <- PlainDateTime.fromString "2024-07-01T09:30:00"
-- |   Console.log ("Month code: " <> PlainDateTime.monthCode dt)
-- | ```
-- | ---
-- | ```text
-- | Month code: M07
-- | ```
foreign import monthCode :: PlainDateTime -> String

-- | Day of the week, from `1` (Monday) to `7` (Sunday).
-- |
-- | ```purescript
-- | exampleDayOfWeek :: Effect Unit
-- | exampleDayOfWeek = do
-- |   dt <- PlainDateTime.fromString "2024-07-01T09:30:00"
-- |   Console.log ("Day of week: " <> show (PlainDateTime.dayOfWeek dt))
-- | ```
-- | ---
-- | ```text
-- | Day of week: 1
-- | ```
foreign import dayOfWeek :: PlainDateTime -> Int

-- | Day number within the year.
-- |
-- | ```purescript
-- | exampleDayOfYear :: Effect Unit
-- | exampleDayOfYear = do
-- |   dt <- PlainDateTime.fromString "2024-07-01T09:30:00"
-- |   Console.log ("Day of year: " <> show (PlainDateTime.dayOfYear dt))
-- | ```
-- | ---
-- | ```text
-- | Day of year: 183
-- | ```
foreign import dayOfYear :: PlainDateTime -> Int

-- | Number of days in the month.
-- |
-- | ```purescript
-- | exampleDaysInMonth :: Effect Unit
-- | exampleDaysInMonth = do
-- |   dt <- PlainDateTime.fromString "2024-02-01T00:00:00"
-- |   Console.log ("Days in Feb 2024: " <> show (PlainDateTime.daysInMonth dt))
-- | ```
-- | ---
-- | ```text
-- | Days in Feb 2024: 29
-- | ```
foreign import daysInMonth :: PlainDateTime -> Int

-- | Number of days in the year.
-- |
-- | ```purescript
-- | exampleDaysInYear :: Effect Unit
-- | exampleDaysInYear = do
-- |   dt <- PlainDateTime.fromString "2024-07-01T00:00:00"
-- |   Console.log ("Days in 2024: " <> show (PlainDateTime.daysInYear dt))
-- | ```
-- | ---
-- | ```text
-- | Days in 2024: 366
-- | ```
foreign import daysInYear :: PlainDateTime -> Int

-- | Number of days in the week for this calendar.
-- |
-- | ```purescript
-- | exampleDaysInWeek :: Effect Unit
-- | exampleDaysInWeek = do
-- |   dt <- PlainDateTime.fromString "2024-07-01T00:00:00"
-- |   Console.log ("Days in week: " <> show (PlainDateTime.daysInWeek dt))
-- | ```
-- | ---
-- | ```text
-- | Days in week: 7
-- | ```
foreign import daysInWeek :: PlainDateTime -> Int

-- | Number of months in the year for this calendar.
-- |
-- | ```purescript
-- | exampleMonthsInYear :: Effect Unit
-- | exampleMonthsInYear = do
-- |   dt <- PlainDateTime.fromString "2024-07-01T00:00:00"
-- |   Console.log ("Months in year: " <> show (PlainDateTime.monthsInYear dt))
-- | ```
-- | ---
-- | ```text
-- | Months in year: 12
-- | ```
foreign import monthsInYear :: PlainDateTime -> Int

-- | Whether the year is a leap year in this calendar.
-- |
-- | ```purescript
-- | exampleInLeapYear :: Effect Unit
-- | exampleInLeapYear = do
-- |   dt <- PlainDateTime.fromString "2024-07-01T00:00:00"
-- |   Console.log ("2024 is leap year: " <> show (PlainDateTime.inLeapYear dt))
-- | ```
-- | ---
-- | ```text
-- | 2024 is leap year: true
-- | ```
foreign import inLeapYear :: PlainDateTime -> Boolean

-- | Calendar identifier, such as `"iso8601"`.
-- |
-- | ```purescript
-- | exampleCalendarId :: Effect Unit
-- | exampleCalendarId = do
-- |   dt <- PlainDateTime.fromString "2024-07-01T00:00:00"
-- |   Console.log ("Calendar: " <> PlainDateTime.calendarId dt)
-- | ```
-- | ---
-- | ```text
-- | Calendar: iso8601
-- | ```
foreign import calendarId :: PlainDateTime -> String

foreign import _weekOfYear :: PlainDateTime -> Nullable Int

-- | Week number within the year when defined by the calendar.
-- |
-- | ```purescript
-- | exampleWeekOfYear :: Effect Unit
-- | exampleWeekOfYear = do
-- |   dt <- PlainDateTime.fromString "2024-07-01T09:30:00"
-- |   Console.log ("Week of year: " <> show (PlainDateTime.weekOfYear dt))
-- | ```
-- | ---
-- | ```text
-- | Week of year: (Just 27)
-- | ```
weekOfYear :: PlainDateTime -> Maybe Int
weekOfYear = toMaybe <<< _weekOfYear

foreign import _yearOfWeek :: PlainDateTime -> Nullable Int

-- | Week-numbering year when defined by the calendar.
-- |
-- | ```purescript
-- | exampleYearOfWeek :: Effect Unit
-- | exampleYearOfWeek = do
-- |   dt <- PlainDateTime.fromString "2024-07-01T09:30:00"
-- |   Console.log ("Year of week: " <> show (PlainDateTime.yearOfWeek dt))
-- | ```
-- | ---
-- | ```text
-- | Year of week: (Just 2024)
-- | ```
yearOfWeek :: PlainDateTime -> Maybe Int
yearOfWeek = toMaybe <<< _yearOfWeek

foreign import _era :: PlainDateTime -> Nullable String

-- | Era identifier when the calendar uses eras.
-- |
-- | ```purescript
-- | exampleEra :: Effect Unit
-- | exampleEra = do
-- |   dt <- PlainDateTime.fromString "2024-07-01T00:00:00"
-- |   Console.log ("Era: " <> show (PlainDateTime.era dt))
-- | ```
-- | ---
-- | ```text
-- | Era: Nothing
-- | ```
era :: PlainDateTime -> Maybe String
era = toMaybe <<< _era

foreign import _eraYear :: PlainDateTime -> Nullable Int

-- | Year number within the current era when available.
-- |
-- | ```purescript
-- | exampleEraYear :: Effect Unit
-- | exampleEraYear = do
-- |   dt <- PlainDateTime.fromString "2024-07-01T00:00:00"
-- |   Console.log ("Era year: " <> show (PlainDateTime.eraYear dt))
-- | ```
-- | ---
-- | ```text
-- | Era year: Nothing
-- | ```
eraYear :: PlainDateTime -> Maybe Int
eraYear = toMaybe <<< _eraYear

-- | Hour component.
-- |
-- | ```purescript
-- | exampleHour :: Effect Unit
-- | exampleHour = do
-- |   dt <- PlainDateTime.fromString "2024-07-01T14:30:45"
-- |   Console.log ("Hour: " <> show (PlainDateTime.hour dt))
-- | ```
-- | ---
-- | ```text
-- | Hour: 14
-- | ```
foreign import hour :: PlainDateTime -> Int

-- | Minute component.
-- |
-- | ```purescript
-- | exampleMinute :: Effect Unit
-- | exampleMinute = do
-- |   dt <- PlainDateTime.fromString "2024-07-01T14:30:45"
-- |   Console.log ("Minute: " <> show (PlainDateTime.minute dt))
-- | ```
-- | ---
-- | ```text
-- | Minute: 30
-- | ```
foreign import minute :: PlainDateTime -> Int

-- | Second component.
-- |
-- | ```purescript
-- | exampleSecond :: Effect Unit
-- | exampleSecond = do
-- |   dt <- PlainDateTime.fromString "2024-07-01T14:30:45"
-- |   Console.log ("Second: " <> show (PlainDateTime.second dt))
-- | ```
-- | ---
-- | ```text
-- | Second: 45
-- | ```
foreign import second :: PlainDateTime -> Int

-- | Millisecond component.
-- |
-- | ```purescript
-- | exampleMillisecond :: Effect Unit
-- | exampleMillisecond = do
-- |   dt <- PlainDateTime.fromString "2024-07-01T14:30:45.123"
-- |   Console.log ("Millisecond: " <> show (PlainDateTime.millisecond dt))
-- | ```
-- | ---
-- | ```text
-- | Millisecond: 123
-- | ```
foreign import millisecond :: PlainDateTime -> Int

-- | Microsecond component.
-- |
-- | ```purescript
-- | exampleMicrosecond :: Effect Unit
-- | exampleMicrosecond = do
-- |   dt <- PlainDateTime.fromString "2024-07-01T14:30:45.123456"
-- |   Console.log ("Microsecond: " <> show (PlainDateTime.microsecond dt))
-- | ```
-- | ---
-- | ```text
-- | Microsecond: 456
-- | ```
foreign import microsecond :: PlainDateTime -> Int

-- | Nanosecond component.
-- |
-- | ```purescript
-- | exampleNanosecond :: Effect Unit
-- | exampleNanosecond = do
-- |   dt <- PlainDateTime.fromString "2024-07-01T14:30:45.123456789"
-- |   Console.log ("Nanosecond: " <> show (PlainDateTime.nanosecond dt))
-- | ```
-- | ---
-- | ```text
-- | Nanosecond: 789
-- | ```
foreign import nanosecond :: PlainDateTime -> Int

-- Arithmetic

foreign import _addWithOptions :: forall r. EffectFn3 { | r } Duration PlainDateTime PlainDateTime

-- | Adds a duration. Arg order: `addWithOptions options duration subject`. Options: overflow.
-- |
-- | ```purescript
-- | exampleAddWithOptions :: Effect Unit
-- | exampleAddWithOptions = do
-- |   start <- PlainDateTime.fromString "2024-01-15T09:00:00"
-- |   twoHours <- Duration.from { hours: 2 }
-- |   end <- PlainDateTime.addWithOptions { overflow: Overflow.Constrain } twoHours start
-- |   Console.log (PlainDateTime.toString end)
-- | ```
-- | ---
-- | ```text
-- | 2024-01-15T11:00:00
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
  -> PlainDateTime
  -> Effect PlainDateTime
addWithOptions providedOptions duration plainDateTime =
  Effect.Uncurried.runEffectFn3
    _addWithOptions
    ( ConvertableOptions.convertOptionsWithDefaults
        ToOverflowOptions
        defaultOverflowOptions
        providedOptions
    )
    duration
    plainDateTime

foreign import _add :: EffectFn2 Duration PlainDateTime PlainDateTime

-- | Same as [`addWithOptions`](#v:addWithOptions) with default options.
-- |
-- | ```purescript
-- | exampleAdd :: Effect Unit
-- | exampleAdd = do
-- |   start <- PlainDateTime.fromString "2024-01-15T09:00:00"
-- |   twoHours <- Duration.from { hours: 2 }
-- |   end <- PlainDateTime.add twoHours start
-- |   Console.log (PlainDateTime.toString end)
-- | ```
-- | ---
-- | ```text
-- | 2024-01-15T11:00:00
-- | ```
add :: Duration -> PlainDateTime -> Effect PlainDateTime
add = Effect.Uncurried.runEffectFn2 _add

foreign import _subtractWithOptions :: forall r. EffectFn3 { | r } Duration PlainDateTime PlainDateTime

-- | Subtracts a duration. Arg order: `subtractWithOptions options duration subject` (subject minus duration).
-- | Options: overflow.
-- |
-- | ```purescript
-- | exampleSubtractWithOptions :: Effect Unit
-- | exampleSubtractWithOptions = do
-- |   start <- PlainDateTime.fromString "2024-01-15T11:00:00"
-- |   twoHours <- Duration.from { hours: 2 }
-- |   earlier <- PlainDateTime.subtractWithOptions { overflow: Overflow.Constrain } twoHours start
-- |   Console.log (PlainDateTime.toString earlier)
-- | ```
-- | ---
-- | ```text
-- | 2024-01-15T09:00:00
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
  -> PlainDateTime
  -> Effect PlainDateTime
subtractWithOptions providedOptions duration plainDateTime =
  Effect.Uncurried.runEffectFn3
    _subtractWithOptions
    ( ConvertableOptions.convertOptionsWithDefaults
        ToOverflowOptions
        defaultOverflowOptions
        providedOptions
    )
    duration
    plainDateTime

foreign import _subtract :: EffectFn2 Duration PlainDateTime PlainDateTime

-- | Same as [`subtractWithOptions`](#v:subtractWithOptions) with default options.
-- |
-- | ```purescript
-- | exampleSubtract :: Effect Unit
-- | exampleSubtract = do
-- |   start <- PlainDateTime.fromString "2024-01-15T11:00:00"
-- |   twoHours <- Duration.from { hours: 2 }
-- |   earlier <- PlainDateTime.subtract twoHours start
-- |   Console.log (PlainDateTime.toString earlier)
-- | ```
-- | ---
-- | ```text
-- | 2024-01-15T09:00:00
-- | ```
subtract :: Duration -> PlainDateTime -> Effect PlainDateTime
subtract = Effect.Uncurried.runEffectFn2 _subtract

-- Manipulation

type WithFields =
  ( year :: Int
  , month :: Int
  , day :: Int
  , monthCode :: String
  , hour :: Int
  , minute :: Int
  , second :: Int
  , millisecond :: Int
  , microsecond :: Int
  , nanosecond :: Int
  )

foreign import _withWithOptions :: forall ro rf. EffectFn3 { | ro } { | rf } PlainDateTime PlainDateTime

-- | Returns a new PlainDateTime with specified fields replaced. Options: overflow.
-- |
-- | ```purescript
-- | exampleWithWithOptions :: Effect Unit
-- | exampleWithWithOptions = do
-- |   dateTime <- PlainDateTime.fromString "2024-01-15T09:30:45"
-- |   noon <- PlainDateTime.withWithOptions { overflow: Overflow.Constrain } { hour: 12, minute: 0, second: 0 } dateTime
-- |   Console.log (PlainDateTime.toString noon)
-- | ```
-- | ---
-- | ```text
-- | 2024-01-15T12:00:00
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
  -> PlainDateTime
  -> Effect PlainDateTime
withWithOptions options fields plainDateTime =
  Effect.Uncurried.runEffectFn3
    _withWithOptions
    ( ConvertableOptions.convertOptionsWithDefaults
        ToOverflowOptions
        defaultOverflowOptions
        options
    )
    fields
    plainDateTime

foreign import _with :: forall r. EffectFn2 { | r } PlainDateTime PlainDateTime

-- | Same as [`withWithOptions`](#v:withWithOptions) with default options.
-- |
-- | ```purescript
-- | exampleWith :: Effect Unit
-- | exampleWith = do
-- |   dateTime <- PlainDateTime.fromString "2024-01-15T09:30:45"
-- |   noon <- PlainDateTime.with { hour: 12, minute: 0, second: 0 } dateTime
-- |   Console.log (PlainDateTime.toString noon)
-- | ```
-- | ---
-- | ```text
-- | 2024-01-15T12:00:00
-- | ```
with
  :: forall fields rest
   . Union fields rest WithFields
  => { | fields }
  -> PlainDateTime
  -> Effect PlainDateTime
with = Effect.Uncurried.runEffectFn2 _with

foreign import _withPlainTime :: EffectFn2 PlainTime PlainDateTime PlainDateTime

-- | Returns a new PlainDateTime with the time component replaced.
-- |
-- | ```purescript
-- | exampleWithPlainTime :: Effect Unit
-- | exampleWithPlainTime = do
-- |   dateTime <- PlainDateTime.fromString "2024-01-15T09:30:00"
-- |   closingTime <- PlainTime.fromString "17:00:00"
-- |   updated <- PlainDateTime.withPlainTime closingTime dateTime
-- |   Console.log (PlainDateTime.toString updated)
-- | ```
-- | ---
-- | ```text
-- | 2024-01-15T17:00:00
-- | ```
withPlainTime :: PlainTime -> PlainDateTime -> Effect PlainDateTime
withPlainTime = Effect.Uncurried.runEffectFn2 _withPlainTime

foreign import _withCalendar :: EffectFn2 String PlainDateTime PlainDateTime

-- | Returns a new PlainDateTime that uses a different calendar.
-- |
-- | ```purescript
-- | exampleWithCalendar :: Effect Unit
-- | exampleWithCalendar = do
-- |   dateTime <- PlainDateTime.fromString "2019-05-01T09:30:00"
-- |   japanese <- PlainDateTime.withCalendar "japanese" dateTime
-- |   Console.log (PlainDateTime.calendarId japanese)
-- | ```
-- | ---
-- | ```text
-- | japanese
-- | ```
withCalendar :: String -> PlainDateTime -> Effect PlainDateTime
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

foreign import _untilWithOptions :: forall r. EffectFn3 { | r } PlainDateTime PlainDateTime Duration

-- | Computes the duration from `subject` (last arg) until `other` (second arg).
-- | Positive when `other` is later. Arg order: `untilWithOptions options other subject`.
-- |
-- | Options: largestUnit, smallestUnit, roundingIncrement, roundingMode.
-- |
-- | ```purescript
-- | exampleUntilWithOptions :: Effect Unit
-- | exampleUntilWithOptions = do
-- |   locale <- JS.Intl.Locale.new_ "en-US"
-- |   now <- Now.plainDateTimeISO
-- |     >>= PlainDateTime.round { smallestUnit: TemporalUnit.Second }
-- |   nextBilling <- do
-- |     aprilFirst <- PlainDateTime.from
-- |       { year: PlainDateTime.year now, month: 4, day: 1 }
-- |     if aprilFirst < now then do
-- |       oneYear <- Duration.from { years: 1 }
-- |       PlainDateTime.add oneYear aprilFirst
-- |     else
-- |       pure aprilFirst
-- |   duration <- PlainDateTime.untilWithOptions
-- |     { smallestUnit: TemporalUnit.Day }
-- |     nextBilling
-- |     now
-- |   durationFormatter <- JS.Intl.DurationFormat.new [ locale ] { style: JS.Intl.Options.DurationFormatStyle.Long }
-- |   Console.log (JS.Intl.DurationFormat.format durationFormatter duration <> " until next billing")
-- | ```
-- | ---
-- | ```text
-- | 263 days until next billing
-- | ```
untilWithOptions
  :: forall provided
   . ConvertOptionsWithDefaults
       ToDifferenceOptions
       { | DifferenceOptions }
       { | provided }
       { | DifferenceOptions }
  => { | provided }
  -> PlainDateTime
  -> PlainDateTime
  -> Effect Duration
untilWithOptions providedOptions other plainDateTime =
  Effect.Uncurried.runEffectFn3
    _untilWithOptions
    ( ConvertableOptions.convertOptionsWithDefaults
        ToDifferenceOptions
        defaultDifferenceOptions
        providedOptions
    )
    other
    plainDateTime

foreign import _until :: EffectFn2 PlainDateTime PlainDateTime Duration

-- | Same as [`untilWithOptions`](#v:untilWithOptions) with default options.
-- |
-- | ```purescript
-- | exampleUntil :: Effect Unit
-- | exampleUntil = do
-- |   start <- PlainDateTime.fromString "2024-01-01T00:00:00"
-- |   end <- PlainDateTime.fromString "2024-03-15T12:00:00"
-- |   duration <- PlainDateTime.until end start
-- |   Console.log (Duration.toString duration)
-- | ```
-- | ---
-- | ```text
-- | P74DT12H
-- | ```
until :: PlainDateTime -> PlainDateTime -> Effect Duration
until = Effect.Uncurried.runEffectFn2 _until

foreign import _sinceWithOptions :: forall r. EffectFn3 { | r } PlainDateTime PlainDateTime Duration

-- | Duration from `other` to `subject` (inverse of `untilWithOptions`). Arg order: `sinceWithOptions options other subject`.
-- |
-- | ```purescript
-- | exampleSinceWithOptions :: Effect Unit
-- | exampleSinceWithOptions = do
-- |   locale <- JS.Intl.Locale.new_ "en-US"
-- |   start <- PlainDateTime.fromString "2024-01-01T00:00:00"
-- |   end <- PlainDateTime.fromString "2024-03-15T12:00:00"
-- |   elapsed <- PlainDateTime.sinceWithOptions { largestUnit: TemporalUnit.Day } start end
-- |   formatter <- JS.Intl.DurationFormat.new [ locale ] { style: JS.Intl.Options.DurationFormatStyle.Long }
-- |   Console.log ("Elapsed: " <> JS.Intl.DurationFormat.format formatter elapsed)
-- | ```
-- | ---
-- | ```text
-- | Elapsed: 74 days, 12 hours
-- | ```
sinceWithOptions
  :: forall provided
   . ConvertOptionsWithDefaults
       ToDifferenceOptions
       { | DifferenceOptions }
       { | provided }
       { | DifferenceOptions }
  => { | provided }
  -> PlainDateTime
  -> PlainDateTime
  -> Effect Duration
sinceWithOptions providedOptions other plainDateTime =
  Effect.Uncurried.runEffectFn3
    _sinceWithOptions
    ( ConvertableOptions.convertOptionsWithDefaults
        ToDifferenceOptions
        defaultDifferenceOptions
        providedOptions
    )
    other
    plainDateTime

foreign import _since :: EffectFn2 PlainDateTime PlainDateTime Duration

-- | Same as [`sinceWithOptions`](#v:sinceWithOptions) with default options.
-- |
-- | ```purescript
-- | exampleSince :: Effect Unit
-- | exampleSince = do
-- |   start <- PlainDateTime.fromString "2024-01-01T00:00:00"
-- |   end <- PlainDateTime.fromString "2024-03-15T12:00:00"
-- |   elapsed <- PlainDateTime.since start end
-- |   Console.log (Duration.toString elapsed)
-- | ```
-- | ---
-- | ```text
-- | P74DT12H
-- | ```
since :: PlainDateTime -> PlainDateTime -> Effect Duration
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

foreign import _round :: forall r. EffectFn2 { | r } PlainDateTime PlainDateTime

-- | Rounds to a specified unit. Options: smallestUnit, roundingIncrement, roundingMode.
-- |
-- | ```purescript
-- | exampleRound :: Effect Unit
-- | exampleRound = do
-- |   dateTime <- PlainDateTime.fromString "2024-01-15T09:30:45.123"
-- |   rounded <- PlainDateTime.round { smallestUnit: TemporalUnit.Minute } dateTime
-- |   Console.log (PlainDateTime.toString rounded)
-- | ```
-- | ---
-- | ```text
-- | 2024-01-15T09:31:00
-- | ```
round
  :: forall provided
   . ConvertOptionsWithDefaults
       ToRoundOptions
       { | RoundOptions }
       { | provided }
       { | RoundOptions }
  => { | provided }
  -> PlainDateTime
  -> Effect PlainDateTime
round providedOptions plainDateTime =
  Effect.Uncurried.runEffectFn2
    _round
    ( ConvertableOptions.convertOptionsWithDefaults
        ToRoundOptions
        defaultRoundOptions
        providedOptions
    )
    plainDateTime

-- Comparison (equals, compare fromWithOptions Internal)

-- Serialization (toString fromWithOptions Internal)

type ToStringOptions =
  ( calendarName :: String
  , fractionalSecondDigits :: Foreign
  , smallestUnit :: String
  , roundingMode :: String
  )

data ToToStringOptions = ToToStringOptions

defaultToStringOptions :: { | ToStringOptions }
defaultToStringOptions = Unsafe.Coerce.unsafeCoerce {}

instance ConvertOption ToToStringOptions "calendarName" CalendarName String where
  convertOption _ _ = CalendarName.toString

instance ConvertOption ToToStringOptions "calendarName" String String where
  convertOption _ _ = identity

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

foreign import _toString :: forall r. Fn2 { | r } PlainDateTime String

-- | Default ISO 8601 serialization (no options).
-- |
-- | ```purescript
-- | exampleToString :: Effect Unit
-- | exampleToString = do
-- |   dateTime <- PlainDateTime.fromString "2024-01-15T09:30:00"
-- |   Console.log (PlainDateTime.toString dateTime)
-- | ```
-- | ---
-- | ```text
-- | 2024-01-15T09:30:00
-- | ```
toString :: PlainDateTime -> String
toString plainDateTime = Function.Uncurried.runFn2 _toString defaultToStringOptions plainDateTime

-- | Serializes to ISO 8601 format. Options: fractionalSecondDigits, smallestUnit, roundingMode, calendarName.
-- |
-- | ```purescript
-- | exampleToStringWithOptions :: Effect Unit
-- | exampleToStringWithOptions = do
-- |   dateTime <- PlainDateTime.fromString "2024-01-15T09:30:00"
-- |   Console.log (PlainDateTime.toStringWithOptions { smallestUnit: TemporalUnit.Minute } dateTime)
-- | ```
-- | ---
-- | ```text
-- | 2024-01-15T09:30
-- | ```
toStringWithOptions
  :: forall provided
   . ConvertOptionsWithDefaults
       ToToStringOptions
       { | ToStringOptions }
       { | provided }
       { | ToStringOptions }
  => { | provided }
  -> PlainDateTime
  -> String
toStringWithOptions providedOptions plainDateTime =
  Function.Uncurried.runFn2
    _toString
    ( ConvertableOptions.convertOptionsWithDefaults
        ToToStringOptions
        defaultToStringOptions
        providedOptions
    )
    plainDateTime

-- Instances (Eq, Ord, Show from Internal)

foreign import _toPlainDate :: Fn1 PlainDateTime PlainDate

-- | Extracts the date component.
-- |
-- | ```purescript
-- | exampleToPlainDate :: Effect Unit
-- | exampleToPlainDate = do
-- |   dateTime <- PlainDateTime.fromString "2024-01-15T09:30:00"
-- |   Console.log (PlainDate.toString (PlainDateTime.toPlainDate dateTime))
-- | ```
-- | ---
-- | ```text
-- | 2024-01-15
-- | ```
toPlainDate :: PlainDateTime -> PlainDate
toPlainDate = Function.Uncurried.runFn1 _toPlainDate

foreign import _toPlainTime :: Fn1 PlainDateTime PlainTime

-- | Extracts the time component.
-- |
-- | ```purescript
-- | exampleToPlainTime :: Effect Unit
-- | exampleToPlainTime = do
-- |   dateTime <- PlainDateTime.fromString "2024-01-15T09:30:00"
-- |   Console.log (PlainTime.toString (PlainDateTime.toPlainTime dateTime))
-- | ```
-- | ---
-- | ```text
-- | 09:30:00
-- | ```
toPlainTime :: PlainDateTime -> PlainTime
toPlainTime = Function.Uncurried.runFn1 _toPlainTime

foreign import _toZonedDateTime :: EffectFn2 String PlainDateTime ZonedDateTime

-- | Interprets this date-time as occurring in the given time zone.
-- |
-- | ```purescript
-- | exampleToZonedDateTime :: Effect Unit
-- | exampleToZonedDateTime = do
-- |   plain <- PlainDateTime.fromString "2024-01-15T09:30:00"
-- |   zoned <- PlainDateTime.toZonedDateTime "America/New_York" plain
-- |   Console.log (ZonedDateTime.toString zoned)
-- | ```
-- | ---
-- | ```text
-- | 2024-01-15T09:30:00-05:00[America/New_York]
-- | ```
toZonedDateTime :: String -> PlainDateTime -> Effect ZonedDateTime
toZonedDateTime = Effect.Uncurried.runEffectFn2 _toZonedDateTime
