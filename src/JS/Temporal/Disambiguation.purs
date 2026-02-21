module JS.Temporal.Disambiguation
  ( Disambiguation(..)
  , toString
  , fromString
  ) where

import Prelude
import Data.Maybe (Maybe(..))

data Disambiguation
  = Compatible
  | Earlier
  | Later
  | Reject

derive instance Eq Disambiguation

toString :: Disambiguation -> String
toString = case _ of
  Compatible -> "compatible"
  Earlier -> "earlier"
  Later -> "later"
  Reject -> "reject"

fromString :: String -> Maybe Disambiguation
fromString = case _ of
  "compatible" -> Just Compatible
  "earlier" -> Just Earlier
  "later" -> Just Later
  "reject" -> Just Reject
  _ -> Nothing
