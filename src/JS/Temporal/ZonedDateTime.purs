-- | A date and time with time zone, representing a unique instant plus a
-- | time zone and calendar. Use when you need an absolute point in time
-- | with human-readable components in a specific zone.
-- |
-- | See <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Temporal/ZonedDateTime>
module JS.Temporal.ZonedDateTime
  ( module JS.Temporal.ZonedDateTime.Internal
  -- * Construction
  , new
  , from
  , from_
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
import JS.Temporal.Options.CalendarName (CalendarName)
import JS.Temporal.Options.CalendarName as CalendarName
import JS.Temporal.Options.Disambiguation (Disambiguation)
import JS.Temporal.Options.Disambiguation as Disambiguation
import JS.Temporal.Duration.Internal (Duration)
import JS.Temporal.Options.OffsetDisambiguation (OffsetDisambiguation)
import JS.Temporal.Options.OffsetDisambiguation as OffsetDisambiguation
import JS.Temporal.Options.Overflow (Overflow)
import JS.Temporal.Options.Overflow as Overflow
import JS.Temporal.Instant.Internal (Instant)
import JS.Temporal.PlainDate.Internal (PlainDate)
import JS.Temporal.PlainMonthDay.Internal (PlainMonthDay)
import JS.Temporal.PlainYearMonth.Internal (PlainYearMonth)
import JS.Temporal.PlainDateTime.Internal (PlainDateTime)
import JS.Temporal.PlainTime.Internal (PlainTime)
import JS.Temporal.Options.RoundingMode (RoundingMode)
import JS.Temporal.Options.RoundingMode as RoundingMode
import JS.Temporal.Options.TemporalUnit (TemporalUnit)
import JS.Temporal.Options.TemporalUnit as TemporalUnit
import JS.Temporal.ZonedDateTime.Internal (ZonedDateTime)
import Prim.Row (class Union)
import Unsafe.Coerce as Unsafe.Coerce

-- Construction

foreign import _new :: EffectFn2 BigInt String ZonedDateTime

-- | Creates a ZonedDateTime from epoch nanoseconds and a time zone ID.
new :: BigInt -> String -> Effect ZonedDateTime
new = Effect.Uncurried.runEffectFn2 _new

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

foreign import _from :: forall r. EffectFn2 { | r } String ZonedDateTime

-- | Parses an ISO 8601 string with time zone (e.g. `"2024-01-15T12:00-05:00[America/New_York]"`). Options: overflow, disambiguation, offset.
from
  :: forall provided
   . ConvertOptionsWithDefaults
       ToFromOptions
       { | FromOptions }
       { | provided }
       { | FromOptions }
  => { | provided }
  -> String
  -> Effect ZonedDateTime
from providedOptions str =
  Effect.Uncurried.runEffectFn2
    _from
    ( ConvertableOptions.convertOptionsWithDefaults
        ToFromOptions
        defaultFromOptions
        providedOptions
    )
    str

foreign import _fromNoOpts :: EffectFn1 String ZonedDateTime

-- | Same as from with default options.
from_ :: String -> Effect ZonedDateTime
from_ = Effect.Uncurried.runEffectFn1 _fromNoOpts

-- Properties

foreign import year :: ZonedDateTime -> Int
foreign import month :: ZonedDateTime -> Int
foreign import day :: ZonedDateTime -> Int
foreign import monthCode :: ZonedDateTime -> String
foreign import hour :: ZonedDateTime -> Int
foreign import minute :: ZonedDateTime -> Int
foreign import second :: ZonedDateTime -> Int
foreign import millisecond :: ZonedDateTime -> Int
foreign import microsecond :: ZonedDateTime -> Int
foreign import nanosecond :: ZonedDateTime -> Int
foreign import dayOfWeek :: ZonedDateTime -> Int
foreign import dayOfYear :: ZonedDateTime -> Int
foreign import daysInMonth :: ZonedDateTime -> Int
foreign import daysInYear :: ZonedDateTime -> Int
foreign import daysInWeek :: ZonedDateTime -> Int
foreign import monthsInYear :: ZonedDateTime -> Int
foreign import inLeapYear :: ZonedDateTime -> Boolean
foreign import calendarId :: ZonedDateTime -> String
foreign import timeZoneId :: ZonedDateTime -> String
foreign import offset :: ZonedDateTime -> String
foreign import offsetNanoseconds :: ZonedDateTime -> Int
foreign import hoursInDay :: ZonedDateTime -> Int
foreign import epochMilliseconds :: ZonedDateTime -> Number
foreign import epochNanoseconds :: ZonedDateTime -> BigInt

foreign import _weekOfYear :: ZonedDateTime -> Nullable Int

weekOfYear :: ZonedDateTime -> Maybe Int
weekOfYear = toMaybe <<< _weekOfYear

foreign import _yearOfWeek :: ZonedDateTime -> Nullable Int

yearOfWeek :: ZonedDateTime -> Maybe Int
yearOfWeek = toMaybe <<< _yearOfWeek

foreign import _era :: ZonedDateTime -> Nullable String

era :: ZonedDateTime -> Maybe String
era = toMaybe <<< _era

foreign import _eraYear :: ZonedDateTime -> Nullable Int

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

-- | Same as add with default options.
add_ :: Duration -> ZonedDateTime -> Effect ZonedDateTime
add_ = Effect.Uncurried.runEffectFn2 _addNoOpts

foreign import _subtract :: forall r. EffectFn3 { | r } Duration ZonedDateTime ZonedDateTime

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

with_
  :: forall fields rest
   . Union fields rest WithFields
  => { | fields }
  -> ZonedDateTime
  -> Effect ZonedDateTime
with_ = Effect.Uncurried.runEffectFn2 _withNoOpts

foreign import _withTimeZone :: EffectFn2 String ZonedDateTime ZonedDateTime

withTimeZone :: String -> ZonedDateTime -> Effect ZonedDateTime
withTimeZone = Effect.Uncurried.runEffectFn2 _withTimeZone

foreign import _withCalendar :: EffectFn2 String ZonedDateTime ZonedDateTime

withCalendar :: String -> ZonedDateTime -> Effect ZonedDateTime
withCalendar = Effect.Uncurried.runEffectFn2 _withCalendar

foreign import _withPlainTime :: EffectFn2 PlainTime ZonedDateTime ZonedDateTime

withPlainTime :: PlainTime -> ZonedDateTime -> Effect ZonedDateTime
withPlainTime = Effect.Uncurried.runEffectFn2 _withPlainTime

foreign import _withPlainDate :: EffectFn2 PlainDate ZonedDateTime ZonedDateTime

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

until_ :: ZonedDateTime -> ZonedDateTime -> Effect Duration
until_ = Effect.Uncurried.runEffectFn2 _untilNoOpts

foreign import _since :: forall r. EffectFn3 { | r } ZonedDateTime ZonedDateTime Duration

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
getTimeZoneTransition :: String -> ZonedDateTime -> Maybe ZonedDateTime
getTimeZoneTransition direction zonedDateTime =
  Function.Uncurried.runFn4 _getTimeZoneTransition Nothing Just direction zonedDateTime

-- Conversions

foreign import _toInstant :: Fn1 ZonedDateTime Instant

-- | Extracts the absolute instant (no time zone).
toInstant :: ZonedDateTime -> Instant
toInstant = Function.Uncurried.runFn1 _toInstant

foreign import _toPlainDateTime :: Fn1 ZonedDateTime PlainDateTime

-- | Extracts date and time in the zoned wall-clock view (drops time zone).
toPlainDateTime :: ZonedDateTime -> PlainDateTime
toPlainDateTime = Function.Uncurried.runFn1 _toPlainDateTime

foreign import _toPlainDate :: Fn1 ZonedDateTime PlainDate

toPlainDate :: ZonedDateTime -> PlainDate
toPlainDate = Function.Uncurried.runFn1 _toPlainDate

foreign import _toPlainTime :: Fn1 ZonedDateTime PlainTime

toPlainTime :: ZonedDateTime -> PlainTime
toPlainTime = Function.Uncurried.runFn1 _toPlainTime

foreign import _toPlainYearMonth :: Fn1 ZonedDateTime PlainYearMonth

toPlainYearMonth :: ZonedDateTime -> PlainYearMonth
toPlainYearMonth = Function.Uncurried.runFn1 _toPlainYearMonth

foreign import _toPlainMonthDay :: Fn1 ZonedDateTime PlainMonthDay

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

-- | Default ISO 8601 serialization (no options). Prefer over `toString {}`.
toString_ :: ZonedDateTime -> String
toString_ zonedDateTime = Function.Uncurried.runFn2 _toString defaultToStringOptions zonedDateTime

-- | Serializes to ISO 8601 format with time zone. Options: calendarName, timeZoneName, offset, fractionalSecondDigits, smallestUnit, roundingMode.
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
