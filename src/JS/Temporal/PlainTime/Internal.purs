module JS.Temporal.PlainTime.Internal
  ( PlainTime
  , equals
  , compare
  , toString_
  ) where

import Data.Function.Uncurried (Fn2)
import Data.Function.Uncurried as Function.Uncurried
import JS.Temporal.Internal (intToOrdering)
import Prelude hiding (compare)

foreign import data PlainTime :: Type

foreign import _equals :: Fn2 PlainTime PlainTime Boolean
foreign import _compare :: Fn2 PlainTime PlainTime Int
-- | Default ISO 8601 serialization (no options). Prefer over `toString {}`.
foreign import toString_ :: PlainTime -> String

equals :: PlainTime -> PlainTime -> Boolean
equals a b = Function.Uncurried.runFn2 _equals a b

compare :: PlainTime -> PlainTime -> Ordering
compare a b = intToOrdering (Function.Uncurried.runFn2 _compare a b)

instance Eq PlainTime where
  eq = equals

instance Ord PlainTime where
  compare = compare

instance Show PlainTime where
  show = toString_
