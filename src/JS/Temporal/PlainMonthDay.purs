-- | A month and day without year or time zone. Use for recurring dates (e.g.
-- | birthdays, annual events). Requires a year for conversion to PlainDate.
-- |
-- | See <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Temporal/PlainMonthDay>
module JS.Temporal.PlainMonthDay
  ( module JS.Temporal.PlainMonthDay.Internal
  -- * Construction
  , new
  , from
  , from_
  -- * Properties
  , monthCode
  , day
  , calendarId
  -- * Manipulation
  , with
  , with_
  -- * Conversions
  , toPlainDate
  -- * Serialization
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
import JS.Temporal.CalendarName (CalendarName)
import JS.Temporal.CalendarName as CalendarName
import JS.Temporal.Overflow (Overflow)
import JS.Temporal.Overflow as Overflow
import JS.Temporal.PlainDate.Internal (PlainDate)
import JS.Temporal.PlainMonthDay.Internal (PlainMonthDay)
import Prim.Row (class Union)
import Unsafe.Coerce as Unsafe.Coerce

-- Construction

foreign import _new :: EffectFn2 Int Int PlainMonthDay

-- | Creates a PlainMonthDay from month and day.
new :: Int -> Int -> Effect PlainMonthDay
new = Effect.Uncurried.runEffectFn2 _new

type OverflowOptions = (overflow :: String)

data ToOverflowOptions = ToOverflowOptions

defaultOverflowOptions :: { | OverflowOptions }
defaultOverflowOptions = Unsafe.Coerce.unsafeCoerce {}

instance ConvertOption ToOverflowOptions "overflow" Overflow String where
  convertOption _ _ = Overflow.toString

instance ConvertOption ToOverflowOptions "overflow" String String where
  convertOption _ _ = identity

foreign import _from :: forall r. EffectFn2 { | r } String PlainMonthDay

-- | Parses a month-day string (e.g. `"01-15"` or `"--01-15"`). Options: overflow.
from
  :: forall provided
   . ConvertOptionsWithDefaults
       ToOverflowOptions
       { | OverflowOptions }
       { | provided }
       { | OverflowOptions }
  => { | provided }
  -> String
  -> Effect PlainMonthDay
from providedOptions str =
  Effect.Uncurried.runEffectFn2
    _from
    ( ConvertableOptions.convertOptionsWithDefaults
        ToOverflowOptions
        defaultOverflowOptions
        providedOptions
    )
    str

foreign import _fromNoOpts :: EffectFn1 String PlainMonthDay

-- | Same as from with default options.
from_ :: String -> Effect PlainMonthDay
from_ = Effect.Uncurried.runEffectFn1 _fromNoOpts

-- Properties

foreign import monthCode :: PlainMonthDay -> String
foreign import day :: PlainMonthDay -> Int
foreign import calendarId :: PlainMonthDay -> String

-- Manipulation

type WithFields =
  ( monthCode :: String
  , day :: Int
  )

foreign import _with :: forall ro rf. EffectFn3 { | ro } { | rf } PlainMonthDay PlainMonthDay

-- | Returns a new PlainMonthDay with specified fields replaced. Options: overflow.
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
  -> PlainMonthDay
  -> Effect PlainMonthDay
with options fields plainMonthDay =
  Effect.Uncurried.runEffectFn3
    _with
    ( ConvertableOptions.convertOptionsWithDefaults
        ToOverflowOptions
        defaultOverflowOptions
        options
    )
    fields
    plainMonthDay

foreign import _withNoOpts :: forall r. EffectFn2 { | r } PlainMonthDay PlainMonthDay

-- | Same as with with default options.
with_
  :: forall fields rest
   . Union fields rest WithFields
  => { | fields }
  -> PlainMonthDay
  -> Effect PlainMonthDay
with_ = Effect.Uncurried.runEffectFn2 _withNoOpts

-- Conversions

foreign import _toPlainDate :: EffectFn2 { year :: Int } PlainMonthDay PlainDate

-- | Converts to PlainDate by supplying a year.
toPlainDate :: { year :: Int } -> PlainMonthDay -> Effect PlainDate
toPlainDate = Effect.Uncurried.runEffectFn2 _toPlainDate

-- Comparison

-- Serialization (toString_ from Internal)

type ToStringOptions = (calendarName :: String)

data ToToStringOptions = ToToStringOptions

defaultToStringOptions :: { | ToStringOptions }
defaultToStringOptions = Unsafe.Coerce.unsafeCoerce {}

instance ConvertOption ToToStringOptions "calendarName" CalendarName String where
  convertOption _ _ = CalendarName.toString

instance ConvertOption ToToStringOptions "calendarName" String String where
  convertOption _ _ = identity

foreign import _toString :: forall r. Fn2 { | r } PlainMonthDay String

-- | Serializes to ISO 8601 month-day format. Options: calendarName.
toString
  :: forall provided
   . ConvertOptionsWithDefaults
       ToToStringOptions
       { | ToStringOptions }
       { | provided }
       { | ToStringOptions }
  => { | provided }
  -> PlainMonthDay
  -> String
toString providedOptions plainMonthDay =
  Function.Uncurried.runFn2
    _toString
    ( ConvertableOptions.convertOptionsWithDefaults
        ToToStringOptions
        defaultToStringOptions
        providedOptions
    )
    plainMonthDay

-- Instances (Eq, Show from Internal)
