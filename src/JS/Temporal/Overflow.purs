-- | Overflow handling when constructing or manipulating Temporal date/time values.
-- | Constrain clamps invalid values to the nearest valid range; Reject throws.
-- | See <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Temporal#overflow_handling>
module JS.Temporal.Overflow
  ( Overflow(..)
  , toString
  , fromString
  ) where

import Prelude
import Data.Maybe (Maybe(..))

-- | How to handle out-of-range values (e.g. day 31 in February).
data Overflow
  = Constrain
  | Reject

derive instance Eq Overflow

-- | Converts an Overflow to its JavaScript string value.
toString :: Overflow -> String
toString = case _ of
  Constrain -> "constrain"
  Reject -> "reject"

-- | Parses a JavaScript overflow string. Returns Nothing for unknown values.
fromString :: String -> Maybe Overflow
fromString = case _ of
  "constrain" -> Just Constrain
  "reject" -> Just Reject
  _ -> Nothing
