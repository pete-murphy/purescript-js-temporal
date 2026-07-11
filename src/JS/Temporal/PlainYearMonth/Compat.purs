-- | Conversions between `PlainYearMonth` and its
-- | [`datetime`](https://pursuit.purescript.org/packages/purescript-datetime)
-- | `Data.Date.Component` parts.
module JS.Temporal.PlainYearMonth.Compat
  ( Components
  , fromComponents
  , toComponents
  ) where

import Data.Date (Month, Year)
import Data.Enum (fromEnum, toEnum)
import Data.Maybe (fromJust)
import Effect (Effect)
import JS.Temporal.PlainYearMonth as PlainYearMonth
import JS.Temporal.PlainYearMonth.Internal (PlainYearMonth)
import Partial.Unsafe (unsafePartial)

-- | The purescript-datetime components of a `PlainYearMonth`.
type Components = { year :: Year, month :: Month }

-- | Creates a `PlainYearMonth` from purescript-datetime `Year` and `Month`
-- | components.
-- |
-- | ```purescript
-- | exampleFromComponents :: Effect Unit
-- | exampleFromComponents = do
-- |   let date = Gen.evalGen genDate genState
-- |   yearMonth <- PlainYearMonth.Compat.fromComponents { year: Date.year date, month: Date.month date }
-- |   Console.log (PlainYearMonth.toString yearMonth)
-- | ```
-- | ---
-- | ```text
-- | 1984-05
-- | ```
fromComponents :: Components -> Effect PlainYearMonth
fromComponents components = PlainYearMonth.from { year: fromEnum components.year, month: fromEnum components.month }

-- | Converts a `PlainYearMonth` to its purescript-datetime `Year` and `Month`
-- | components.
-- |
-- | ```purescript
-- | exampleToComponents :: Effect Unit
-- | exampleToComponents = do
-- |   yearMonth <- PlainYearMonth.fromString "2024-06"
-- |   let components = PlainYearMonth.Compat.toComponents yearMonth
-- |   Console.log (show components.year <> ", " <> show components.month)
-- | ```
-- | ---
-- | ```text
-- | (Year 2024), June
-- | ```
toComponents :: PlainYearMonth -> Components
toComponents plainYearMonth =
  { year: unsafePartial fromJust (toEnum (PlainYearMonth.year plainYearMonth))
  , month: unsafePartial fromJust (toEnum (PlainYearMonth.month plainYearMonth))
  }
