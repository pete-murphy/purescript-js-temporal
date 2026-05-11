-- | A month and day without year or time zone. Use for recurring dates (e.g.
-- | birthdays, annual events). Requires a year for conversion to PlainDate.
-- |
-- | See <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Temporal/PlainMonthDay>
module JS.Temporal.PlainMonthDay
  ( module JS.Temporal.PlainMonthDay.Internal
  -- * Construction
  , PlainMonthDayComponents
  , fromWithOptions
  , from
  , fromStringWithOptions
  , fromString
  -- * Properties
  , monthCode
  , day
  , calendarId
  -- * Manipulation
  , withWithOptions
  , with
  -- * Conversions
  , toPlainDate
  -- * Serialization
  , toStringWithOptions
  , toString
  -- * Options
  , ToOverflowOptions
  , ToToStringOptions
  ) where

import Prelude

import ConvertableOptions (class ConvertOption, class ConvertOptionsWithDefaults)
import ConvertableOptions as ConvertableOptions
import Data.Function.Uncurried (Fn2)
import Data.Function.Uncurried as Function.Uncurried
import Effect (Effect)
import Effect.Uncurried (EffectFn1, EffectFn2, EffectFn3)
import Effect.Uncurried as Effect.Uncurried
import JS.Temporal.Options.CalendarName (CalendarName)
import JS.Temporal.Options.CalendarName as CalendarName
import JS.Temporal.Options.Overflow (Overflow)
import JS.Temporal.Options.Overflow as Overflow
import JS.Temporal.PlainDate.Internal (PlainDate)
import JS.Temporal.PlainMonthDay.Internal (PlainMonthDay)
import Prim.Row (class Union)
import Unsafe.Coerce as Unsafe.Coerce

-- Construction

