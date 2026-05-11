module JS.Temporal.PlainMonthDay.Internal
  ( PlainMonthDay
  , equals
  , toString
  ) where

import Prelude

import Data.Function.Uncurried (Fn2)
import Data.Function.Uncurried as Function.Uncurried
import JS.Intl.DateTimeFormat (class DateTimeLike)
import Unsafe.Coerce as Unsafe.Coerce

foreign import data PlainMonthDay :: Type

foreign import _equals :: Fn2 PlainMonthDay PlainMonthDay Boolean
-- | Default ISO 8601 serialization (no options). Prefer over `toString {}`.
foreign import toString :: PlainMonthDay -> String

equals :: PlainMonthDay -> PlainMonthDay -> Boolean
equals a b = Function.Uncurried.runFn2 _equals a b

instance Eq PlainMonthDay where
  eq = equals

instance Show PlainMonthDay where
  show = toString

instance DateTimeLike PlainMonthDay where
  unsafeToDateTimeForeign = Unsafe.Coerce.unsafeCoerce
