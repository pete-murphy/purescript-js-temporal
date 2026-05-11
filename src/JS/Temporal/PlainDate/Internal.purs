module JS.Temporal.PlainDate.Internal
  ( PlainDate
  , toString
  ) where

import Prelude hiding (compare)

import Data.Function.Uncurried (Fn2)
import Data.Function.Uncurried as Function.Uncurried
import JS.Intl.DateTimeFormat (class DateTimeLike)
import JS.Temporal.Internal (intToOrdering)
import Unsafe.Coerce as Unsafe.Coerce

foreign import data PlainDate :: Type

foreign import _equals :: Fn2 PlainDate PlainDate Boolean
foreign import _compare :: Fn2 PlainDate PlainDate Int
-- | Default ISO 8601 serialization (no options).
foreign import toString :: PlainDate -> String

instance Eq PlainDate where
  eq a b = Function.Uncurried.runFn2 _equals a b

instance Ord PlainDate where
  compare a b = intToOrdering (Function.Uncurried.runFn2 _compare a b)

instance Show PlainDate where
  show = toString

instance DateTimeLike PlainDate where
  unsafeToDateTimeForeign = Unsafe.Coerce.unsafeCoerce
