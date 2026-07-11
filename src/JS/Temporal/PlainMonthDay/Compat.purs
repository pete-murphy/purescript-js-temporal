-- | Conversions between `PlainMonthDay` and its
-- | [`datetime`](https://pursuit.purescript.org/packages/purescript-datetime)
-- | `Data.Date.Component` parts.
module JS.Temporal.PlainMonthDay.Compat
  ( Components
  , fromComponents
  , toComponents
  ) where

import Data.Date (Day, Month)
import Data.Enum (fromEnum, toEnum)
import Data.Maybe (fromJust)
import Effect (Effect)
import JS.Temporal.PlainMonthDay as PlainMonthDay
import JS.Temporal.PlainMonthDay.Internal (PlainMonthDay)
import Partial.Unsafe (unsafePartial)

-- | The purescript-datetime components of a `PlainMonthDay`.
type Components = { month :: Month, day :: Day }

-- The ISO month number, obtained via a reference year since PlainMonthDay has
-- no `month` property (1972 is the ISO reference year used by the Temporal
-- spec: the first leap year of the Unix epoch).
foreign import _isoMonth :: PlainMonthDay -> Int

-- | Creates a `PlainMonthDay` from purescript-datetime `Month` and `Day`
-- | components.
-- |
-- | ```purescript
-- | exampleFromComponents :: Effect Unit
-- | exampleFromComponents = do
-- |   let date = Gen.evalGen genDate genState
-- |   monthDay <- PlainMonthDay.Compat.fromComponents { month: Date.month date, day: Date.day date }
-- |   Console.log (PlainMonthDay.toString monthDay)
-- | ```
-- | ---
-- | ```text
-- | 05-21
-- | ```
fromComponents :: Components -> Effect PlainMonthDay
fromComponents components = PlainMonthDay.from { month: fromEnum components.month, day: fromEnum components.day }

-- | Converts a `PlainMonthDay` to its purescript-datetime `Month` and `Day`
-- | components.
-- |
-- | ```purescript
-- | exampleToComponents :: Effect Unit
-- | exampleToComponents = do
-- |   monthDay <- PlainMonthDay.fromString "12-15"
-- |   let components = PlainMonthDay.Compat.toComponents monthDay
-- |   Console.log (show components.month <> " " <> show components.day)
-- | ```
-- | ---
-- | ```text
-- | December (Day 15)
-- | ```
toComponents :: PlainMonthDay -> Components
toComponents plainMonthDay =
  { month: unsafePartial fromJust (toEnum (_isoMonth plainMonthDay))
  , day: unsafePartial fromJust (toEnum (PlainMonthDay.day plainMonthDay))
  }
