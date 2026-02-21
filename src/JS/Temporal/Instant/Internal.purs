-- | Opaque wrapper for `Temporal.Instant`. Re-exported from `JS.Temporal.Instant`.
module JS.Temporal.Instant.Internal
  ( Instant
  , equals
  , compare
  , toString_
  ) where

import Data.Function.Uncurried (Fn2)
import Data.Function.Uncurried as Function.Uncurried
import JS.Temporal.Internal (intToOrdering)
import Prelude hiding (compare)

-- | A point in time (opaque type).
foreign import data Instant :: Type

foreign import _equals :: Fn2 Instant Instant Boolean
foreign import _compare :: Fn2 Instant Instant Int
-- | Default ISO 8601 serialization (no options). Prefer over `toString {}`.
foreign import toString_ :: Instant -> String

equals :: Instant -> Instant -> Boolean
equals a b = Function.Uncurried.runFn2 _equals a b

compare :: Instant -> Instant -> Ordering
compare a b = intToOrdering (Function.Uncurried.runFn2 _compare a b)

instance Eq Instant where
  eq = equals

instance Ord Instant where
  compare = compare

instance Show Instant where
  show = toString_
