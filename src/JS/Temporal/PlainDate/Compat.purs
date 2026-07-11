-- | Conversions between `PlainDate` and the
-- | [`datetime`](https://pursuit.purescript.org/packages/purescript-datetime)
-- | `Data.Date.Date` type.
module JS.Temporal.PlainDate.Compat
  ( fromDate
  , toDate
  ) where

import Data.Date (Date)
import Data.Date as Date
import Data.Enum (fromEnum, toEnum)
import Data.Maybe (fromJust)
import Effect (Effect)
import JS.Temporal.PlainDate as PlainDate
import JS.Temporal.PlainDate.Internal (PlainDate)
import Partial.Unsafe (unsafePartial)

-- | Converts a purescript-datetime `Date` to a `PlainDate`.
-- |
-- | ```purescript
-- | exampleFromDate :: Effect Unit
-- | exampleFromDate = do
-- |   let date = Gen.evalGen genDate genState
-- |   plainDate <- PlainDate.Compat.fromDate date
-- |   Console.log (PlainDate.toString plainDate)
-- | ```
-- | ---
-- | ```text
-- | 1984-05-21
-- | ```
fromDate :: Date -> Effect PlainDate
fromDate date = PlainDate.from { year: fromEnum (Date.year date), month: fromEnum (Date.month date), day: fromEnum (Date.day date) }

-- | Converts a `PlainDate` to a purescript-datetime `Date`.
-- |
-- | ```purescript
-- | exampleToDate :: Effect Unit
-- | exampleToDate = do
-- |   date <- PlainDate.fromString "2024-07-01"
-- |   let d = PlainDate.Compat.toDate date
-- |   Console.log ("PureScript Date year: " <> show (fromEnum (Date.year d)))
-- | ```
-- | ---
-- | ```text
-- | PureScript Date year: 2024
-- | ```
toDate :: PlainDate -> Date
toDate plainDate =
  Date.canonicalDate
    (unsafePartial fromJust (toEnum (PlainDate.year plainDate)))
    (unsafePartial fromJust (toEnum (PlainDate.month plainDate)))
    (unsafePartial fromJust (toEnum (PlainDate.day plainDate)))
