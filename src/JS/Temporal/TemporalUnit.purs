module JS.Temporal.TemporalUnit
  ( TemporalUnit(..)
  , toString
  , fromString
  ) where

import Data.Maybe (Maybe(..))

data TemporalUnit
  = Year
  | Month
  | Week
  | Day
  | Hour
  | Minute
  | Second
  | Millisecond
  | Microsecond
  | Nanosecond

derive instance Eq TemporalUnit

toString :: TemporalUnit -> String
toString = case _ of
  Year -> "year"
  Month -> "month"
  Week -> "week"
  Day -> "day"
  Hour -> "hour"
  Minute -> "minute"
  Second -> "second"
  Millisecond -> "millisecond"
  Microsecond -> "microsecond"
  Nanosecond -> "nanosecond"

fromString :: String -> Maybe TemporalUnit
fromString = case _ of
  "year" -> Just Year
  "month" -> Just Month
  "week" -> Just Week
  "day" -> Just Day
  "hour" -> Just Hour
  "minute" -> Just Minute
  "second" -> Just Second
  "millisecond" -> Just Millisecond
  "microsecond" -> Just Microsecond
  "nanosecond" -> Just Nanosecond
  _ -> Nothing
