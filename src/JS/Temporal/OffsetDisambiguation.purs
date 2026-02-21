-- | How to handle a time zone offset when it conflicts with the provided
-- | offset (e.g. when parsing or constructing ZonedDateTime). Used in
-- | `from` options for ZonedDateTime.
-- | See <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Temporal/ZonedDateTime/from>
module JS.Temporal.OffsetDisambiguation
  ( OffsetDisambiguation(..)
  , toString
  , fromString
  ) where

import Prelude
import Data.Maybe (Maybe(..))

-- | Strategy for resolving offset mismatches.
data OffsetDisambiguation
  = Use
  | Ignore
  | Reject
  | Prefer

derive instance Eq OffsetDisambiguation

-- | Converts an OffsetDisambiguation to its JavaScript string value.
toString :: OffsetDisambiguation -> String
toString = case _ of
  Use -> "use"
  Ignore -> "ignore"
  Reject -> "reject"
  Prefer -> "prefer"

-- | Parses a JavaScript offsetDisambiguation string. Returns Nothing for unknown values.
fromString :: String -> Maybe OffsetDisambiguation
fromString = case _ of
  "use" -> Just Use
  "ignore" -> Just Ignore
  "reject" -> Just Reject
  "prefer" -> Just Prefer
  _ -> Nothing
