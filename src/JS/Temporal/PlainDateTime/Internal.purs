module JS.Temporal.PlainDateTime.Internal
  ( PlainDateTime
  , equals
  , compare
  , toString_
  ) where

import Data.Function.Uncurried (Fn2)
import Data.Function.Uncurried as Function.Uncurried
import JS.Temporal.Internal (intToOrdering)
import Prelude hiding (compare)

foreign import data PlainDateTime :: Type

foreign import _equals :: Fn2 PlainDateTime PlainDateTime Boolean
foreign import _compare :: Fn2 PlainDateTime PlainDateTime Int
-- | Default ISO 8601 serialization (no options). Prefer over `toString {}`.
foreign import toString_ :: PlainDateTime -> String

equals :: PlainDateTime -> PlainDateTime -> Boolean
equals a b = Function.Uncurried.runFn2 _equals a b

compare :: PlainDateTime -> PlainDateTime -> Ordering
compare a b = intToOrdering (Function.Uncurried.runFn2 _compare a b)

instance Eq PlainDateTime where
  eq = equals

instance Ord PlainDateTime where
  compare = compare

instance Show PlainDateTime where
  show = toString_
