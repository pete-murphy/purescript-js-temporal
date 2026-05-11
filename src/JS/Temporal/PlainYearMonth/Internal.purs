module JS.Temporal.PlainYearMonth.Internal
  ( PlainYearMonth
  , toString
  ) where

import Prelude hiding (compare)

import Data.Function.Uncurried (Fn2)
import Data.Function.Uncurried as Function.Uncurried
import JS.Intl.DateTimeFormat (class DateTimeLike)
import JS.Temporal.Internal (intToOrdering)
import Unsafe.Coerce as Unsafe.Coerce

foreign import data PlainYearMonth :: Type

foreign import _equals :: Fn2 PlainYearMonth PlainYearMonth Boolean
foreign import _compare :: Fn2 PlainYearMonth PlainYearMonth Int
-- | Default ISO 8601 serialization (no options).
foreign import toString :: PlainYearMonth -> String

instance Eq PlainYearMonth where
  eq a b = Function.Uncurried.runFn2 _equals a b

instance Ord PlainYearMonth where
  compare a b = intToOrdering (Function.Uncurried.runFn2 _compare a b)

instance Show PlainYearMonth where
  show = toString

instance DateTimeLike PlainYearMonth where
  unsafeToDateTimeForeign = Unsafe.Coerce.unsafeCoerce
