-- | Options for including calendar identification in `toString` output.
-- | Controls whether the calendar component is included when serializing
-- | date/time values. See
-- | <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Temporal/PlainDate/toString>
module JS.Temporal.CalendarName
  ( CalendarName(..)
  , toString
  , fromString
  ) where

import Prelude
import Data.Maybe (Maybe(..))

-- | When to include the calendar ID in serialized output.
data CalendarName
  = Auto
  | Always
  | Never
  | Critical

derive instance Eq CalendarName

-- | Converts a CalendarName to its JavaScript string value.
toString :: CalendarName -> String
toString = case _ of
  Auto -> "auto"
  Always -> "always"
  Never -> "never"
  Critical -> "critical"

-- | Parses a JavaScript calendarName string. Returns Nothing for unknown values.
fromString :: String -> Maybe CalendarName
fromString = case _ of
  "auto" -> Just Auto
  "always" -> Just Always
  "never" -> Just Never
  "critical" -> Just Critical
  _ -> Nothing
