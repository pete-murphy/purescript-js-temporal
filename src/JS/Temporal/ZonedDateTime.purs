-- | A date and time with time zone, representing a unique instant plus a
-- | time zone and calendar. Use when you need an absolute point in time
-- | with human-readable components in a specific zone.
-- |
-- | See <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Temporal/ZonedDateTime>
module JS.Temporal.ZonedDateTime
  ( module JS.Temporal.ZonedDateTime.Internal
  -- * Construction
  , ZonedDateTimeComponents
  , fromWithOptions
  , from
  , fromStringWithOptions
  , fromString
  -- * Properties
  , year
  , month
  , day
  , monthCode
  , hour
  , minute
  , second
  , millisecond
  , microsecond
  , nanosecond
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
  , timeZoneId
  , offset
  , offsetNanoseconds
  , hoursInDay
  , epochMilliseconds
  , epochNanoseconds
  -- * Arithmetic
  , addWithOptions
  , add
  , subtractWithOptions
  , subtract
  -- * Manipulation
  , withWithOptions
  , with
  , withTimeZone
  , withCalendar
  , withPlainTime
  , withPlainDate
  -- * Difference
  , untilWithOptions
  , until
  , sinceWithOptions
  , since
  -- * Round
  , round
  -- * Other
  , startOfDay
  , getTimeZoneTransition
  -- * Conversions
  , toInstant
  , toPlainDateTime
  , toPlainDate
  , toPlainTime
  , toPlainYearMonth
  , toPlainMonthDay
  -- * Serialization
  , toStringWithOptions
  , toString
  -- * Options
  , ToFromOptions
  , ToArithmeticOptions
  , ToDifferenceOptions
  , ToRoundOptions
  , ToToStringOptions
  ) where

import Prelude hiding (add, compare)

import ConvertableOptions (class ConvertOption, class ConvertOptionsWithDefaults)
import ConvertableOptions as ConvertableOptions
import Data.Function.Uncurried (Fn1, Fn2, Fn4)
import Data.Function.Uncurried as Function.Uncurried
import Data.Maybe (Maybe(..))
import Data.Nullable (Nullable, toMaybe)
import Effect (Effect)
import Effect.Uncurried (EffectFn1, EffectFn2, EffectFn3)
import Effect.Uncurried as Effect.Uncurried
import Foreign (Foreign)
import Foreign as Foreign
import JS.BigInt (BigInt)
import JS.Temporal.Duration.Internal (Duration)
import JS.Temporal.Instant.Internal (Instant)
import JS.Temporal.Options.CalendarName (CalendarName)
import JS.Temporal.Options.CalendarName as CalendarName
import JS.Temporal.Options.Disambiguation (Disambiguation)
import JS.Temporal.Options.Disambiguation as Disambiguation
import JS.Temporal.Options.OffsetDisambiguation (OffsetDisambiguation)
import JS.Temporal.Options.OffsetDisambiguation as OffsetDisambiguation
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
import Prim.Row (class Union)
import Unsafe.Coerce as Unsafe.Coerce

-- Construction

type ZonedDateTimeComponents =
  ( year :: Int
  , month :: Int
  , day :: Int
  , hour :: Int
  , minute :: Int
  , second :: Int
  , millisecond :: Int
  , microsecond :: Int
  , nanosecond :: Int
  , timeZone :: String
  , offset :: String
  , monthCode :: String
  , era :: String
  , eraYear :: Int
  , calendar :: String
  )

type FromOptions =
  ( overflow :: String
  , disambiguation :: String
  , offset :: String
  )

data ToFromOptions = ToFromOptions

defaultFromOptions :: { | FromOptions }
defaultFromOptions = Unsafe.Coerce.unsafeCoerce {}

instance ConvertOption ToFromOptions "overflow" Overflow String where
  convertOption _ _ = Overflow.toString

instance ConvertOption ToFromOptions "overflow" String String where
  convertOption _ _ = identity

instance ConvertOption ToFromOptions "disambiguation" Disambiguation String where
  convertOption _ _ = Disambiguation.toString

instance ConvertOption ToFromOptions "disambiguation" String String where
  convertOption _ _ = identity

instance ConvertOption ToFromOptions "offset" OffsetDisambiguation String where
  convertOption _ _ = OffsetDisambiguation.toString

instance ConvertOption ToFromOptions "offset" String String where
  convertOption _ _ = identity

foreign import _fromRecordWithOptions :: forall ro rc. EffectFn2 { | ro } { | rc } ZonedDateTime

-- | Creates a ZonedDateTime from component fields. Options: overflow, disambiguation, offset.
-- |
-- | ```purescript
-- | exampleFromWithOptions :: Effect Unit
-- | exampleFromWithOptions = do
-- |   zoned <- ZonedDateTime.fromWithOptions { overflow: Overflow.Constrain }
-- |     { year: 2024, month: 1, day: 15, hour: 12, minute: 0, second: 0, timeZone: "America/New_York" }
-- |   Console.log (ZonedDateTime.toString zoned)
-- | ```
-- | ---
-- | ```text
-- | 2024-01-15T12:00:00-05:00[America/New_York]
-- | ```
fromWithOptions
  :: forall optsProvided provided rest
   . Union provided rest ZonedDateTimeComponents
  => ConvertOptionsWithDefaults
       ToFromOptions
       { | FromOptions }
       { | optsProvided }
       { | FromOptions }
  => { | optsProvided }
  -> { | provided }
  -> Effect ZonedDateTime
fromWithOptions providedOptions components =
  Effect.Uncurried.runEffectFn2
    _fromRecordWithOptions
    ( ConvertableOptions.convertOptionsWithDefaults
        ToFromOptions
        defaultFromOptions
        providedOptions
    )
    components

foreign import _fromRecord :: forall r. EffectFn1 { | r } ZonedDateTime

