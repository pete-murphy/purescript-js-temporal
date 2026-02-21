module JS.Temporal.Duration.Internal
  ( Duration
  , toString_
  ) where

import Prelude

foreign import data Duration :: Type

foreign import years :: Duration -> Int
foreign import months :: Duration -> Int
foreign import weeks :: Duration -> Int
foreign import days :: Duration -> Int
foreign import hours :: Duration -> Int
foreign import minutes :: Duration -> Int
foreign import seconds :: Duration -> Int
foreign import milliseconds :: Duration -> Int
foreign import microseconds :: Duration -> Int
foreign import nanoseconds :: Duration -> Int
foreign import toString_ :: Duration -> String

instance Eq Duration where
  eq a b =
    years a == years b
      && months a == months b
      && weeks a == weeks b
      && days a == days b
      && hours a == hours b
      && minutes a == minutes b
      && seconds a == seconds b
      && milliseconds a == milliseconds b
      && microseconds a == microseconds b
      && nanoseconds a == nanoseconds b

instance Show Duration where
  show = toString_
