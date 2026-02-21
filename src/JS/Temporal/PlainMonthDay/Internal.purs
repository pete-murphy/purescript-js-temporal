module JS.Temporal.PlainMonthDay.Internal
  ( PlainMonthDay
  , equals
  , toString_
  ) where

import Data.Function.Uncurried (Fn2)
import Data.Function.Uncurried as Function.Uncurried
import Prelude

foreign import data PlainMonthDay :: Type

foreign import _equals :: Fn2 PlainMonthDay PlainMonthDay Boolean
foreign import toString_ :: PlainMonthDay -> String

equals :: PlainMonthDay -> PlainMonthDay -> Boolean
equals a b = Function.Uncurried.runFn2 _equals a b

instance Eq PlainMonthDay where
  eq = equals

instance Show PlainMonthDay where
  show = toString_
