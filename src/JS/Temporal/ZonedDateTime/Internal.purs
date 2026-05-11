module JS.Temporal.ZonedDateTime.Internal
  ( ZonedDateTime
  , toString
  ) where

import Prelude hiding (compare)

import Data.Function.Uncurried (Fn2)
import Data.Function.Uncurried as Function.Uncurried
import JS.Intl.DateTimeFormat (class DateTimeLike)
import JS.Temporal.Internal (intToOrdering)
import Unsafe.Coerce as Unsafe.Coerce

foreign import data ZonedDateTime :: Type

foreign import _equals :: Fn2 ZonedDateTime ZonedDateTime Boolean
foreign import _compare :: Fn2 ZonedDateTime ZonedDateTime Int
-- | Default ISO 8601 serialization (no options).
foreign import toString :: ZonedDateTime -> String

instance Eq ZonedDateTime where
  eq a b = Function.Uncurried.runFn2 _equals a b

instance Ord ZonedDateTime where
  compare a b = intToOrdering (Function.Uncurried.runFn2 _compare a b)

instance Show ZonedDateTime where
  show = toString

instance DateTimeLike ZonedDateTime where
  unsafeToDateTimeForeign = Unsafe.Coerce.unsafeCoerce
