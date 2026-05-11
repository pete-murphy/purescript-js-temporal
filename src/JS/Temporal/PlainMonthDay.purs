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

-- | Creates a PlainMonthDay fromWithOptions component fields. Options: overflow.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | holiday <- PlainMonthDay.from { month: 7, day: 4 }
-- | holidayIn2024 <- PlainMonthDay.toPlainDate { year: 2024 } holiday
-- | formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
-- | Console.log (JS.Intl.DateTimeFormat.format formatter holidayIn2024)
-- | ```
-- |
-- | ```text
-- | July 4, 2024
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

-- | Same as [`fromWithOptions`](#fromWithOptions) withWithOptions default options.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | holiday <- PlainMonthDay.from { month: 7, day: 4 }
-- | holidayIn2024 <- PlainMonthDay.toPlainDate { year: 2024 } holiday
-- | formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
-- | Console.log (JS.Intl.DateTimeFormat.format formatter holidayIn2024)
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

-- | Creates a PlainMonthDay fromWithOptions an RFC 9557 / ISO 8601 month-day string
-- | (e.g. `"12-15"` or `"--01-15"`). Options: overflow.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | birthday <- PlainMonthDay.fromStringWithOptions { overflow: Overflow.Constrain } "12-15"
-- | birthdayIn2024 <- PlainMonthDay.toPlainDate { year: 2024 } birthday
-- | formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
-- | Console.log ("Birthday: " <> JS.Intl.DateTimeFormat.format formatter birthdayIn2024)
-- | ```
-- |
-- | ```text
-- | Birthday: December 15, 2024
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

-- | Same as [`fromStringWithOptions`](#fromstring) withWithOptions default options.

fromString :: String -> Effect PlainMonthDay
fromString = Effect.Uncurried.runEffectFn1 _fromString

-- Properties

-- | Calendar-specific month code, such as `M12`.
foreign import monthCode :: PlainMonthDay -> String
-- | Day of the month.
foreign import day :: PlainMonthDay -> Int
-- | Calendar identifier, such as `"iso8601"`.
foreign import calendarId :: PlainMonthDay -> String

-- Manipulation

type WithFields =
  ( monthCode :: String
  , day :: Int
  )

foreign import _withWithOptions :: forall ro rf. EffectFn3 { | ro } { | rf } PlainMonthDay PlainMonthDay

-- | Returns a new PlainMonthDay withWithOptions specified fields replaced. Options: overflow.
-- |
-- | ```purescript
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | original <- PlainMonthDay.fromString "01-15"
-- | changed <- PlainMonthDay.withWithOptions { overflow: Overflow.Constrain } { day: 31 } original
-- | changedIn2024 <- PlainMonthDay.toPlainDate { year: 2024 } changed
-- | formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
-- | Console.log (JS.Intl.DateTimeFormat.format formatter changedIn2024)
-- | ```
-- |
-- | ```text
-- | January 31, 2024
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

-- | Same as [`withWithOptions`](#withWithOptions) withWithOptions default options.

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
-- | locale <- JS.Intl.Locale.new_ "en-US"
-- | birthday <- PlainMonthDay.fromString "12-15"
-- | birthdayIn2030 <- PlainMonthDay.toPlainDate { year: 2030 } birthday
-- | formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
-- | Console.log ("Birthday in 2030: " <> JS.Intl.DateTimeFormat.format formatter birthdayIn2030)
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

-- | Same as [`toStringWithOptions`](#tostring) withWithOptions default options.

toString :: PlainMonthDay -> String
toString plainMonthDay = Function.Uncurried.runFn2 _toString defaultToStringOptions plainMonthDay

-- | Serializes to ISO 8601 month-day format. Options: calendarName.
-- |
-- | ```purescript
-- | mday <- PlainMonthDay.fromString "03-14"
-- | Console.log (PlainMonthDay.toStringWithOptions {} mday)
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
