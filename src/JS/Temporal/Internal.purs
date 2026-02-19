module JS.Temporal.Internal
  ( intToOrdering
  ) where

import Prelude

intToOrdering :: Int -> Ordering
intToOrdering n
  | n < 0 = LT
  | n > 0 = GT
  | otherwise = EQ
