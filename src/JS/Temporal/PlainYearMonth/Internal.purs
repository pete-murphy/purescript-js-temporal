module JS.Temporal.PlainYearMonth.Internal
  ( PlainYearMonth
  , equals
  , compare
  , toString_
  ) where

import Data.Function.Uncurried (Fn2)
import Data.Function.Uncurried as Function.Uncurried
import JS.Temporal.Internal (intToOrdering)
import Prelude hiding (compare)

foreign import data PlainYearMonth :: Type

foreign import _equals :: Fn2 PlainYearMonth PlainYearMonth Boolean
foreign import _compare :: Fn2 PlainYearMonth PlainYearMonth Int
-- | Default ISO 8601 serialization (no options). Prefer over `toString {}`.
foreign import toString_ :: PlainYearMonth -> String

equals :: PlainYearMonth -> PlainYearMonth -> Boolean
equals a b = Function.Uncurried.runFn2 _equals a b

compare :: PlainYearMonth -> PlainYearMonth -> Ordering
compare a b = intToOrdering (Function.Uncurried.runFn2 _compare a b)

instance Eq PlainYearMonth where
  eq = equals

instance Ord PlainYearMonth where
  compare = compare

instance Show PlainYearMonth where
  show = toString_
