-- | Conversions between `PlainYearMonth` and its
-- | [`datetime`](https://pursuit.purescript.org/packages/purescript-datetime)
-- | `Data.Date.Component` parts.
module JS.Temporal.PlainYearMonth.Compat
  ( fromYearAndMonth
  , toYearAndMonth
  ) where

import Data.Date (Month, Year)
import Data.Enum (fromEnum, toEnum)
import Data.Maybe (fromJust)
import Effect (Effect)
import JS.Temporal.PlainYearMonth as PlainYearMonth
import JS.Temporal.PlainYearMonth.Internal (PlainYearMonth)
import Partial.Unsafe (unsafePartial)

-- | Creates a `PlainYearMonth` from purescript-datetime `Year` and `Month`
-- | components.
-- |
-- | ```purescript
-- | exampleFromYearAndMonth :: Effect Unit
-- | exampleFromYearAndMonth = do
-- |   let date = Gen.evalGen genDate genState
-- |   yearMonth <- PlainYearMonth.Compat.fromYearAndMonth (Date.year date) (Date.month date)
-- |   Console.log (PlainYearMonth.toString yearMonth)
-- | ```
-- | ---
-- | ```text
-- | 1984-05
-- | ```
fromYearAndMonth :: Year -> Month -> Effect PlainYearMonth
fromYearAndMonth year month = PlainYearMonth.from { year: fromEnum year, month: fromEnum month }

-- | Converts a `PlainYearMonth` to its purescript-datetime `Year` and `Month`
-- | components.
-- |
-- | ```purescript
-- | exampleToYearAndMonth :: Effect Unit
-- | exampleToYearAndMonth = do
-- |   yearMonth <- PlainYearMonth.fromString "2024-06"
-- |   let yearAndMonth = PlainYearMonth.Compat.toYearAndMonth yearMonth
-- |   Console.logShow yearAndMonth
-- | ```
-- | ---
-- | ```text
-- | { month: June, year: (Year 2024) }
-- | ```
toYearAndMonth :: PlainYearMonth -> { year :: Year, month :: Month }
toYearAndMonth plainYearMonth =
  { year: unsafePartial fromJust (toEnum (PlainYearMonth.year plainYearMonth))
  , month: unsafePartial fromJust (toEnum (PlainYearMonth.month plainYearMonth))
  }
