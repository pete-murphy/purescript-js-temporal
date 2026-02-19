module JS.Temporal.CalendarName
  ( CalendarName(..)
  , toString
  , fromString
  ) where

import Data.Maybe (Maybe(..))

data CalendarName
  = Auto
  | Always
  | Never
  | Critical

derive instance Eq CalendarName

toString :: CalendarName -> String
toString = case _ of
  Auto -> "auto"
  Always -> "always"
  Never -> "never"
  Critical -> "critical"

fromString :: String -> Maybe CalendarName
fromString = case _ of
  "auto" -> Just Auto
  "always" -> Just Always
  "never" -> Just Never
  "critical" -> Just Critical
  _ -> Nothing
