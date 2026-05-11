-- | Opaque wrapper for `Temporal.Instant`. Re-exported from `JS.Temporal.Instant`.
module JS.Temporal.Instant.Internal
  ( Instant
  , toString
  ) where

import Prelude hiding (compare)

import Data.Function.Uncurried (Fn2)
import Data.Function.Uncurried as Function.Uncurried
import JS.Intl.DateTimeFormat (class DateTimeLike)
import JS.Temporal.Internal (intToOrdering)
import Unsafe.Coerce as Unsafe.Coerce

-- | A point in time (opaque type).
foreign import data Instant :: Type

foreign import _equals :: Fn2 Instant Instant Boolean
foreign import _compare :: Fn2 Instant Instant Int
-- | Default ISO 8601 serialization (no options).
foreign import toString :: Instant -> String

instance Eq Instant where
  eq a b = Function.Uncurried.runFn2 _equals a b

instance Ord Instant where
  compare a b = intToOrdering (Function.Uncurried.runFn2 _compare a b)

instance Show Instant where
  show = toString

instance DateTimeLike Instant where
  unsafeToDateTimeForeign = Unsafe.Coerce.unsafeCoerce
