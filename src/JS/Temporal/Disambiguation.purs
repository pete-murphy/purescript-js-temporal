-- | How to disambiguate when a local date/time occurs twice or not at all
-- | (e.g. during daylight saving transitions). Used when converting between
-- | PlainDateTime and ZonedDateTime.
-- | See <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Temporal/ZonedDateTime/from>
module JS.Temporal.Disambiguation
  ( Disambiguation(..)
  , toString
  , fromString
  ) where

import Prelude
import Data.Maybe (Maybe(..))

-- | Strategy for resolving ambiguous wall-clock times.
data Disambiguation
  = Compatible
  | Earlier
  | Later
  | Reject

derive instance Eq Disambiguation

-- | Converts a Disambiguation to its JavaScript string value.
toString :: Disambiguation -> String
toString = case _ of
  Compatible -> "compatible"
  Earlier -> "earlier"
  Later -> "later"
  Reject -> "reject"

-- | Parses a JavaScript disambiguation string. Returns Nothing for unknown values.
fromString :: String -> Maybe Disambiguation
fromString = case _ of
  "compatible" -> Just Compatible
  "earlier" -> Just Earlier
  "later" -> Just Later
  "reject" -> Just Reject
  _ -> Nothing
