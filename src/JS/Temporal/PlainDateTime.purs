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
import Data.Function.Uncurried (Fn2, Fn1)
import Data.Function.Uncurried as Function.Uncurried
import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import Effect (Effect)
import Effect.Uncurried (EffectFn1, EffectFn2, EffectFn3)
import Effect.Uncurried as Effect.Uncurried
import Foreign (Foreign)
import Foreign as Foreign
import JS.Temporal.Options.CalendarName (CalendarName)
import JS.Temporal.PlainDate as PlainDate
import JS.Temporal.PlainTime as PlainTime
import JS.Temporal.ZonedDateTime.Internal (ZonedDateTime)
import JS.Temporal.Options.CalendarName as CalendarName
import JS.Temporal.Duration.Internal (Duration)
import JS.Temporal.Options.Overflow (Overflow)
import JS.Temporal.Options.Overflow as Overflow
import JS.Temporal.Options.RoundingMode (RoundingMode)
import JS.Temporal.Options.RoundingMode as RoundingMode
import JS.Temporal.Options.TemporalUnit (TemporalUnit)
import JS.Temporal.Options.TemporalUnit as TemporalUnit
import JS.Temporal.PlainDate.Internal (PlainDate)
import JS.Temporal.PlainDateTime.Internal (PlainDateTime)
import JS.Temporal.PlainTime.Internal (PlainTime)
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

-- | Same as from with default options.
from_ :: String -> Effect PlainDateTime
from_ = Effect.Uncurried.runEffectFn1 _fromNoOpts

-- Properties

foreign import year :: PlainDateTime -> Int
foreign import month :: PlainDateTime -> Int
foreign import day :: PlainDateTime -> Int
foreign import monthCode :: PlainDateTime -> String
foreign import dayOfWeek :: PlainDateTime -> Int
foreign import dayOfYear :: PlainDateTime -> Int
foreign import daysInMonth :: PlainDateTime -> Int
foreign import daysInYear :: PlainDateTime -> Int
foreign import daysInWeek :: PlainDateTime -> Int
foreign import monthsInYear :: PlainDateTime -> Int
foreign import inLeapYear :: PlainDateTime -> Boolean
foreign import calendarId :: PlainDateTime -> String

foreign import _weekOfYear :: PlainDateTime -> Nullable Int

weekOfYear :: PlainDateTime -> Maybe Int
weekOfYear = toMaybe <<< _weekOfYear

foreign import _yearOfWeek :: PlainDateTime -> Nullable Int

yearOfWeek :: PlainDateTime -> Maybe Int
yearOfWeek = toMaybe <<< _yearOfWeek

foreign import _era :: PlainDateTime -> Nullable String

era :: PlainDateTime -> Maybe String
era = toMaybe <<< _era

foreign import _eraYear :: PlainDateTime -> Nullable Int

eraYear :: PlainDateTime -> Maybe Int
eraYear = toMaybe <<< _eraYear

foreign import hour :: PlainDateTime -> Int
foreign import minute :: PlainDateTime -> Int
foreign import second :: PlainDateTime -> Int
foreign import millisecond :: PlainDateTime -> Int
foreign import microsecond :: PlainDateTime -> Int
foreign import nanosecond :: PlainDateTime -> Int

-- Arithmetic

foreign import _add :: forall r. EffectFn3 { | r } Duration PlainDateTime PlainDateTime

-- | Adds a duration. Supports calendar durations. Options: overflow.
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

-- | Same as add with default options.
add_ :: Duration -> PlainDateTime -> Effect PlainDateTime
add_ = Effect.Uncurried.runEffectFn2 _addNoOpts

foreign import _subtract :: forall r. EffectFn3 { | r } Duration PlainDateTime PlainDateTime

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

-- | Same as subtract with default options.
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

with_
  :: forall fields rest
   . Union fields rest WithFields
  => { | fields }
  -> PlainDateTime
  -> Effect PlainDateTime
with_ = Effect.Uncurried.runEffectFn2 _withNoOpts

foreign import _withPlainTime :: EffectFn2 PlainTime PlainDateTime PlainDateTime

withPlainTime :: PlainTime -> PlainDateTime -> Effect PlainDateTime
withPlainTime = Effect.Uncurried.runEffectFn2 _withPlainTime

foreign import _withCalendar :: EffectFn2 String PlainDateTime PlainDateTime

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

until_ :: PlainDateTime -> PlainDateTime -> Effect Duration
until_ = Effect.Uncurried.runEffectFn2 _untilNoOpts

foreign import _since :: forall r. EffectFn3 { | r } PlainDateTime PlainDateTime Duration

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
toString_ :: PlainDateTime -> String
toString_ plainDateTime = Function.Uncurried.runFn2 _toString defaultToStringOptions plainDateTime

-- | Serializes to ISO 8601 format. Options: fractionalSecondDigits, smallestUnit, roundingMode, calendarName.
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
-- | See docs/purescript-datetime-interop.md.
fromDateTime :: DateTime -> Effect PlainDateTime
fromDateTime dateTime = do
  plainDate <- PlainDate.fromDate (DateTime.date dateTime)
  plainTime <- PlainTime.fromTime (DateTime.time dateTime)
  pure (PlainDate.toPlainDateTime plainTime plainDate)

-- | Converts a `PlainDateTime` to a purescript-datetime `DateTime`.
-- | See docs/purescript-datetime-interop.md.
toDateTime :: PlainDateTime -> DateTime
toDateTime plainDateTime =
  DateTime
    (PlainDate.toDate (toPlainDate plainDateTime))
    (PlainTime.toTime (toPlainTime plainDateTime))

foreign import _toPlainDate :: Fn1 PlainDateTime PlainDate

-- | Extracts the date component.
toPlainDate :: PlainDateTime -> PlainDate
toPlainDate = Function.Uncurried.runFn1 _toPlainDate

foreign import _toPlainTime :: Fn1 PlainDateTime PlainTime

-- | Extracts the time component.
toPlainTime :: PlainDateTime -> PlainTime
toPlainTime = Function.Uncurried.runFn1 _toPlainTime

foreign import _toZonedDateTime :: EffectFn2 String PlainDateTime ZonedDateTime

-- | Interprets this date-time as occurring in the given time zone.
toZonedDateTime :: String -> PlainDateTime -> Effect ZonedDateTime
toZonedDateTime = Effect.Uncurried.runEffectFn2 _toZonedDateTime