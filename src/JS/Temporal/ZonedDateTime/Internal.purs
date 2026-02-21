module JS.Temporal.ZonedDateTime.Internal
  ( ZonedDateTime
  , equals
  , compare
  , toString_
  ) where

import Data.Function.Uncurried (Fn2)
import Data.Function.Uncurried as Function.Uncurried
import JS.Temporal.Internal (intToOrdering)
import Prelude hiding (compare)

foreign import data ZonedDateTime :: Type

foreign import _equals :: Fn2 ZonedDateTime ZonedDateTime Boolean
foreign import _compare :: Fn2 ZonedDateTime ZonedDateTime Int
foreign import toString_ :: ZonedDateTime -> String

equals :: ZonedDateTime -> ZonedDateTime -> Boolean
equals a b = Function.Uncurried.runFn2 _equals a b

compare :: ZonedDateTime -> ZonedDateTime -> Ordering
compare a b = intToOrdering (Function.Uncurried.runFn2 _compare a b)

instance Eq ZonedDateTime where
  eq = equals

instance Ord ZonedDateTime where
  compare = compare

instance Show ZonedDateTime where
  show = toString_