type PlainMonthDayComponents =
  ( month :: Int
  , day :: Int
  , year :: Int
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

foreign import _fromRecordWithOptions :: forall ro rc. EffectFn2 { | ro } { | rc } PlainMonthDay

-- | Creates a PlainMonthDay from component fields. Options: overflow.
-- |
-- | ```purescript
-- | exampleFromWithOptions :: Effect Unit
-- | exampleFromWithOptions = do
-- |   holiday <- PlainMonthDay.fromWithOptions { overflow: Overflow.Constrain } { month: 7, day: 4 }
-- |   Console.log (PlainMonthDay.toString holiday)
-- | ```
-- |
-- | ```text
-- | 07-04
-- | ```

fromWithOptions
  :: forall optsProvided provided rest
   . Union provided rest PlainMonthDayComponents
  => ConvertOptionsWithDefaults
       ToOverflowOptions
       { | OverflowOptions }
       { | optsProvided }
       { | OverflowOptions }
  => { | optsProvided }
  -> { | provided }
  -> Effect PlainMonthDay
fromWithOptions providedOptions components =
  Effect.Uncurried.runEffectFn2
    _fromRecordWithOptions
    ( ConvertableOptions.convertOptionsWithDefaults
        ToOverflowOptions
        defaultOverflowOptions
        providedOptions
    )
    components

foreign import _fromRecord :: forall r. EffectFn1 { | r } PlainMonthDay

-- | Same as [`fromWithOptions`](#fromWithOptions) with default options.
-- |
-- | ```purescript
-- | exampleFrom :: Effect Unit
-- | exampleFrom = do
-- |   locale <- JS.Intl.Locale.new_ "en-US"
-- |   holiday <- PlainMonthDay.from { month: 7, day: 4 }
-- |   holidayIn2024 <- PlainMonthDay.toPlainDate { year: 2024 } holiday
-- |   formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
-- |   Console.log (JS.Intl.DateTimeFormat.format formatter holidayIn2024)
-- |
-- | exampleFromStringWithOptions :: Effect Unit
-- | exampleFromStringWithOptions = do
-- |   birthday <- PlainMonthDay.fromStringWithOptions { overflow: Overflow.Constrain } "12-15"
-- |   Console.log (PlainMonthDay.toString birthday)
-- |
-- | exampleFromString :: Effect Unit
-- | exampleFromString = do
-- |   birthday <- PlainMonthDay.fromString "12-15"
-- |   Console.log (PlainMonthDay.toString birthday)
-- | ```
-- |
-- | ```text
-- | July 4, 2024
-- | ```

from
  :: forall provided rest
   . Union provided rest PlainMonthDayComponents
  => { | provided }
  -> Effect PlainMonthDay
from = Effect.Uncurried.runEffectFn1 _fromRecord

foreign import _fromStringWithOptions :: forall r. EffectFn2 { | r } String PlainMonthDay

-- | Creates a PlainMonthDay from an RFC 9557 / ISO 8601 month-day string
-- | (e.g. `"12-15"` or `"--01-15"`). Options: overflow.
-- |
-- | ```purescript
-- | exampleFromStringWithOptions :: Effect Unit
-- | exampleFromStringWithOptions = do
-- |   birthday <- PlainMonthDay.fromStringWithOptions { overflow: Overflow.Constrain } "12-15"
-- |   Console.log (PlainMonthDay.toString birthday)
-- | ```
-- |
-- | ```text
-- | 12-15
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
  -> Effect PlainMonthDay
fromStringWithOptions providedOptions str =
  Effect.Uncurried.runEffectFn2
    _fromStringWithOptions
    ( ConvertableOptions.convertOptionsWithDefaults
        ToOverflowOptions
        defaultOverflowOptions
        providedOptions
    )
    str

foreign import _fromString :: EffectFn1 String PlainMonthDay

-- | Same as [`fromStringWithOptions`](#fromstring) with default options.
-- |
-- | ```purescript
-- | exampleFromString :: Effect Unit
-- | exampleFromString = do
-- |   birthday <- PlainMonthDay.fromString "12-15"
-- |   Console.log (PlainMonthDay.toString birthday)
-- | ```
-- |
-- | ```text
-- | 12-15
-- | ```

fromString :: String -> Effect PlainMonthDay
fromString = Effect.Uncurried.runEffectFn1 _fromString

-- Properties

-- | Calendar-specific month code, such as `M12`.
-- |
-- | ```purescript
-- | exampleMonthCode :: Effect Unit
-- | exampleMonthCode = do
-- |   mday <- PlainMonthDay.fromString "03-14"
-- |   Console.log ("Month code: " <> PlainMonthDay.monthCode mday)
-- | ```
-- |
-- | ```text
-- | Month code: M03
-- | ```

foreign import monthCode :: PlainMonthDay -> String
-- | Day of the month.
-- |
-- | ```purescript
-- | exampleDay :: Effect Unit
-- | exampleDay = do
-- |   mday <- PlainMonthDay.fromString "03-14"
-- |   Console.log ("Day: " <> show (PlainMonthDay.day mday))
-- | ```
-- |
-- | ```text
-- | Day: 14
-- | ```

foreign import day :: PlainMonthDay -> Int
-- | Calendar identifier, such as `"iso8601"`.
-- |
-- | ```purescript
-- | exampleCalendarId :: Effect Unit
-- | exampleCalendarId = do
-- |   mday <- PlainMonthDay.fromString "03-14"
-- |   Console.log ("Calendar: " <> PlainMonthDay.calendarId mday)
-- | ```
-- |
-- | ```text
-- | Calendar: iso8601
-- | ```

foreign import calendarId :: PlainMonthDay -> String

-- Manipulation

type WithFields =
  ( monthCode :: String
  , day :: Int
  )

foreign import _withWithOptions :: forall ro rf. EffectFn3 { | ro } { | rf } PlainMonthDay PlainMonthDay

-- | Returns a new PlainMonthDay with specified fields replaced. Options: overflow.
-- |
-- | ```purescript
-- | exampleWithWithOptions :: Effect Unit
-- | exampleWithWithOptions = do
-- |   original <- PlainMonthDay.fromString "01-15"
-- |   changed <- PlainMonthDay.withWithOptions { overflow: Overflow.Constrain } { day: 31 } original
-- |   Console.log (PlainMonthDay.toString changed)
-- | ```
-- |
-- | ```text
-- | 01-31
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
  -> PlainMonthDay
  -> Effect PlainMonthDay
withWithOptions options fields plainMonthDay =
  Effect.Uncurried.runEffectFn3
    _withWithOptions
    ( ConvertableOptions.convertOptionsWithDefaults
        ToOverflowOptions
        defaultOverflowOptions
        options
    )
    fields
    plainMonthDay

foreign import _with :: forall r. EffectFn2 { | r } PlainMonthDay PlainMonthDay

-- | Same as [`withWithOptions`](#withWithOptions) with default options.
-- |
-- | ```purescript
-- | exampleWith :: Effect Unit
-- | exampleWith = do
-- |   original <- PlainMonthDay.fromString "01-15"
-- |   changed <- PlainMonthDay.with { day: 28 } original
-- |   Console.log (PlainMonthDay.toString changed)
-- | ```
-- |
-- | ```text
-- | 01-28
-- | ```

with
  :: forall fields rest
   . Union fields rest WithFields
  => { | fields }
  -> PlainMonthDay
  -> Effect PlainMonthDay
with = Effect.Uncurried.runEffectFn2 _with

-- Conversions

foreign import _toPlainDate :: EffectFn2 { year :: Int } PlainMonthDay PlainDate

-- | Converts to PlainDate by supplying a year.
-- |
-- | ```purescript
-- | exampleToPlainDate :: Effect Unit
-- | exampleToPlainDate = do
-- |   locale <- JS.Intl.Locale.new_ "en-US"
-- |   birthday <- PlainMonthDay.fromString "12-15"
-- |   birthdayIn2030 <- PlainMonthDay.toPlainDate { year: 2030 } birthday
-- |   formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
-- |   Console.log ("Birthday in 2030: " <> JS.Intl.DateTimeFormat.format formatter birthdayIn2030)
-- | ```
-- |
-- | ```text
-- | Birthday in 2030: December 15, 2030
-- | ```

toPlainDate :: { year :: Int } -> PlainMonthDay -> Effect PlainDate
toPlainDate = Effect.Uncurried.runEffectFn2 _toPlainDate

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

foreign import _toString :: forall r. Fn2 { | r } PlainMonthDay String

-- | Same as [`toStringWithOptions`](#tostring) with default options.
-- |
-- | ```purescript
-- | exampleToString :: Effect Unit
-- | exampleToString = do
-- |   mday <- PlainMonthDay.fromString "03-14"
-- |   Console.log (PlainMonthDay.toString mday)
-- | ```
-- |
-- | ```text
-- | 03-14
-- | ```

toString :: PlainMonthDay -> String
toString plainMonthDay = Function.Uncurried.runFn2 _toString defaultToStringOptions plainMonthDay

-- | Serializes to ISO 8601 month-day format. Options: calendarName.
-- |
-- | ```purescript
-- | exampleToStringWithOptions :: Effect Unit
-- | exampleToStringWithOptions = do
-- |   mday <- PlainMonthDay.fromString "03-14"
-- |   Console.log (PlainMonthDay.toStringWithOptions {} mday)
-- | ```
-- |
-- | ```text
-- | 03-14
-- | ```

toStringWithOptions
  :: forall provided
   . ConvertOptionsWithDefaults
       ToToStringOptions
       { | ToStringOptions }
       { | provided }
       { | ToStringOptions }
  => { | provided }
  -> PlainMonthDay
  -> String
toStringWithOptions providedOptions plainMonthDay =
  Function.Uncurried.runFn2
    _toString
    ( ConvertableOptions.convertOptionsWithDefaults
        ToToStringOptions
        defaultToStringOptions
        providedOptions
    )
    plainMonthDay

-- Instances (Eq, Show from Internal)
