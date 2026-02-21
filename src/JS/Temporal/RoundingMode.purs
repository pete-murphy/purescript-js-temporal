-- | Rounding modes for Temporal `round`, `until`, `since`, and `total` operations.
-- | Used to control how values are rounded when converting between units or
-- | truncating sub-unit precision. See
-- | <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Temporal#rounding>
module JS.Temporal.RoundingMode
  ( RoundingMode(..)
  , toString
  , fromString
  ) where

import Prelude
import Data.Maybe (Maybe(..))

-- | How to round when a value falls between two representable units.
data RoundingMode
  = Ceil
  | Floor
  | Expand
  | Trunc
  | HalfCeil
  | HalfFloor
  | HalfExpand
  | HalfTrunc
  | HalfEven

derive instance Eq RoundingMode

-- | Converts a RoundingMode to its JavaScript string value (e.g. `HalfEven` → `"halfEven"`).
toString :: RoundingMode -> String
toString = case _ of
  Ceil -> "ceil"
  Floor -> "floor"
  Expand -> "expand"
  Trunc -> "trunc"
  HalfCeil -> "halfCeil"
  HalfFloor -> "halfFloor"
  HalfExpand -> "halfExpand"
  HalfTrunc -> "halfTrunc"
  HalfEven -> "halfEven"

-- | Parses a JavaScript rounding mode string. Returns Nothing for unknown values.
fromString :: String -> Maybe RoundingMode
fromString = case _ of
  "ceil" -> Just Ceil
  "floor" -> Just Floor
  "expand" -> Just Expand
  "trunc" -> Just Trunc
  "halfCeil" -> Just HalfCeil
  "halfFloor" -> Just HalfFloor
  "halfExpand" -> Just HalfExpand
  "halfTrunc" -> Just HalfTrunc
  "halfEven" -> Just HalfEven
  _ -> Nothing
