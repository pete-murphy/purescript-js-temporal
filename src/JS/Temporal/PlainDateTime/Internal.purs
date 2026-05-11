module JS.Temporal.PlainDateTime.Internal
  ( PlainDateTime
  , toString
  ) where

import Prelude hiding (compare)

import Data.Function.Uncurried (Fn2)
import Data.Function.Uncurried as Function.Uncurried
import JS.Intl.DateTimeFormat (class DateTimeLike)
import JS.Temporal.Internal (intToOrdering)
import Unsafe.Coerce as Unsafe.Coerce

foreign import data PlainDateTime :: Type

foreign import _equals :: Fn2 PlainDateTime PlainDateTime Boolean
foreign import _compare :: Fn2 PlainDateTime PlainDateTime Int
-- | Default ISO 8601 serialization (no options).
foreign import toString :: PlainDateTime -> String

instance Eq PlainDateTime where
  eq a b = Function.Uncurried.runFn2 _equals a b

instance Ord PlainDateTime where
  compare a b = intToOrdering (Function.Uncurried.runFn2 _compare a b)

instance Show PlainDateTime where
  show = toString

instance DateTimeLike PlainDateTime where
  unsafeToDateTimeForeign = Unsafe.Coerce.unsafeCoerce
