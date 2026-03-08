-- | A date and time (year, month, day, hour, minute, etc.) without time zone.
-- | Use for wall-clock times that are not tied to a specific instant (e.g. "Jan 15,
-- | 2024 at 3pm"). Combine with a time zone to get a ZonedDateTime.
-- |
-- | See <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Temporal/PlainDateTime>
module JS.Temporal.PlainDateTime
  ( module JS.Temporal.PlainDateTime.Internal
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
  , hour
  , minute
  , second
  , millisecond
  , microsecond
  , nanosecond
  -- * Arithmetic
  , add
  , add_
  , subtract
  , subtract_
  -- * Manipulation
  , with
  , with_
  , withPlainTime
  , withCalendar
  -- * Difference
  , until
  , until_
  , since
  , since_
  -- * Round
  , round
  -- * Serialization
  , toString
  , toString_
  -- * Conversions
  , fromDateTime
  , toDateTime
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
import Data.DateTime (DateTime(..))
import Data.DateTime as DateTime
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
import JS.Temporal.PlainDate as PlainDate
import JS.Temporal.PlainDate.Internal (PlainDate)
import JS.Temporal.PlainDateTime.Internal (PlainDateTime)
import JS.Temporal.PlainTime as PlainTime
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
  )

foreign import _new :: forall r. EffectFn1 { | r } PlainDateTime

-- | Creates a PlainDateTime from component fields. Corresponds to `Temporal.PlainDateTime()`.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | dateTime <- PlainDateTime.new
-- |   { year: 2024
-- |   , month: 1
-- |   , day: 15
-- |   , hour: 9
-- |   , minute: 30
-- |   , second: 0
-- |   }
-- | formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
-- | Console.log (JS.Intl.DateTimeFormat.format formatter dateTime)
-- | ```
-- |
-- | ```text
-- | January 15, 2024 at 9:30:00 AM
-- | ```

new
  :: forall provided rest
   . Union provided rest PlainDateTimeComponents
  => { | provided }
  -> Effect PlainDateTime
new = Effect.Uncurried.runEffectFn1 _new

type OverflowOptions = (overflow :: String)

data ToOverflowOptions = ToOverflowOptions

defaultOverflowOptions :: { | OverflowOptions }
defaultOverflowOptions = Unsafe.Coerce.unsafeCoerce {}

instance ConvertOption ToOverflowOptions "overflow" Overflow String where
  convertOption _ _ = Overflow.toString

instance ConvertOption ToOverflowOptions "overflow" String String where
  convertOption _ _ = identity

foreign import _from :: forall r. EffectFn2 { | r } String PlainDateTime

-- | Parses a date-time string (e.g. `"2024-01-15T15:30:00"`). Options: overflow.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | dateTime <- PlainDateTime.from { overflow: Overflow.Constrain } "2024-01-15T09:30:00"
-- | formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
-- | Console.log (JS.Intl.DateTimeFormat.format formatter dateTime)
-- | ```
-- |
-- | ```text
-- | January 15, 2024 at 9:30:00 AM
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
  -> Effect PlainDateTime
from providedOptions str =
  Effect.Uncurried.runEffectFn2
    _from
    ( ConvertableOptions.convertOptionsWithDefaults
        ToOverflowOptions
        defaultOverflowOptions
        providedOptions
    )
    str

foreign import _fromNoOpts :: EffectFn1 String PlainDateTime

-- | Same as [`from`](#from) with default options.

from_ :: String -> Effect PlainDateTime
from_ = Effect.Uncurried.runEffectFn1 _fromNoOpts

-- Properties

-- | ISO calendar year number.
foreign import year :: PlainDateTime -> Int
-- | Month number within the year.
foreign import month :: PlainDateTime -> Int
-- | Day of the month.
foreign import day :: PlainDateTime -> Int
-- | Calendar-specific month code, such as `M01`.
foreign import monthCode :: PlainDateTime -> String
-- | Day of the week, from `1` (Monday) to `7` (Sunday).
foreign import dayOfWeek :: PlainDateTime -> Int
-- | Day number within the year.
foreign import dayOfYear :: PlainDateTime -> Int
-- | Number of days in the month.
foreign import daysInMonth :: PlainDateTime -> Int
-- | Number of days in the year.
foreign import daysInYear :: PlainDateTime -> Int
-- | Number of days in the week for this calendar.
foreign import daysInWeek :: PlainDateTime -> Int
-- | Number of months in the year for this calendar.
foreign import monthsInYear :: PlainDateTime -> Int
-- | Whether the year is a leap year in this calendar.
foreign import inLeapYear :: PlainDateTime -> Boolean
-- | Calendar identifier, such as `"iso8601"`.
foreign import calendarId :: PlainDateTime -> String

foreign import _weekOfYear :: PlainDateTime -> Nullable Int

-- | Week number within the year when defined by the calendar.
weekOfYear :: PlainDateTime -> Maybe Int
weekOfYear = toMaybe <<< _weekOfYear

foreign import _yearOfWeek :: PlainDateTime -> Nullable Int

-- | Week-numbering year when defined by the calendar.
yearOfWeek :: PlainDateTime -> Maybe Int
yearOfWeek = toMaybe <<< _yearOfWeek

foreign import _era :: PlainDateTime -> Nullable String

-- | Era identifier when the calendar uses eras.
era :: PlainDateTime -> Maybe String
era = toMaybe <<< _era

foreign import _eraYear :: PlainDateTime -> Nullable Int

-- | Year number within the current era when available.
eraYear :: PlainDateTime -> Maybe Int
eraYear = toMaybe <<< _eraYear

-- | Hour component.
foreign import hour :: PlainDateTime -> Int
-- | Minute component.
foreign import minute :: PlainDateTime -> Int
-- | Second component.
foreign import second :: PlainDateTime -> Int
-- | Millisecond component.
foreign import millisecond :: PlainDateTime -> Int
-- | Microsecond component.
foreign import microsecond :: PlainDateTime -> Int
-- | Nanosecond component.
foreign import nanosecond :: PlainDateTime -> Int

-- Arithmetic

foreign import _add :: forall r. EffectFn3 { | r } Duration PlainDateTime PlainDateTime

-- | Adds a duration. Arg order: `add options duration subject`. Options: overflow.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | start <- PlainDateTime.from_ "2024-01-15T09:00:00"
-- | twoHours <- Duration.new { hours: 2 }
-- | end <- PlainDateTime.add { overflow: Overflow.Constrain } twoHours start
-- | formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
-- | Console.log (JS.Intl.DateTimeFormat.format formatter end)
-- | ```
-- |
-- | ```text
-- | January 15, 2024 at 11:00:00 AM
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
  -> PlainDateTime
  -> Effect PlainDateTime
add providedOptions duration plainDateTime =
  Effect.Uncurried.runEffectFn3
    _add
    ( ConvertableOptions.convertOptionsWithDefaults
        ToOverflowOptions
        defaultOverflowOptions
        providedOptions
    )
    duration
    plainDateTime

foreign import _addNoOpts :: EffectFn2 Duration PlainDateTime PlainDateTime

-- | Same as [`add`](#add) with default options.

add_ :: Duration -> PlainDateTime -> Effect PlainDateTime
add_ = Effect.Uncurried.runEffectFn2 _addNoOpts

foreign import _subtract :: forall r. EffectFn3 { | r } Duration PlainDateTime PlainDateTime

-- | Subtracts a duration. Arg order: `subtract options duration subject` (subject minus duration).
-- | Options: overflow.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | start <- PlainDateTime.from_ "2024-01-15T11:00:00"
-- | twoHours <- Duration.new { hours: 2 }
-- | earlier <- PlainDateTime.subtract { overflow: Overflow.Constrain } twoHours start
-- | formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
-- | Console.log (JS.Intl.DateTimeFormat.format formatter earlier)
-- | ```
-- |
-- | ```text
-- | January 15, 2024 at 9:00:00 AM
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
  -> PlainDateTime
  -> Effect PlainDateTime
subtract providedOptions duration plainDateTime =
  Effect.Uncurried.runEffectFn3
    _subtract
    ( ConvertableOptions.convertOptionsWithDefaults
        ToOverflowOptions
        defaultOverflowOptions
        providedOptions
    )
    duration
    plainDateTime

foreign import _subtractNoOpts :: EffectFn2 Duration PlainDateTime PlainDateTime

-- | Same as [`subtract`](#subtract) with default options.

subtract_ :: Duration -> PlainDateTime -> Effect PlainDateTime
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

foreign import _with :: forall ro rf. EffectFn3 { | ro } { | rf } PlainDateTime PlainDateTime

-- | Returns a new PlainDateTime with specified fields replaced. Options: overflow.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | dateTime <- PlainDateTime.from_ "2024-01-15T09:30:45"
-- | noon <- PlainDateTime.with { overflow: Overflow.Constrain } { hour: 12, minute: 0, second: 0 } dateTime
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
       ToOverflowOptions
       { | OverflowOptions }
       { | optsProvided }
       { | OverflowOptions }
  => { | optsProvided }
  -> { | fields }
  -> PlainDateTime
  -> Effect PlainDateTime
with options fields plainDateTime =
  Effect.Uncurried.runEffectFn3
    _with
    ( ConvertableOptions.convertOptionsWithDefaults
        ToOverflowOptions
        defaultOverflowOptions
        options
    )
    fields
    plainDateTime

foreign import _withNoOpts :: forall r. EffectFn2 { | r } PlainDateTime PlainDateTime

-- | Same as [`with`](#with) with default options.

with_
  :: forall fields rest
   . Union fields rest WithFields
  => { | fields }
  -> PlainDateTime
  -> Effect PlainDateTime
with_ = Effect.Uncurried.runEffectFn2 _withNoOpts

foreign import _withPlainTime :: EffectFn2 PlainTime PlainDateTime PlainDateTime

-- | Returns a new PlainDateTime with the time component replaced.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | dateTime <- PlainDateTime.from_ "2024-01-15T09:30:00"
-- | closingTime <- PlainTime.from_ "17:00:00"
-- | updated <- PlainDateTime.withPlainTime closingTime dateTime
-- | formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
-- | Console.log (JS.Intl.DateTimeFormat.format formatter updated)
-- | ```
-- |
-- | ```text
-- | January 15, 2024 at 5:00:00 PM
-- | ```

withPlainTime :: PlainTime -> PlainDateTime -> Effect PlainDateTime
withPlainTime = Effect.Uncurried.runEffectFn2 _withPlainTime

foreign import _withCalendar :: EffectFn2 String PlainDateTime PlainDateTime

-- | Returns a new PlainDateTime that uses a different calendar.
-- |
-- | ```purescript
-- | dateTime <- PlainDateTime.from_ "2019-05-01T09:30:00"
-- | japanese <- PlainDateTime.withCalendar "japanese" dateTime
-- | Console.log (PlainDateTime.calendarId japanese)
-- | ```
-- |
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

foreign import _until :: forall r. EffectFn3 { | r } PlainDateTime PlainDateTime Duration

-- | Computes the duration from `subject` (last arg) until `other` (second arg).
-- | Positive when `other` is later. Arg order: `until options other subject`.
-- |
-- | Options: largestUnit, smallestUnit, roundingIncrement, roundingMode.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | now <- Now.plainDateTimeISO_
-- |   >>= PlainDateTime.round { smallestUnit: TemporalUnit.Second }
-- | nextBilling <- do
-- |   aprilFirst <- PlainDateTime.new
-- |     { year: PlainDateTime.year now
-- |     , month: 4
-- |     , day: 1
-- |     }
-- |   if aprilFirst < now then do
-- |     oneYear <- Duration.new { years: 1 }
-- |     PlainDateTime.add_ oneYear aprilFirst
-- |   else
-- |     pure aprilFirst
-- |
-- | duration <- PlainDateTime.until
-- |   { smallestUnit: TemporalUnit.Day }
-- |   nextBilling
-- |   now
-- | durationFormatter <- JS.Intl.DurationFormat.new [ locale ] { style: JS.Intl.Options.DurationFormatStyle.Long }
-- | Console.log (JS.Intl.DurationFormat.format durationFormatter duration <> " until next billing")
-- | ```
-- |
-- | ```text
-- | 23 days until next billing
-- | ```

until
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
until providedOptions other plainDateTime =
  Effect.Uncurried.runEffectFn3
    _until
    ( ConvertableOptions.convertOptionsWithDefaults
        ToDifferenceOptions
        defaultDifferenceOptions
        providedOptions
    )
    other
    plainDateTime

foreign import _untilNoOpts :: EffectFn2 PlainDateTime PlainDateTime Duration

-- | Same as [`until`](#until) with default options.

until_ :: PlainDateTime -> PlainDateTime -> Effect Duration
until_ = Effect.Uncurried.runEffectFn2 _untilNoOpts

foreign import _since :: forall r. EffectFn3 { | r } PlainDateTime PlainDateTime Duration

-- | Duration from `other` to `subject` (inverse of until). Arg order: `since options other subject`.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | start <- PlainDateTime.from_ "2024-01-01T00:00:00"
-- | end <- PlainDateTime.from_ "2024-03-15T12:00:00"
-- | elapsed <- PlainDateTime.since { largestUnit: TemporalUnit.Day } start end
-- | formatter <- JS.Intl.DurationFormat.new [ locale ] { style: JS.Intl.Options.DurationFormatStyle.Long }
-- | Console.log ("Elapsed: " <> JS.Intl.DurationFormat.format formatter elapsed)
-- | ```
-- |
-- | ```text
-- | Elapsed: 74 days, 12 hours
-- | ```

since
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
since providedOptions other plainDateTime =
  Effect.Uncurried.runEffectFn3
    _since
    ( ConvertableOptions.convertOptionsWithDefaults
        ToDifferenceOptions
        defaultDifferenceOptions
        providedOptions
    )
    other
    plainDateTime

foreign import _sinceNoOpts :: EffectFn2 PlainDateTime PlainDateTime Duration

-- | Same as [`since`](#since) with default options.

since_ :: PlainDateTime -> PlainDateTime -> Effect Duration
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

foreign import _round :: forall r. EffectFn2 { | r } PlainDateTime PlainDateTime

-- | Rounds to a specified unit. Options: smallestUnit, roundingIncrement, roundingMode.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | dateTime <- PlainDateTime.from_ "2024-01-15T09:30:45.123"
-- | rounded <- PlainDateTime.round { smallestUnit: TemporalUnit.Minute } dateTime
-- | formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
-- | Console.log (JS.Intl.DateTimeFormat.format formatter rounded)
-- | ```
-- |
-- | ```text
-- | January 15, 2024 at 9:31:00 AM
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

-- Comparison (equals, compare from Internal)

-- Serialization (toString_ from Internal)

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

-- | Default ISO 8601 serialization (no options). Prefer over `toString {}`.
-- |
-- | ```purescript
-- | dateTime <- PlainDateTime.from_ "2024-01-15T09:30:00"
-- | Console.log (PlainDateTime.toString_ dateTime)
-- | ```
-- |
-- | ```text
-- | 2024-01-15T09:30:00
-- | ```

toString_ :: PlainDateTime -> String
toString_ plainDateTime = Function.Uncurried.runFn2 _toString defaultToStringOptions plainDateTime

-- | Serializes to ISO 8601 format. Options: fractionalSecondDigits, smallestUnit, roundingMode, calendarName.
-- |
-- | ```purescript
-- | dateTime <- PlainDateTime.from_ "2024-01-15T09:30:00"
-- | Console.log (PlainDateTime.toString { smallestUnit: TemporalUnit.Minute } dateTime)
-- | ```
-- |
-- | ```text
-- | 2024-01-15T09:30
-- | ```

toString
  :: forall provided
   . ConvertOptionsWithDefaults
       ToToStringOptions
       { | ToStringOptions }
       { | provided }
       { | ToStringOptions }
  => { | provided }
  -> PlainDateTime
  -> String
toString providedOptions plainDateTime =
  Function.Uncurried.runFn2
    _toString
    ( ConvertableOptions.convertOptionsWithDefaults
        ToToStringOptions
        defaultToStringOptions
        providedOptions
    )
    plainDateTime

-- Instances (Eq, Ord, Show from Internal)

-- Conversions

-- | Converts a purescript-datetime `DateTime` to a `PlainDateTime`.
fromDateTime :: DateTime -> Effect PlainDateTime
fromDateTime dateTime = do
  plainDate <- PlainDate.fromDate (DateTime.date dateTime)
  plainTime <- PlainTime.fromTime (DateTime.time dateTime)
  pure (PlainDate.toPlainDateTime plainTime plainDate)

-- | Converts a `PlainDateTime` to a purescript-datetime `DateTime`.
toDateTime :: PlainDateTime -> DateTime
toDateTime plainDateTime =
  DateTime
    (PlainDate.toDate (toPlainDate plainDateTime))
    (PlainTime.toTime (toPlainTime plainDateTime))

foreign import _toPlainDate :: Fn1 PlainDateTime PlainDate

-- | Extracts the date component.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | dateTime <- PlainDateTime.from_ "2024-01-15T09:30:00"
-- | date <- pure (PlainDateTime.toPlainDate dateTime)
-- | formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
-- | Console.log (JS.Intl.DateTimeFormat.format formatter date)
-- | ```
-- |
-- | ```text
-- | January 15, 2024
-- | ```

toPlainDate :: PlainDateTime -> PlainDate
toPlainDate = Function.Uncurried.runFn1 _toPlainDate

foreign import _toPlainTime :: Fn1 PlainDateTime PlainTime

-- | Extracts the time component.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | dateTime <- PlainDateTime.from_ "2024-01-15T09:30:00"
-- | time <- pure (PlainDateTime.toPlainTime dateTime)
-- | formatter <- JS.Intl.DateTimeFormat.new [ locale ] { timeStyle: "medium" }
-- | Console.log (JS.Intl.DateTimeFormat.format formatter time)
-- | ```
-- |
-- | ```text
-- | 9:30:00 AM
-- | ```

toPlainTime :: PlainDateTime -> PlainTime
toPlainTime = Function.Uncurried.runFn1 _toPlainTime

foreign import _toZonedDateTime :: EffectFn2 String PlainDateTime ZonedDateTime

-- | Interprets this date-time as occurring in the given time zone.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | plain <- PlainDateTime.from_ "2024-01-15T09:30:00"
-- | zoned <- PlainDateTime.toZonedDateTime "America/New_York" plain
-- | formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
-- | Console.log (JS.Intl.DateTimeFormat.format formatter zoned)
-- | ```
-- |
-- | ```text
-- | January 15, 2024 at 9:30:00 AM
-- | ```

toZonedDateTime :: String -> PlainDateTime -> Effect ZonedDateTime
toZonedDateTime = Effect.Uncurried.runEffectFn2 _toZonedDateTime
