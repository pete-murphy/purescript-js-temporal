-- | Units of time used in Temporal arithmetic, rounding, and difference operations.
-- | Calendar units (year, month, week) require a calendar reference for conversion;
-- | time units (day and smaller) represent fixed durations.
-- | See <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Temporal#temporal_units>
module JS.Temporal.TemporalUnit
  ( TemporalUnit(..)
  , toString
  , fromString
  ) where

import Prelude
import Data.Maybe (Maybe(..))

-- | A unit of time: calendar units (Year, Month, Week), day, or sub-day units.
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

-- | Converts a TemporalUnit to its JavaScript string value (e.g. `Microsecond` → `"microsecond"`).
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

-- | Parses a JavaScript temporal unit string. Returns Nothing for unknown values.
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
