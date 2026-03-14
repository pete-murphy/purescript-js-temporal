-- | A date and time with time zone, representing a unique instant plus a
-- | time zone and calendar. Use when you need an absolute point in time
-- | with human-readable components in a specific zone.
-- |
-- | See <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Temporal/ZonedDateTime>
module JS.Temporal.ZonedDateTime
  ( module JS.Temporal.ZonedDateTime.Internal
  -- * Construction
  , ZonedDateTimeComponents
  , from
  , from_
  , fromString
  , fromString_
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
  , add
  , add_
  , subtract
  , subtract_
  -- * Manipulation
  , with
  , with_
  , withTimeZone
  , withCalendar
  , withPlainTime
  , withPlainDate
  -- * Difference
  , until
  , until_
  , since
  , since_
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
  , toString
  , toString_
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

foreign import _fromRecord :: forall ro rc. EffectFn2 { | ro } { | rc } ZonedDateTime

-- | Creates a ZonedDateTime from component fields. Options: overflow, disambiguation, offset.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | zoned <- ZonedDateTime.from_ { year: 2024, month: 1, day: 15, hour: 12, timeZone: "America/New_York" }
-- | formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
-- | Console.log (JS.Intl.DateTimeFormat.format formatter zoned)
-- | ```
-- |
-- | ```text
-- | January 15, 2024 at 12:00:00 PM
-- | ```

from
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
from providedOptions components =
  Effect.Uncurried.runEffectFn2
    _fromRecord
    ( ConvertableOptions.convertOptionsWithDefaults
        ToFromOptions
        defaultFromOptions
        providedOptions
    )
    components

foreign import _fromRecordNoOpts :: forall r. EffectFn1 { | r } ZonedDateTime

-- | Same as [`from`](#from) with default options.

from_
  :: forall provided rest
   . Union provided rest ZonedDateTimeComponents
  => { | provided }
  -> Effect ZonedDateTime
from_ = Effect.Uncurried.runEffectFn1 _fromRecordNoOpts

foreign import _fromString :: forall r. EffectFn2 { | r } String ZonedDateTime

-- | Parses an ISO 8601 string with time zone (e.g. `"2024-01-15T12:00-05:00[America/New_York]"`). Options: overflow, disambiguation, offset.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | zoned <- ZonedDateTime.fromString { overflow: Overflow.Constrain } "2024-01-15T12:00:00-05:00[America/New_York]"
-- | formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
-- | Console.log (JS.Intl.DateTimeFormat.format formatter zoned)
-- | ```
-- |
-- | ```text
-- | January 15, 2024 at 12:00:00 PM
-- | ```

fromString
  :: forall provided
   . ConvertOptionsWithDefaults
       ToFromOptions
       { | FromOptions }
       { | provided }
       { | FromOptions }
  => { | provided }
  -> String
  -> Effect ZonedDateTime
fromString providedOptions str =
  Effect.Uncurried.runEffectFn2
    _fromString
    ( ConvertableOptions.convertOptionsWithDefaults
        ToFromOptions
        defaultFromOptions
        providedOptions
    )
    str

foreign import _fromStringNoOpts :: EffectFn1 String ZonedDateTime

-- | Same as [`fromString`](#fromstring) with default options.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | zoned <- ZonedDateTime.fromString_ "1970-01-01T00:00:00+00:00[UTC]"
-- | formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium", timeZone: "UTC" }
-- | Console.log (JS.Intl.DateTimeFormat.format formatter zoned)
-- | ```
-- |
-- | ```text
-- | January 1, 1970 at 12:00:00 AM
-- | ```

fromString_ :: String -> Effect ZonedDateTime
fromString_ = Effect.Uncurried.runEffectFn1 _fromStringNoOpts

-- Properties

-- | Calendar year in this zoned date-time's calendar.
foreign import year :: ZonedDateTime -> Int
-- | Calendar month number in this zoned date-time's calendar.
foreign import month :: ZonedDateTime -> Int
-- | Day of the month in this zoned date-time's calendar.
foreign import day :: ZonedDateTime -> Int
-- | Calendar-specific month code (for example `"M01"`).
foreign import monthCode :: ZonedDateTime -> String
-- | Hour of the day in the zoned wall-clock view.
foreign import hour :: ZonedDateTime -> Int
-- | Minute of the hour in the zoned wall-clock view.
foreign import minute :: ZonedDateTime -> Int
-- | Second of the minute in the zoned wall-clock view.
foreign import second :: ZonedDateTime -> Int
-- | Millisecond of the second in the zoned wall-clock view.
foreign import millisecond :: ZonedDateTime -> Int
-- | Microsecond of the millisecond in the zoned wall-clock view.
foreign import microsecond :: ZonedDateTime -> Int
-- | Nanosecond of the microsecond in the zoned wall-clock view.
foreign import nanosecond :: ZonedDateTime -> Int
-- | ISO day of week, from `1` (Monday) to `7` (Sunday).
foreign import dayOfWeek :: ZonedDateTime -> Int
-- | Day number within the year in this zoned date-time's calendar.
foreign import dayOfYear :: ZonedDateTime -> Int
-- | Number of days in the current month.
foreign import daysInMonth :: ZonedDateTime -> Int
-- | Number of days in the current year.
foreign import daysInYear :: ZonedDateTime -> Int
-- | Number of days in the current week according to the calendar.
foreign import daysInWeek :: ZonedDateTime -> Int
-- | Number of months in the current year.
foreign import monthsInYear :: ZonedDateTime -> Int
-- | Whether the current year is a leap year in this calendar.
foreign import inLeapYear :: ZonedDateTime -> Boolean
-- | Identifier of the current calendar (for example `"iso8601"`).
foreign import calendarId :: ZonedDateTime -> String
-- | Identifier of the associated time zone (for example `"America/New_York"`).
foreign import timeZoneId :: ZonedDateTime -> String
-- | Numeric UTC offset string for this instant in the associated time zone.
foreign import offset :: ZonedDateTime -> String
-- | UTC offset for this instant, in nanoseconds.
foreign import offsetNanoseconds :: ZonedDateTime -> Int
-- | Number of wall-clock hours in this calendar day in the associated time zone.
foreign import hoursInDay :: ZonedDateTime -> Int
-- | Milliseconds since the Unix epoch for the represented instant.
foreign import epochMilliseconds :: ZonedDateTime -> Number
-- | Nanoseconds since the Unix epoch for the represented instant.
foreign import epochNanoseconds :: ZonedDateTime -> BigInt

foreign import _weekOfYear :: ZonedDateTime -> Nullable Int

-- | Week number within the year, if the calendar defines week numbering.
weekOfYear :: ZonedDateTime -> Maybe Int
weekOfYear = toMaybe <<< _weekOfYear

foreign import _yearOfWeek :: ZonedDateTime -> Nullable Int

-- | Week-numbering year, if the calendar defines week numbering.
yearOfWeek :: ZonedDateTime -> Maybe Int
yearOfWeek = toMaybe <<< _yearOfWeek

foreign import _era :: ZonedDateTime -> Nullable String

-- | Calendar era name, if this calendar uses eras.
era :: ZonedDateTime -> Maybe String
era = toMaybe <<< _era

foreign import _eraYear :: ZonedDateTime -> Nullable Int

-- | Year number within the current era, if this calendar uses eras.
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

foreign import _add :: forall r. EffectFn3 { | r } Duration ZonedDateTime ZonedDateTime

-- | Adds a duration. Supports calendar durations. Options: overflow.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | start <- ZonedDateTime.fromString_ "2024-01-15T12:00:00-05:00[America/New_York]"
-- | twoHours <- Duration.from { hours: 2 }
-- | later <- ZonedDateTime.add { overflow: Overflow.Constrain } twoHours start
-- | formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
-- | Console.log (JS.Intl.DateTimeFormat.format formatter later)
-- | ```
-- |
-- | ```text
-- | January 15, 2024 at 2:00:00 PM
-- | ```

add
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
add providedOptions duration zonedDateTime =
  Effect.Uncurried.runEffectFn3
    _add
    ( ConvertableOptions.convertOptionsWithDefaults
        ToArithmeticOptions
        defaultArithmeticOptions
        providedOptions
    )
    duration
    zonedDateTime

foreign import _addNoOpts :: EffectFn2 Duration ZonedDateTime ZonedDateTime

-- | Same as [`add`](#add) with default options.
add_ :: Duration -> ZonedDateTime -> Effect ZonedDateTime
add_ = Effect.Uncurried.runEffectFn2 _addNoOpts

foreign import _subtract :: forall r. EffectFn3 { | r } Duration ZonedDateTime ZonedDateTime

-- | Subtracts a duration. Arg order: `subtract options duration subject`.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | zoned <- ZonedDateTime.fromString_ "2024-03-15T14:00:00[America/New_York]"
-- | twoHours <- Duration.from { hours: 2 }
-- | earlier <- ZonedDateTime.subtract { overflow: Overflow.Constrain } twoHours zoned
-- | formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
-- | Console.log (JS.Intl.DateTimeFormat.format formatter earlier)
-- | ```
-- |
-- | ```text
-- | March 15, 2024 at 12:00:00 PM
-- | ```

subtract
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
subtract providedOptions duration zonedDateTime =
  Effect.Uncurried.runEffectFn3
    _subtract
    ( ConvertableOptions.convertOptionsWithDefaults
        ToArithmeticOptions
        defaultArithmeticOptions
        providedOptions
    )
    duration
    zonedDateTime

foreign import _subtractNoOpts :: EffectFn2 Duration ZonedDateTime ZonedDateTime

-- | Same as [`subtract`](#subtract) with default options.

subtract_ :: Duration -> ZonedDateTime -> Effect ZonedDateTime
subtract_ = Effect.Uncurried.runEffectFn2 _subtractNoOpts

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

foreign import _with :: forall ro rf. EffectFn3 { | ro } { | rf } ZonedDateTime ZonedDateTime

-- | Returns a copy with some wall-clock fields replaced. Options: overflow,
-- | disambiguation, offset.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | meeting <- ZonedDateTime.fromString_ "2024-01-15T09:30:45-05:00[America/New_York]"
-- | noon <- ZonedDateTime.with { overflow: Overflow.Constrain } { hour: 12, minute: 0, second: 0 } meeting
-- | formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
-- | Console.log (JS.Intl.DateTimeFormat.format formatter noon)
-- | ```
-- |
-- | ```text
-- | January 15, 2024 at 12:00:00 PM
-- | ```

with
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
with options fields zonedDateTime =
  Effect.Uncurried.runEffectFn3
    _with
    ( ConvertableOptions.convertOptionsWithDefaults
        ToFromOptions
        defaultFromOptions
        options
    )
    fields
    zonedDateTime

foreign import _withNoOpts :: forall r. EffectFn2 { | r } ZonedDateTime ZonedDateTime

-- | Same as [`with`](#with) with default options.
with_
  :: forall fields rest
   . Union fields rest WithFields
  => { | fields }
  -> ZonedDateTime
  -> Effect ZonedDateTime
with_ = Effect.Uncurried.runEffectFn2 _withNoOpts

foreign import _withTimeZone :: EffectFn2 String ZonedDateTime ZonedDateTime

-- | Returns the same instant interpreted in a different time zone.
-- |
-- | ```purescript
-- | zoned <- ZonedDateTime.fromString_ "2024-01-15T12:00:00-05:00[America/New_York]"
-- | inTokyo <- ZonedDateTime.withTimeZone "Asia/Tokyo" zoned
-- | Console.log (ZonedDateTime.toString_ inTokyo)
-- | ```
-- |
-- | ```text
-- | 2024-01-16T02:00:00+09:00[Asia/Tokyo]
-- | ```

withTimeZone :: String -> ZonedDateTime -> Effect ZonedDateTime
withTimeZone = Effect.Uncurried.runEffectFn2 _withTimeZone

foreign import _withCalendar :: EffectFn2 String ZonedDateTime ZonedDateTime

-- | Returns a copy with the same instant and time zone, but a different calendar.
-- |
-- | ```purescript
-- | zoned <- ZonedDateTime.fromString_ "2024-01-15T12:00:00-05:00[America/New_York]"
-- | gregory <- ZonedDateTime.withCalendar "gregory" zoned
-- | Console.log (ZonedDateTime.toString { calendarName: CalendarName.Always } gregory)
-- | ```
-- |
-- | ```text
-- | 2024-01-15T12:00:00-05:00[America/New_York][u-ca=gregory]
-- | ```

withCalendar :: String -> ZonedDateTime -> Effect ZonedDateTime
withCalendar = Effect.Uncurried.runEffectFn2 _withCalendar

foreign import _withPlainTime :: EffectFn2 PlainTime ZonedDateTime ZonedDateTime

-- | Returns a copy with the wall-clock time replaced.
-- |
-- | ```purescript
-- | zoned <- ZonedDateTime.fromString_ "2024-01-15T09:30:45-05:00[America/New_York]"
-- | closingTime <- PlainTime.fromString_ "17:00:00"
-- | updated <- ZonedDateTime.withPlainTime closingTime zoned
-- | Console.log (ZonedDateTime.toString_ updated)
-- | ```
-- |
-- | ```text
-- | 2024-01-15T17:00:00-05:00[America/New_York]
-- | ```

withPlainTime :: PlainTime -> ZonedDateTime -> Effect ZonedDateTime
withPlainTime = Effect.Uncurried.runEffectFn2 _withPlainTime

foreign import _withPlainDate :: EffectFn2 PlainDate ZonedDateTime ZonedDateTime

-- | Returns a copy with the calendar date replaced.
-- |
-- | ```purescript
-- | zoned <- ZonedDateTime.fromString_ "2024-01-15T09:30:45-05:00[America/New_York]"
-- | nextDay <- PlainDate.fromString_ "2024-01-16"
-- | updated <- ZonedDateTime.withPlainDate nextDay zoned
-- | Console.log (ZonedDateTime.toString_ updated)
-- | ```
-- |
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

foreign import _until :: forall r. EffectFn3 { | r } ZonedDateTime ZonedDateTime Duration

-- | Duration from `subject` (last arg) until `other` (second arg). Arg order: `until options other subject`.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | departure <- ZonedDateTime.fromString_ "2020-03-08T11:55:00+08:00[Asia/Hong_Kong]"
-- | arrival <- ZonedDateTime.fromString_ "2020-03-08T09:50:00-07:00[America/Los_Angeles]"
-- | flightTime <- ZonedDateTime.until { largestUnit: TemporalUnit.Hour } arrival departure
-- | formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
-- | Console.log ("Flight time: " <> JS.Intl.DurationFormat.format formatter flightTime)
-- | ```
-- |
-- | ```text
-- | Flight time: 12 hours, 55 minutes
-- | ```

until
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
until providedOptions other zonedDateTime =
  Effect.Uncurried.runEffectFn3
    _until
    ( ConvertableOptions.convertOptionsWithDefaults
        ToDifferenceOptions
        defaultDifferenceOptions
        providedOptions
    )
    other
    zonedDateTime

foreign import _untilNoOpts :: EffectFn2 ZonedDateTime ZonedDateTime Duration

-- | Same as [`until`](#until) with default options. Arg order: `until_ other subject`.

until_ :: ZonedDateTime -> ZonedDateTime -> Effect Duration
until_ = Effect.Uncurried.runEffectFn2 _untilNoOpts

foreign import _since :: forall r. EffectFn3 { | r } ZonedDateTime ZonedDateTime Duration

-- | Duration from `other` to `subject` (inverse of until). Arg order: `since options other subject`.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | start <- ZonedDateTime.fromString_ "2024-01-01T00:00:00[America/New_York]"
-- | end <- ZonedDateTime.fromString_ "2024-03-15T12:00:00[America/New_York]"
-- | elapsed <- ZonedDateTime.since { largestUnit: TemporalUnit.Hour } start end
-- | formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
-- | Console.log ("Elapsed: " <> JS.Intl.DurationFormat.format formatter elapsed)
-- | ```
-- |
-- | ```text
-- | Elapsed: 1,787 hours
-- | ```

since
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
since providedOptions other zonedDateTime =
  Effect.Uncurried.runEffectFn3
    _since
    ( ConvertableOptions.convertOptionsWithDefaults
        ToDifferenceOptions
        defaultDifferenceOptions
        providedOptions
    )
    other
    zonedDateTime

foreign import _sinceNoOpts :: EffectFn2 ZonedDateTime ZonedDateTime Duration

-- | Same as [`since`](#since) with default options. Arg order: `since_ other subject`.

since_ :: ZonedDateTime -> ZonedDateTime -> Effect Duration
since_ = Effect.Uncurried.runEffectFn2 _sinceNoOpts

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
-- | zoned <- ZonedDateTime.fromString_ "2024-01-15T09:30:45.123456789-05:00[America/New_York]"
-- | rounded <- ZonedDateTime.round { smallestUnit: TemporalUnit.Minute, roundingMode: RoundingMode.HalfExpand } zoned
-- | Console.log (ZonedDateTime.toString_ rounded)
-- | ```
-- |
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
-- | zoned <- ZonedDateTime.fromString_ "2024-03-10T12:00:00-04:00[America/New_York]"
-- | start <- ZonedDateTime.startOfDay zoned
-- | Console.log (ZonedDateTime.toString_ start)
-- | ```
-- |
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
-- | zoned <- ZonedDateTime.fromString_ "2024-03-09T12:00:00-05:00[America/New_York]"
-- | case ZonedDateTime.getTimeZoneTransition "next" zoned of
-- |   Nothing -> Console.log "No transition"
-- |   Just transition -> Console.log (ZonedDateTime.toString_ transition)
-- | ```
-- |
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
-- | zoned <- ZonedDateTime.fromString_ "2024-01-15T12:00:00-05:00[America/New_York]"
-- | Console.log (Instant.toString_ (ZonedDateTime.toInstant zoned))
-- | ```
-- |
-- | ```text
-- | 2024-01-15T17:00:00Z
-- | ```

toInstant :: ZonedDateTime -> Instant
toInstant = Function.Uncurried.runFn1 _toInstant

foreign import _toPlainDateTime :: Fn1 ZonedDateTime PlainDateTime

-- | Extracts date and time in the zoned wall-clock view (drops time zone).
-- |
-- | ```purescript
-- | zoned <- ZonedDateTime.fromString_ "2024-01-15T12:00:00-05:00[America/New_York]"
-- | Console.log (PlainDateTime.toString_ (ZonedDateTime.toPlainDateTime zoned))
-- | ```
-- |
-- | ```text
-- | 2024-01-15T12:00:00
-- | ```

toPlainDateTime :: ZonedDateTime -> PlainDateTime
toPlainDateTime = Function.Uncurried.runFn1 _toPlainDateTime

foreign import _toPlainDate :: Fn1 ZonedDateTime PlainDate

-- | Extracts the calendar date in the zoned wall-clock view.
-- |
-- | ```purescript
-- | zoned <- ZonedDateTime.fromString_ "2024-01-15T12:00:00-05:00[America/New_York]"
-- | Console.log (PlainDate.toString_ (ZonedDateTime.toPlainDate zoned))
-- | ```
-- |
-- | ```text
-- | 2024-01-15
-- | ```

toPlainDate :: ZonedDateTime -> PlainDate
toPlainDate = Function.Uncurried.runFn1 _toPlainDate

foreign import _toPlainTime :: Fn1 ZonedDateTime PlainTime

-- | Extracts the wall-clock time in the associated time zone.
-- |
-- | ```purescript
-- | zoned <- ZonedDateTime.fromString_ "2024-01-15T12:00:00-05:00[America/New_York]"
-- | Console.log (PlainTime.toString_ (ZonedDateTime.toPlainTime zoned))
-- | ```
-- |
-- | ```text
-- | 12:00:00
-- | ```

toPlainTime :: ZonedDateTime -> PlainTime
toPlainTime = Function.Uncurried.runFn1 _toPlainTime

foreign import _toPlainYearMonth :: Fn1 ZonedDateTime PlainYearMonth

-- | Extracts the year and month in the zoned wall-clock view.
-- |
-- | ```purescript
-- | zoned <- ZonedDateTime.fromString_ "2024-01-15T12:00:00-05:00[America/New_York]"
-- | Console.log (PlainYearMonth.toString_ (ZonedDateTime.toPlainYearMonth zoned))
-- | ```
-- |
-- | ```text
-- | 2024-01
-- | ```

toPlainYearMonth :: ZonedDateTime -> PlainYearMonth
toPlainYearMonth = Function.Uncurried.runFn1 _toPlainYearMonth

foreign import _toPlainMonthDay :: Fn1 ZonedDateTime PlainMonthDay

-- | Extracts the month and day in the zoned wall-clock view.
-- |
-- | ```purescript
-- | zoned <- ZonedDateTime.fromString_ "2024-01-15T12:00:00-05:00[America/New_York]"
-- | Console.log (PlainMonthDay.toString_ (ZonedDateTime.toPlainMonthDay zoned))
-- | ```
-- |
-- | ```text
-- | 01-15
-- | ```

toPlainMonthDay :: ZonedDateTime -> PlainMonthDay
toPlainMonthDay = Function.Uncurried.runFn1 _toPlainMonthDay

-- Serialization (toString_ from Internal)

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

-- | Same as [`toString`](#tostring) with default options.
toString_ :: ZonedDateTime -> String
toString_ zonedDateTime = Function.Uncurried.runFn2 _toString defaultToStringOptions zonedDateTime

-- | Serializes to ISO 8601 format with time zone. Options: calendarName, timeZoneName, offset, fractionalSecondDigits, smallestUnit, roundingMode.
-- |
-- | ```purescript
-- | zoned <- ZonedDateTime.fromString_ "2024-01-15T12:00:00.123456789-05:00[America/New_York]"
-- | Console.log
-- |   ( ZonedDateTime.toString
-- |       { smallestUnit: TemporalUnit.Minute
-- |       , calendarName: CalendarName.Never
-- |       }
-- |       zoned
-- |   )
-- | ```
-- |
-- | ```text
-- | 2024-01-15T12:00-05:00[America/New_York]
-- | ```

toString
  :: forall provided
   . ConvertOptionsWithDefaults
       ToToStringOptions
       { | ToStringOptions }
       { | provided }
       { | ToStringOptions }
  => { | provided }
  -> ZonedDateTime
  -> String
toString providedOptions zonedDateTime =
  Function.Uncurried.runFn2
    _toString
    ( ConvertableOptions.convertOptionsWithDefaults
        ToToStringOptions
        defaultToStringOptions
        providedOptions
    )
    zonedDateTime

-- Instances (Eq, Ord, Show from Internal)