-- | Same as [`fromWithOptions`](#v:fromWithOptions) with default options.
-- |
-- | ```purescript
-- | exampleFrom :: Effect Unit
-- | exampleFrom = do
-- |   zoned <- ZonedDateTime.from
-- |     { year: 2024, month: 1, day: 15, hour: 12, minute: 0, second: 0, timeZone: "America/New_York" }
-- |   Console.log (ZonedDateTime.toString zoned)
-- | ```
-- | ---
-- | ```text
-- | 2024-01-15T12:00:00-05:00[America/New_York]
-- | ```
from
  :: forall provided rest
   . Union provided rest ZonedDateTimeComponents
  => { | provided }
  -> Effect ZonedDateTime
from = Effect.Uncurried.runEffectFn1 _fromRecord

foreign import _fromStringWithOptions :: forall r. EffectFn2 { | r } String ZonedDateTime

-- | Parses an ISO 8601 string with time zone (e.g. `"2024-01-15T12:00-05:00[America/New_York]"`). Options: overflow, disambiguation, offset.
-- |
-- | ```purescript
-- | exampleFromStringWithOptions :: Effect Unit
-- | exampleFromStringWithOptions = do
-- |   zoned <- ZonedDateTime.fromStringWithOptions { overflow: Overflow.Constrain } "2024-01-15T12:00:00-05:00[America/New_York]"
-- |   Console.log (ZonedDateTime.toString zoned)
-- | ```
-- | ---
-- | ```text
-- | 2024-01-15T12:00:00-05:00[America/New_York]
-- | ```
fromStringWithOptions
  :: forall provided
   . ConvertOptionsWithDefaults
       ToFromOptions
       { | FromOptions }
       { | provided }
       { | FromOptions }
  => { | provided }
  -> String
  -> Effect ZonedDateTime
fromStringWithOptions providedOptions str =
  Effect.Uncurried.runEffectFn2
    _fromStringWithOptions
    ( ConvertableOptions.convertOptionsWithDefaults
        ToFromOptions
        defaultFromOptions
        providedOptions
    )
    str

foreign import _fromString :: EffectFn1 String ZonedDateTime

-- | Same as [`fromStringWithOptions`](#v:fromStringWithOptions) with default options.
-- |
-- | ```purescript
-- | exampleFromString :: Effect Unit
-- | exampleFromString = do
-- |   zoned <- ZonedDateTime.fromString "1970-01-01T00:00:00+00:00[UTC]"
-- |   Console.log (ZonedDateTime.toString zoned)
-- | ```
-- | ---
-- | ```text
-- | 1970-01-01T00:00:00+00:00[UTC]
-- | ```
fromString :: String -> Effect ZonedDateTime
fromString = Effect.Uncurried.runEffectFn1 _fromString

-- Properties

-- | Calendar year in this zoned date-time's calendar.
-- |
-- | ```purescript
-- | exampleYear :: Effect Unit
-- | exampleYear = do
-- |   zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
-- |   Console.log ("Year: " <> show (ZonedDateTime.year zoned))
-- | ```
-- | ---
-- | ```text
-- | Year: 2024
-- | ```
foreign import year :: ZonedDateTime -> Int

-- | Calendar month number in this zoned date-time's calendar.
-- |
-- | ```purescript
-- | exampleMonth :: Effect Unit
-- | exampleMonth = do
-- |   zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
-- |   Console.log ("Month: " <> show (ZonedDateTime.month zoned))
-- | ```
-- | ---
-- | ```text
-- | Month: 7
-- | ```
foreign import month :: ZonedDateTime -> Int

-- | Day of the month in this zoned date-time's calendar.
-- |
-- | ```purescript
-- | exampleDay :: Effect Unit
-- | exampleDay = do
-- |   zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
-- |   Console.log ("Day: " <> show (ZonedDateTime.day zoned))
-- | ```
-- | ---
-- | ```text
-- | Day: 1
-- | ```
foreign import day :: ZonedDateTime -> Int

-- | Calendar-specific month code (for example `"M01"`).
-- |
-- | ```purescript
-- | exampleMonthCode :: Effect Unit
-- | exampleMonthCode = do
-- |   zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
-- |   Console.log ("Month code: " <> ZonedDateTime.monthCode zoned)
-- | ```
-- | ---
-- | ```text
-- | Month code: M07
-- | ```
foreign import monthCode :: ZonedDateTime -> String

-- | Hour of the day in the zoned wall-clock view.
-- |
-- | ```purescript
-- | exampleHour :: Effect Unit
-- | exampleHour = do
-- |   zoned <- ZonedDateTime.fromString "2024-07-01T14:30:00[America/New_York]"
-- |   Console.log ("Hour: " <> show (ZonedDateTime.hour zoned))
-- | ```
-- | ---
-- | ```text
-- | Hour: 14
-- | ```
foreign import hour :: ZonedDateTime -> Int

-- | Minute of the hour in the zoned wall-clock view.
-- |
-- | ```purescript
-- | exampleMinute :: Effect Unit
-- | exampleMinute = do
-- |   zoned <- ZonedDateTime.fromString "2024-07-01T14:30:00[America/New_York]"
-- |   Console.log ("Minute: " <> show (ZonedDateTime.minute zoned))
-- | ```
-- | ---
-- | ```text
-- | Minute: 30
-- | ```
foreign import minute :: ZonedDateTime -> Int

-- | Second of the minute in the zoned wall-clock view.
-- |
-- | ```purescript
-- | exampleSecond :: Effect Unit
-- | exampleSecond = do
-- |   zoned <- ZonedDateTime.fromString "2024-07-01T14:30:45[America/New_York]"
-- |   Console.log ("Second: " <> show (ZonedDateTime.second zoned))
-- | ```
-- | ---
-- | ```text
-- | Second: 45
-- | ```
foreign import second :: ZonedDateTime -> Int

-- | Millisecond of the second in the zoned wall-clock view.
-- |
-- | ```purescript
-- | exampleMillisecond :: Effect Unit
-- | exampleMillisecond = do
-- |   zoned <- ZonedDateTime.fromString "2024-07-01T14:30:45.123[America/New_York]"
-- |   Console.log ("Millisecond: " <> show (ZonedDateTime.millisecond zoned))
-- | ```
-- | ---
-- | ```text
-- | Millisecond: 123
-- | ```
foreign import millisecond :: ZonedDateTime -> Int

-- | Microsecond of the millisecond in the zoned wall-clock view.
-- |
-- | ```purescript
-- | exampleMicrosecond :: Effect Unit
-- | exampleMicrosecond = do
-- |   zoned <- ZonedDateTime.fromString "2024-07-01T14:30:45.123456[America/New_York]"
-- |   Console.log ("Microsecond: " <> show (ZonedDateTime.microsecond zoned))
-- | ```
-- | ---
-- | ```text
-- | Microsecond: 456
-- | ```
foreign import microsecond :: ZonedDateTime -> Int

-- | Nanosecond of the microsecond in the zoned wall-clock view.
-- |
-- | ```purescript
-- | exampleNanosecond :: Effect Unit
-- | exampleNanosecond = do
-- |   zoned <- ZonedDateTime.fromString "2024-07-01T14:30:45.123456789[America/New_York]"
-- |   Console.log ("Nanosecond: " <> show (ZonedDateTime.nanosecond zoned))
-- | ```
-- | ---
-- | ```text
-- | Nanosecond: 789
-- | ```
foreign import nanosecond :: ZonedDateTime -> Int

-- | ISO day of week, from `1` (Monday) to `7` (Sunday).
-- |
-- | ```purescript
-- | exampleDayOfWeek :: Effect Unit
-- | exampleDayOfWeek = do
-- |   zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
-- |   Console.log ("Day of week: " <> show (ZonedDateTime.dayOfWeek zoned))
-- | ```
-- | ---
-- | ```text
-- | Day of week: 1
-- | ```
foreign import dayOfWeek :: ZonedDateTime -> Int

-- | Day number within the year in this zoned date-time's calendar.
-- |
-- | ```purescript
-- | exampleDayOfYear :: Effect Unit
-- | exampleDayOfYear = do
-- |   zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
-- |   Console.log ("Day of year: " <> show (ZonedDateTime.dayOfYear zoned))
-- | ```
-- | ---
-- | ```text
-- | Day of year: 183
-- | ```
foreign import dayOfYear :: ZonedDateTime -> Int

-- | Number of days in the current month.
-- |
-- | ```purescript
-- | exampleDaysInMonth :: Effect Unit
-- | exampleDaysInMonth = do
-- |   zoned <- ZonedDateTime.fromString "2024-02-01T12:00:00[America/New_York]"
-- |   Console.log ("Days in Feb 2024: " <> show (ZonedDateTime.daysInMonth zoned))
-- | ```
-- | ---
-- | ```text
-- | Days in Feb 2024: 29
-- | ```
foreign import daysInMonth :: ZonedDateTime -> Int

-- | Number of days in the current year.
-- |
-- | ```purescript
-- | exampleDaysInYear :: Effect Unit
-- | exampleDaysInYear = do
-- |   zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
-- |   Console.log ("Days in 2024: " <> show (ZonedDateTime.daysInYear zoned))
-- | ```
-- | ---
-- | ```text
-- | Days in 2024: 366
-- | ```
foreign import daysInYear :: ZonedDateTime -> Int

-- | Number of days in the current week according to the calendar.
-- |
-- | ```purescript
-- | exampleDaysInWeek :: Effect Unit
-- | exampleDaysInWeek = do
-- |   zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
-- |   Console.log ("Days in week: " <> show (ZonedDateTime.daysInWeek zoned))
-- | ```
-- | ---
-- | ```text
-- | Days in week: 7
-- | ```
foreign import daysInWeek :: ZonedDateTime -> Int

-- | Number of months in the current year.
-- |
-- | ```purescript
-- | exampleMonthsInYear :: Effect Unit
-- | exampleMonthsInYear = do
-- |   zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
-- |   Console.log ("Months in year: " <> show (ZonedDateTime.monthsInYear zoned))
-- | ```
-- | ---
-- | ```text
-- | Months in year: 12
-- | ```
foreign import monthsInYear :: ZonedDateTime -> Int

-- | Whether the current year is a leap year in this calendar.
-- |
-- | ```purescript
-- | exampleInLeapYear :: Effect Unit
-- | exampleInLeapYear = do
-- |   zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
-- |   Console.log ("2024 is leap year: " <> show (ZonedDateTime.inLeapYear zoned))
-- | ```
-- | ---
-- | ```text
-- | 2024 is leap year: true
-- | ```
foreign import inLeapYear :: ZonedDateTime -> Boolean

-- | Identifier of the current calendar (for example `"iso8601"`).
-- |
-- | ```purescript
-- | exampleCalendarId :: Effect Unit
-- | exampleCalendarId = do
-- |   zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
-- |   Console.log ("Calendar: " <> ZonedDateTime.calendarId zoned)
-- | ```
-- | ---
-- | ```text
-- | Calendar: iso8601
-- | ```
foreign import calendarId :: ZonedDateTime -> String

-- | Identifier of the associated time zone (for example `"America/New_York"`).
-- |
-- | ```purescript
-- | exampleTimeZoneId :: Effect Unit
-- | exampleTimeZoneId = do
-- |   zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
-- |   Console.log ("Time zone: " <> ZonedDateTime.timeZoneId zoned)
-- | ```
-- | ---
-- | ```text
-- | Time zone: America/New_York
-- | ```
foreign import timeZoneId :: ZonedDateTime -> String

-- | Numeric UTC offset string for this instant in the associated time zone.
-- |
-- | ```purescript
-- | exampleOffset :: Effect Unit
-- | exampleOffset = do
-- |   zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
-- |   Console.log ("Offset: " <> ZonedDateTime.offset zoned)
-- | ```
-- | ---
-- | ```text
-- | Offset: -04:00
-- | ```
foreign import offset :: ZonedDateTime -> String

-- | UTC offset for this instant, in nanoseconds.
-- |
-- | ```purescript
-- | exampleOffsetNanoseconds :: Effect Unit
-- | exampleOffsetNanoseconds = do
-- |   zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
-- |   Console.log ("Offset ns: " <> show (ZonedDateTime.offsetNanoseconds zoned))
-- | ```
-- | ---
-- | ```text
-- | Offset ns: -14400000000000
-- | ```
foreign import offsetNanoseconds :: ZonedDateTime -> Int

-- | Number of wall-clock hours in this calendar day in the associated time zone.
-- |
-- | ```purescript
-- | exampleHoursInDay :: Effect Unit
-- | exampleHoursInDay = do
-- |   zoned <- ZonedDateTime.fromString "2024-03-10T12:00:00[America/New_York]"
-- |   Console.log ("Hours in day (DST spring forward): " <> show (ZonedDateTime.hoursInDay zoned))
-- | ```
-- | ---
-- | ```text
-- | Hours in day (DST spring forward): 23
-- | ```
foreign import hoursInDay :: ZonedDateTime -> Int

-- | Milliseconds since the Unix epoch for the represented instant.
-- |
-- | ```purescript
-- | exampleEpochMilliseconds :: Effect Unit
-- | exampleEpochMilliseconds = do
-- |   zoned <- ZonedDateTime.fromString "1970-01-01T00:00:01+00:00[UTC]"
-- |   Console.log ("Epoch ms: " <> show (ZonedDateTime.epochMilliseconds zoned))
-- | ```
-- | ---
-- | ```text
-- | Epoch ms: 1000.0
-- | ```
foreign import epochMilliseconds :: ZonedDateTime -> Number

-- | Nanoseconds since the Unix epoch for the represented instant.
-- |
-- | ```purescript
-- | exampleEpochNanoseconds :: Effect Unit
-- | exampleEpochNanoseconds = do
-- |   zoned <- ZonedDateTime.fromString "1970-01-01T00:00:01+00:00[UTC]"
-- |   Console.log ("Epoch ns: " <> show (ZonedDateTime.epochNanoseconds zoned))
-- | ```
-- | ---
-- | ```text
-- | Epoch ns: 1000000000
-- | ```
foreign import epochNanoseconds :: ZonedDateTime -> BigInt

foreign import _weekOfYear :: ZonedDateTime -> Nullable Int

-- | Week number within the year, if the calendar defines week numbering.
-- |
-- | ```purescript
-- | exampleWeekOfYear :: Effect Unit
-- | exampleWeekOfYear = do
-- |   zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
-- |   Console.log ("Week of year: " <> show (ZonedDateTime.weekOfYear zoned))
-- | ```
-- | ---
-- | ```text
-- | Week of year: (Just 27)
-- | ```
weekOfYear :: ZonedDateTime -> Maybe Int
weekOfYear = toMaybe <<< _weekOfYear

foreign import _yearOfWeek :: ZonedDateTime -> Nullable Int

-- | Week-numbering year, if the calendar defines week numbering.
-- |
-- | ```purescript
-- | exampleYearOfWeek :: Effect Unit
-- | exampleYearOfWeek = do
-- |   zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
-- |   Console.log ("Year of week: " <> show (ZonedDateTime.yearOfWeek zoned))
-- | ```
-- | ---
-- | ```text
-- | Year of week: (Just 2024)
-- | ```
yearOfWeek :: ZonedDateTime -> Maybe Int
yearOfWeek = toMaybe <<< _yearOfWeek

foreign import _era :: ZonedDateTime -> Nullable String

-- | Calendar era name, if this calendar uses eras.
-- |
-- | ```purescript
-- | exampleEra :: Effect Unit
-- | exampleEra = do
-- |   zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
-- |   Console.log ("Era: " <> show (ZonedDateTime.era zoned))
-- | ```
-- | ---
-- | ```text
-- | Era: Nothing
-- | ```
era :: ZonedDateTime -> Maybe String
era = toMaybe <<< _era

foreign import _eraYear :: ZonedDateTime -> Nullable Int

-- | Year number within the current era, if this calendar uses eras.
-- |
-- | ```purescript
-- | exampleEraYear :: Effect Unit
-- | exampleEraYear = do
-- |   zoned <- ZonedDateTime.fromString "2024-07-01T12:00:00[America/New_York]"
-- |   Console.log ("Era year: " <> show (ZonedDateTime.eraYear zoned))
-- | ```
-- | ---
-- | ```text
-- | Era year: Nothing
-- | ```
eraYear :: ZonedDateTime -> Maybe Int
eraYear = toMaybe <<< _eraYear

-- Arithmetic

type ArithmeticOptions =
  ( overflow :: String
  , disambiguation :: String
  )

data ToArithmeticOptions = ToArithmeticOptions

defaultArithmeticOptions :: { | ArithmeticOptions }
defaultArithmeticOptions = Unsafe.Coerce.unsafeCoerce {}

instance ConvertOption ToArithmeticOptions "overflow" Overflow String where
  convertOption _ _ = Overflow.toString

instance ConvertOption ToArithmeticOptions "overflow" String String where
  convertOption _ _ = identity

instance ConvertOption ToArithmeticOptions "disambiguation" Disambiguation String where
  convertOption _ _ = Disambiguation.toString

instance ConvertOption ToArithmeticOptions "disambiguation" String String where
  convertOption _ _ = identity

foreign import _addWithOptions :: forall r. EffectFn3 { | r } Duration ZonedDateTime ZonedDateTime

-- | Adds a duration. Supports calendar durations. Options: overflow.
-- |
-- | ```purescript
-- | exampleAddWithOptions :: Effect Unit
-- | exampleAddWithOptions = do
-- |   start <- ZonedDateTime.fromString "2024-01-15T12:00:00-05:00[America/New_York]"
-- |   twoHours <- Duration.from { hours: 2 }
-- |   later <- ZonedDateTime.addWithOptions { overflow: Overflow.Constrain } twoHours start
-- |   Console.log (ZonedDateTime.toString later)
-- | ```
-- | ---
-- | ```text
-- | 2024-01-15T14:00:00-05:00[America/New_York]
-- | ```
addWithOptions
  :: forall provided
   . ConvertOptionsWithDefaults
       ToArithmeticOptions
       { | ArithmeticOptions }
       { | provided }
       { | ArithmeticOptions }
  => { | provided }
  -> Duration
  -> ZonedDateTime
  -> Effect ZonedDateTime
addWithOptions providedOptions duration zonedDateTime =
  Effect.Uncurried.runEffectFn3
    _addWithOptions
    ( ConvertableOptions.convertOptionsWithDefaults
        ToArithmeticOptions
        defaultArithmeticOptions
        providedOptions
    )
    duration
    zonedDateTime

foreign import _add :: EffectFn2 Duration ZonedDateTime ZonedDateTime

-- | Same as [`addWithOptions`](#v:addWithOptions) with default options.
-- |
-- | ```purescript
-- | exampleAdd :: Effect Unit
-- | exampleAdd = do
-- |   start <- ZonedDateTime.fromString "2024-01-15T12:00:00-05:00[America/New_York]"
-- |   twoHours <- Duration.from { hours: 2 }
-- |   later <- ZonedDateTime.add twoHours start
-- |   Console.log (ZonedDateTime.toString later)
-- | ```
-- | ---
-- | ```text
-- | 2024-01-15T14:00:00-05:00[America/New_York]
-- | ```
add :: Duration -> ZonedDateTime -> Effect ZonedDateTime
add = Effect.Uncurried.runEffectFn2 _add

foreign import _subtractWithOptions :: forall r. EffectFn3 { | r } Duration ZonedDateTime ZonedDateTime

-- | Subtracts a duration. Arg order: `subtractWithOptions options duration subject`.
-- |
-- | ```purescript
-- | exampleSubtractWithOptions :: Effect Unit
-- | exampleSubtractWithOptions = do
-- |   zoned <- ZonedDateTime.fromString "2024-03-15T14:00:00[America/New_York]"
-- |   twoHours <- Duration.from { hours: 2 }
-- |   earlier <- ZonedDateTime.subtractWithOptions { overflow: Overflow.Constrain } twoHours zoned
-- |   Console.log (ZonedDateTime.toString earlier)
-- | ```
-- | ---
-- | ```text
-- | 2024-03-15T12:00:00-04:00[America/New_York]
-- | ```
subtractWithOptions
  :: forall provided
   . ConvertOptionsWithDefaults
       ToArithmeticOptions
       { | ArithmeticOptions }
       { | provided }
       { | ArithmeticOptions }
  => { | provided }
  -> Duration
  -> ZonedDateTime
  -> Effect ZonedDateTime
subtractWithOptions providedOptions duration zonedDateTime =
  Effect.Uncurried.runEffectFn3
    _subtractWithOptions
    ( ConvertableOptions.convertOptionsWithDefaults
        ToArithmeticOptions
        defaultArithmeticOptions
        providedOptions
    )
    duration
    zonedDateTime

foreign import _subtract :: EffectFn2 Duration ZonedDateTime ZonedDateTime

-- | Same as [`subtractWithOptions`](#v:subtractWithOptions) with default options.
-- |
-- | ```purescript
-- | exampleSubtract :: Effect Unit
-- | exampleSubtract = do
-- |   zoned <- ZonedDateTime.fromString "2024-03-15T14:00:00[America/New_York]"
-- |   twoHours <- Duration.from { hours: 2 }
-- |   earlier <- ZonedDateTime.subtract twoHours zoned
-- |   Console.log (ZonedDateTime.toString earlier)
-- | ```
-- | ---
-- | ```text
-- | 2024-03-15T12:00:00-04:00[America/New_York]
-- | ```
subtract :: Duration -> ZonedDateTime -> Effect ZonedDateTime
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

foreign import _withWithOptions :: forall ro rf. EffectFn3 { | ro } { | rf } ZonedDateTime ZonedDateTime

-- | Returns a copy with some wall-clock fields replaced. Options: overflow,
-- | disambiguation, offset.
-- |
-- | ```purescript
-- | exampleWithWithOptions :: Effect Unit
-- | exampleWithWithOptions = do
-- |   meeting <- ZonedDateTime.fromString "2024-01-15T09:30:45-05:00[America/New_York]"
-- |   noon <- ZonedDateTime.withWithOptions { overflow: Overflow.Constrain } { hour: 12, minute: 0, second: 0 } meeting
-- |   Console.log (ZonedDateTime.toString noon)
-- | ```
-- | ---
-- | ```text
-- | 2024-01-15T12:00:00-05:00[America/New_York]
-- | ```
withWithOptions
  :: forall optsProvided fields rest
   . Union fields rest WithFields
  => ConvertOptionsWithDefaults
       ToFromOptions
       { | FromOptions }
       { | optsProvided }
       { | FromOptions }
  => { | optsProvided }
  -> { | fields }
  -> ZonedDateTime
  -> Effect ZonedDateTime
withWithOptions options fields zonedDateTime =
  Effect.Uncurried.runEffectFn3
    _withWithOptions
    ( ConvertableOptions.convertOptionsWithDefaults
        ToFromOptions
        defaultFromOptions
        options
    )
    fields
    zonedDateTime

foreign import _with :: forall r. EffectFn2 { | r } ZonedDateTime ZonedDateTime

-- | Same as [`withWithOptions`](#v:withWithOptions) with default options.
-- |
-- | ```purescript
-- | exampleWith :: Effect Unit
-- | exampleWith = do
-- |   meeting <- ZonedDateTime.fromString "2024-01-15T09:30:45-05:00[America/New_York]"
-- |   noon <- ZonedDateTime.with { hour: 12, minute: 0, second: 0 } meeting
-- |   Console.log (ZonedDateTime.toString noon)
-- | ```
-- | ---
-- | ```text
-- | 2024-01-15T12:00:00-05:00[America/New_York]
-- | ```
with
  :: forall fields rest
   . Union fields rest WithFields
  => { | fields }
  -> ZonedDateTime
  -> Effect ZonedDateTime
with = Effect.Uncurried.runEffectFn2 _with

foreign import _withTimeZone :: EffectFn2 String ZonedDateTime ZonedDateTime

-- | Returns the same instant interpreted in a different time zone.
-- |
-- | ```purescript
-- | exampleWithTimeZone :: Effect Unit
-- | exampleWithTimeZone = do
-- |   zoned <- ZonedDateTime.fromString "2024-01-15T12:00:00-05:00[America/New_York]"
-- |   inTokyo <- ZonedDateTime.withTimeZone "Asia/Tokyo" zoned
-- |   Console.log (ZonedDateTime.toString inTokyo)
-- | ```
-- | ---
-- | ```text
-- | 2024-01-16T02:00:00+09:00[Asia/Tokyo]
-- | ```
withTimeZone :: String -> ZonedDateTime -> Effect ZonedDateTime
withTimeZone = Effect.Uncurried.runEffectFn2 _withTimeZone

foreign import _withCalendar :: EffectFn2 String ZonedDateTime ZonedDateTime

-- | Returns a copy with the same instant and time zone, but a different calendar.
-- |
-- | ```purescript
-- | exampleWithCalendar :: Effect Unit
-- | exampleWithCalendar = do
-- |   zoned <- ZonedDateTime.fromString "2024-01-15T12:00:00-05:00[America/New_York]"
-- |   gregory <- ZonedDateTime.withCalendar "gregory" zoned
-- |   Console.log (ZonedDateTime.toStringWithOptions { calendarName: CalendarName.Always } gregory)
-- | ```
-- | ---
-- | ```text
-- | 2024-01-15T12:00:00-05:00[America/New_York][u-ca=gregory]
-- | ```
withCalendar :: String -> ZonedDateTime -> Effect ZonedDateTime
withCalendar = Effect.Uncurried.runEffectFn2 _withCalendar

foreign import _withPlainTime :: EffectFn2 PlainTime ZonedDateTime ZonedDateTime

-- | Returns a copy with the wall-clock time replaced.
-- |
-- | ```purescript
-- | exampleWithPlainTime :: Effect Unit
-- | exampleWithPlainTime = do
-- |   zoned <- ZonedDateTime.fromString "2024-01-15T09:30:45-05:00[America/New_York]"
-- |   closingTime <- PlainTime.fromString "17:00:00"
-- |   updated <- ZonedDateTime.withPlainTime closingTime zoned
-- |   Console.log (ZonedDateTime.toString updated)
-- | ```
-- | ---
-- | ```text
-- | 2024-01-15T17:00:00-05:00[America/New_York]
-- | ```
withPlainTime :: PlainTime -> ZonedDateTime -> Effect ZonedDateTime
withPlainTime = Effect.Uncurried.runEffectFn2 _withPlainTime

foreign import _withPlainDate :: EffectFn2 PlainDate ZonedDateTime ZonedDateTime

-- | Returns a copy with the calendar date replaced.
-- |
-- | ```purescript
-- | exampleWithPlainDate :: Effect Unit
-- | exampleWithPlainDate = do
-- |   zoned <- ZonedDateTime.fromString "2024-01-15T09:30:45-05:00[America/New_York]"
-- |   nextDay <- PlainDate.fromString "2024-01-16"
-- |   updated <- ZonedDateTime.withPlainDate nextDay zoned
-- |   Console.log (ZonedDateTime.toString updated)
-- | ```
-- | ---
-- | ```text
-- | 2024-01-16T09:30:45-05:00[America/New_York]
-- | ```
withPlainDate :: PlainDate -> ZonedDateTime -> Effect ZonedDateTime
withPlainDate = Effect.Uncurried.runEffectFn2 _withPlainDate

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

foreign import _untilWithOptions :: forall r. EffectFn3 { | r } ZonedDateTime ZonedDateTime Duration

-- | Duration from `subject` (last arg) until `other` (second arg). Arg order: `untilWithOptions options other subject`.
-- |
-- | ```purescript
-- | exampleUntilWithOptions :: Effect Unit
-- | exampleUntilWithOptions = do
-- |   locale <- JS.Intl.Locale.new_ "en-US"
-- |   departure <- ZonedDateTime.fromString "2020-03-08T11:55:00+08:00[Asia/Hong_Kong]"
-- |   arrival <- ZonedDateTime.fromString "2020-03-08T09:50:00-07:00[America/Los_Angeles]"
-- |   flightTime <- ZonedDateTime.untilWithOptions { largestUnit: TemporalUnit.Hour } arrival departure
-- |   formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
-- |   Console.log ("Flight time: " <> JS.Intl.DurationFormat.format formatter flightTime)
-- | ```
-- | ---
-- | ```text
-- | Flight time: 12 hours, 55 minutes
-- | ```
untilWithOptions
  :: forall provided
   . ConvertOptionsWithDefaults
       ToDifferenceOptions
       { | DifferenceOptions }
       { | provided }
       { | DifferenceOptions }
  => { | provided }
  -> ZonedDateTime
  -> ZonedDateTime
  -> Effect Duration
untilWithOptions providedOptions other zonedDateTime =
  Effect.Uncurried.runEffectFn3
    _untilWithOptions
    ( ConvertableOptions.convertOptionsWithDefaults
        ToDifferenceOptions
        defaultDifferenceOptions
        providedOptions
    )
    other
    zonedDateTime

foreign import _until :: EffectFn2 ZonedDateTime ZonedDateTime Duration

-- | Same as [`untilWithOptions`](#v:untilWithOptions) with default options. Arg order: `until other subject`.
-- |
-- | ```purescript
-- | exampleUntil :: Effect Unit
-- | exampleUntil = do
-- |   start <- ZonedDateTime.fromString "2024-01-01T00:00:00[America/New_York]"
-- |   end <- ZonedDateTime.fromString "2024-01-02T00:00:00[America/New_York]"
-- |   duration <- ZonedDateTime.until end start
-- |   Console.log (Duration.toString duration)
-- | ```
-- | ---
-- | ```text
-- | PT24H
-- | ```
until :: ZonedDateTime -> ZonedDateTime -> Effect Duration
until = Effect.Uncurried.runEffectFn2 _until

foreign import _sinceWithOptions :: forall r. EffectFn3 { | r } ZonedDateTime ZonedDateTime Duration

-- | Duration from `other` to `subject` (inverse of `untilWithOptions`). Arg order: `sinceWithOptions options other subject`.
-- |
-- | ```purescript
-- | exampleSinceWithOptions :: Effect Unit
-- | exampleSinceWithOptions = do
-- |   locale <- JS.Intl.Locale.new_ "en-US"
-- |   start <- ZonedDateTime.fromString "2024-01-01T00:00:00[America/New_York]"
-- |   end <- ZonedDateTime.fromString "2024-03-15T12:00:00[America/New_York]"
-- |   elapsed <- ZonedDateTime.sinceWithOptions { largestUnit: TemporalUnit.Hour } start end
-- |   formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
-- |   Console.log ("Elapsed: " <> JS.Intl.DurationFormat.format formatter elapsed)
-- | ```
-- | ---
-- | ```text
-- | Elapsed: 1,787 hours
-- | ```
sinceWithOptions
  :: forall provided
   . ConvertOptionsWithDefaults
       ToDifferenceOptions
       { | DifferenceOptions }
       { | provided }
       { | DifferenceOptions }
  => { | provided }
  -> ZonedDateTime
  -> ZonedDateTime
  -> Effect Duration
sinceWithOptions providedOptions other zonedDateTime =
  Effect.Uncurried.runEffectFn3
    _sinceWithOptions
    ( ConvertableOptions.convertOptionsWithDefaults
        ToDifferenceOptions
        defaultDifferenceOptions
        providedOptions
    )
    other
    zonedDateTime

foreign import _since :: EffectFn2 ZonedDateTime ZonedDateTime Duration

-- | Same as [`sinceWithOptions`](#v:sinceWithOptions) with default options. Arg order: `since other subject`.
-- |
-- | ```purescript
-- | exampleSince :: Effect Unit
-- | exampleSince = do
-- |   start <- ZonedDateTime.fromString "2024-01-01T00:00:00[America/New_York]"
-- |   end <- ZonedDateTime.fromString "2024-03-15T12:00:00[America/New_York]"
-- |   elapsed <- ZonedDateTime.since start end
-- |   Console.log (Duration.toString elapsed)
-- | ```
-- | ---
-- | ```text
-- | PT1787H
-- | ```
since :: ZonedDateTime -> ZonedDateTime -> Effect Duration
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

foreign import _round :: forall r. EffectFn2 { | r } ZonedDateTime ZonedDateTime

-- | Rounds this zoned date-time to a smaller unit. Options: smallestUnit,
-- | roundingIncrement, roundingMode.
-- |
-- | ```purescript
-- | exampleRound :: Effect Unit
-- | exampleRound = do
-- |   zoned <- ZonedDateTime.fromString "2024-01-15T09:30:45.123456789-05:00[America/New_York]"
-- |   rounded <- ZonedDateTime.round { smallestUnit: TemporalUnit.Minute, roundingMode: RoundingMode.HalfExpand } zoned
-- |   Console.log (ZonedDateTime.toString rounded)
-- | ```
-- | ---
-- | ```text
-- | 2024-01-15T09:31:00-05:00[America/New_York]
-- | ```
round
  :: forall provided
   . ConvertOptionsWithDefaults
       ToRoundOptions
       { | RoundOptions }
       { | provided }
       { | RoundOptions }
  => { | provided }
  -> ZonedDateTime
  -> Effect ZonedDateTime
round providedOptions zonedDateTime =
  Effect.Uncurried.runEffectFn2
    _round
    ( ConvertableOptions.convertOptionsWithDefaults
        ToRoundOptions
        defaultRoundOptions
        providedOptions
    )
    zonedDateTime

-- Other

foreign import _startOfDay :: EffectFn1 ZonedDateTime ZonedDateTime

-- | Returns the start of the calendar day in this time zone.
-- |
-- | ```purescript
-- | exampleStartOfDay :: Effect Unit
-- | exampleStartOfDay = do
-- |   zoned <- ZonedDateTime.fromString "2024-03-10T12:00:00-04:00[America/New_York]"
-- |   start <- ZonedDateTime.startOfDay zoned
-- |   Console.log (ZonedDateTime.toString start)
-- | ```
-- | ---
-- | ```text
-- | 2024-03-10T00:00:00-05:00[America/New_York]
-- | ```
startOfDay :: ZonedDateTime -> Effect ZonedDateTime
startOfDay = Effect.Uncurried.runEffectFn1 _startOfDay

foreign import _getTimeZoneTransition
  :: Fn4
       (forall a. Maybe a)
       (forall a. a -> Maybe a)
       String
       ZonedDateTime
       (Maybe ZonedDateTime)

-- | Gets the next or previous time zone transition. Direction: `"next"` or `"previous"`.
-- |
-- | ```purescript
-- | exampleGetTimeZoneTransition :: Effect Unit
-- | exampleGetTimeZoneTransition = do
-- |   zoned <- ZonedDateTime.fromString "2024-03-09T12:00:00-05:00[America/New_York]"
-- |   case ZonedDateTime.getTimeZoneTransition "next" zoned of
-- |     Nothing -> Console.log "No transition"
-- |     Just transition -> Console.log (ZonedDateTime.toString transition)
-- | ```
-- | ---
-- | ```text
-- | 2024-03-10T03:00:00-04:00[America/New_York]
-- | ```
getTimeZoneTransition :: String -> ZonedDateTime -> Maybe ZonedDateTime
getTimeZoneTransition direction zonedDateTime =
  Function.Uncurried.runFn4 _getTimeZoneTransition Nothing Just direction zonedDateTime

-- Conversions

foreign import _toInstant :: Fn1 ZonedDateTime Instant

-- | Extracts the absolute instant (no time zone).
-- |
-- | ```purescript
-- | exampleToInstant :: Effect Unit
-- | exampleToInstant = do
-- |   zoned <- ZonedDateTime.fromString "2024-01-15T12:00:00-05:00[America/New_York]"
-- |   Console.log (Instant.toString (ZonedDateTime.toInstant zoned))
-- | ```
-- | ---
-- | ```text
-- | 2024-01-15T17:00:00Z
-- | ```
toInstant :: ZonedDateTime -> Instant
toInstant = Function.Uncurried.runFn1 _toInstant

foreign import _toPlainDateTime :: Fn1 ZonedDateTime PlainDateTime

-- | Extracts date and time in the zoned wall-clock view (drops time zone).
-- |
-- | ```purescript
-- | exampleToPlainDateTime :: Effect Unit
-- | exampleToPlainDateTime = do
-- |   zoned <- ZonedDateTime.fromString "2024-01-15T12:00:00-05:00[America/New_York]"
-- |   Console.log (PlainDateTime.toString (ZonedDateTime.toPlainDateTime zoned))
-- | ```
-- | ---
-- | ```text
-- | 2024-01-15T12:00:00
-- | ```
toPlainDateTime :: ZonedDateTime -> PlainDateTime
toPlainDateTime = Function.Uncurried.runFn1 _toPlainDateTime

foreign import _toPlainDate :: Fn1 ZonedDateTime PlainDate

-- | Extracts the calendar date in the zoned wall-clock view.
-- |
-- | ```purescript
-- | exampleToPlainDate :: Effect Unit
-- | exampleToPlainDate = do
-- |   zoned <- ZonedDateTime.fromString "2024-01-15T12:00:00-05:00[America/New_York]"
-- |   Console.log (PlainDate.toString (ZonedDateTime.toPlainDate zoned))
-- | ```
-- | ---
-- | ```text
-- | 2024-01-15
-- | ```
toPlainDate :: ZonedDateTime -> PlainDate
toPlainDate = Function.Uncurried.runFn1 _toPlainDate

foreign import _toPlainTime :: Fn1 ZonedDateTime PlainTime

-- | Extracts the wall-clock time in the associated time zone.
-- |
-- | ```purescript
-- | exampleToPlainTime :: Effect Unit
-- | exampleToPlainTime = do
-- |   zoned <- ZonedDateTime.fromString "2024-01-15T12:00:00-05:00[America/New_York]"
-- |   Console.log (PlainTime.toString (ZonedDateTime.toPlainTime zoned))
-- | ```
-- | ---
-- | ```text
-- | 12:00:00
-- | ```
toPlainTime :: ZonedDateTime -> PlainTime
toPlainTime = Function.Uncurried.runFn1 _toPlainTime

foreign import _toPlainYearMonth :: Fn1 ZonedDateTime PlainYearMonth

-- | Extracts the year and month in the zoned wall-clock view.
-- |
-- | ```purescript
-- | exampleToPlainYearMonth :: Effect Unit
-- | exampleToPlainYearMonth = do
-- |   zoned <- ZonedDateTime.fromString "2024-01-15T12:00:00-05:00[America/New_York]"
-- |   Console.log (PlainYearMonth.toString (ZonedDateTime.toPlainYearMonth zoned))
-- | ```
-- | ---
-- | ```text
-- | 2024-01
-- | ```
toPlainYearMonth :: ZonedDateTime -> PlainYearMonth
toPlainYearMonth = Function.Uncurried.runFn1 _toPlainYearMonth

foreign import _toPlainMonthDay :: Fn1 ZonedDateTime PlainMonthDay

-- | Extracts the month and day in the zoned wall-clock view.
-- |
-- | ```purescript
-- | exampleToPlainMonthDay :: Effect Unit
-- | exampleToPlainMonthDay = do
-- |   zoned <- ZonedDateTime.fromString "2024-01-15T12:00:00-05:00[America/New_York]"
-- |   Console.log (PlainMonthDay.toString (ZonedDateTime.toPlainMonthDay zoned))
-- | ```
-- | ---
-- | ```text
-- | 01-15
-- | ```
toPlainMonthDay :: ZonedDateTime -> PlainMonthDay
toPlainMonthDay = Function.Uncurried.runFn1 _toPlainMonthDay

-- Serialization (toString fromWithOptions Internal)

type ToStringOptions =
  ( calendarName :: String
  , timeZoneName :: String
  , offset :: String
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

instance ConvertOption ToToStringOptions "timeZoneName" String String where
  convertOption _ _ = identity

instance ConvertOption ToToStringOptions "offset" String String where
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

foreign import _toString :: forall r. Fn2 { | r } ZonedDateTime String

-- | Same as [`toStringWithOptions`](#v:toStringWithOptions) with default options.
-- |
-- | ```purescript
-- | exampleToString :: Effect Unit
-- | exampleToString = do
-- |   zoned <- ZonedDateTime.fromString "2024-01-15T12:00:00-05:00[America/New_York]"
-- |   Console.log (ZonedDateTime.toString zoned)
-- | ```
-- | ---
-- | ```text
-- | 2024-01-15T12:00:00-05:00[America/New_York]
-- | ```
toString :: ZonedDateTime -> String
toString zonedDateTime = Function.Uncurried.runFn2 _toString defaultToStringOptions zonedDateTime

-- | Serializes to ISO 8601 format with time zone. Options: calendarName, timeZoneName, offset, fractionalSecondDigits, smallestUnit, roundingMode.
-- |
-- | ```purescript
-- | exampleToStringWithOptions :: Effect Unit
-- | exampleToStringWithOptions = do
-- |   zoned <- ZonedDateTime.fromString "2024-01-15T12:00:00.123456789-05:00[America/New_York]"
-- |   Console.log
-- |     ( ZonedDateTime.toStringWithOptions
-- |         { smallestUnit: TemporalUnit.Minute
-- |         , calendarName: CalendarName.Never
-- |         }
-- |         zoned
-- |     )
-- | ```
-- | ---
-- | ```text
-- | 2024-01-15T12:00-05:00[America/New_York]
-- | ```
toStringWithOptions
  :: forall provided
   . ConvertOptionsWithDefaults
       ToToStringOptions
       { | ToStringOptions }
       { | provided }
       { | ToStringOptions }
  => { | provided }
  -> ZonedDateTime
  -> String
toStringWithOptions providedOptions zonedDateTime =
  Function.Uncurried.runFn2
    _toString
    ( ConvertableOptions.convertOptionsWithDefaults
        ToToStringOptions
        defaultToStringOptions
        providedOptions
    )
    zonedDateTime

-- Instances (Eq, Ord, Show from Internal)
