module JS.Temporal.Overflow
  ( Overflow(..)
  , toString
  , fromString
  ) where

import Prelude
import Data.Maybe (Maybe(..))

data Overflow
  = Constrain
  | Reject

derive instance Eq Overflow

toString :: Overflow -> String
toString = case _ of
  Constrain -> "constrain"
  Reject -> "reject"

fromString :: String -> Maybe Overflow
fromString = case _ of
  "constrain" -> Just Constrain
  "reject" -> Just Reject
  _ -> Nothing
