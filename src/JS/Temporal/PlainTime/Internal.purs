module JS.Temporal.PlainTime.Internal
  ( PlainTime
  , toString
  ) where

import Prelude hiding (compare)

import Data.Function.Uncurried (Fn2)
import Data.Function.Uncurried as Function.Uncurried
import JS.Intl.DateTimeFormat (class DateTimeLike)
import JS.Temporal.Internal (intToOrdering)
import Unsafe.Coerce as Unsafe.Coerce

foreign import data PlainTime :: Type

foreign import _equals :: Fn2 PlainTime PlainTime Boolean
foreign import _compare :: Fn2 PlainTime PlainTime Int
-- | Default ISO 8601 serialization (no options).
foreign import toString :: PlainTime -> String

instance Eq PlainTime where
  eq a b = Function.Uncurried.runFn2 _equals a b

instance Ord PlainTime where
  compare a b = intToOrdering (Function.Uncurried.runFn2 _compare a b)

instance Show PlainTime where
  show = toString

instance DateTimeLike PlainTime where
  unsafeToDateTimeForeign = Unsafe.Coerce.unsafeCoerce
