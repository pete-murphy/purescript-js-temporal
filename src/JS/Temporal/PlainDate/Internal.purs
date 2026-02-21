module JS.Temporal.PlainDate.Internal
  ( PlainDate
  , equals
  , compare
  , toString_
  ) where

import Data.Function.Uncurried (Fn2)
import Data.Function.Uncurried as Function.Uncurried
import JS.Temporal.Internal (intToOrdering)
import Prelude hiding (compare)

foreign import data PlainDate :: Type

foreign import _equals :: Fn2 PlainDate PlainDate Boolean
foreign import _compare :: Fn2 PlainDate PlainDate Int
foreign import toString_ :: PlainDate -> String

equals :: PlainDate -> PlainDate -> Boolean
equals a b = Function.Uncurried.runFn2 _equals a b

compare :: PlainDate -> PlainDate -> Ordering
compare a b = intToOrdering (Function.Uncurried.runFn2 _compare a b)

instance Eq PlainDate where
  eq = equals

instance Ord PlainDate where
  compare = compare

instance Show PlainDate where
  show = toString_
