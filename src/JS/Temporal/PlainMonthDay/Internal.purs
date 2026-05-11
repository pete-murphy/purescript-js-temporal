module JS.Temporal.PlainMonthDay.Internal
  ( PlainMonthDay
  , toString
  ) where

import Prelude

import Data.Function.Uncurried (Fn2)
import Data.Function.Uncurried as Function.Uncurried
import JS.Intl.DateTimeFormat (class DateTimeLike)
import Unsafe.Coerce as Unsafe.Coerce

foreign import data PlainMonthDay :: Type

foreign import _equals :: Fn2 PlainMonthDay PlainMonthDay Boolean
-- | Default ISO 8601 serialization (no options).
foreign import toString :: PlainMonthDay -> String

instance Eq PlainMonthDay where
  eq a b = Function.Uncurried.runFn2 _equals a b

instance Show PlainMonthDay where
  show = toString

instance DateTimeLike PlainMonthDay where
  unsafeToDateTimeForeign = Unsafe.Coerce.unsafeCoerce
