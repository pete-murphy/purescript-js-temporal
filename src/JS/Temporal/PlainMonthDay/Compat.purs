-- | Conversions between `PlainMonthDay` and its
-- | [`datetime`](https://pursuit.purescript.org/packages/purescript-datetime)
-- | `Data.Date.Component` parts.
module JS.Temporal.PlainMonthDay.Compat
  ( fromMonthAndDay
  , toMonthAndDay
  ) where

import Data.Date (Day, Month)
import Data.Enum (fromEnum, toEnum)
import Data.Maybe (fromJust)
import Effect (Effect)
import JS.Temporal.PlainMonthDay as PlainMonthDay
import JS.Temporal.PlainMonthDay.Internal (PlainMonthDay)
import Partial.Unsafe (unsafePartial)

-- The ISO month number, obtained via a reference year since PlainMonthDay has
-- no `month` property (1972 is the ISO reference year used by the Temporal
-- spec: the first leap year of the Unix epoch).
foreign import _isoMonth :: PlainMonthDay -> Int

-- | Creates a `PlainMonthDay` from purescript-datetime `Month` and `Day`
-- | components.
-- |
-- | ```purescript
-- | exampleFromMonthAndDay :: Effect Unit
-- | exampleFromMonthAndDay = do
-- |   let date = Gen.evalGen genDate genState
-- |   monthDay <- PlainMonthDay.Compat.fromMonthAndDay (Date.month date) (Date.day date)
-- |   Console.log (PlainMonthDay.toString monthDay)
-- | ```
-- | ---
-- | ```text
-- | 05-21
-- | ```
fromMonthAndDay :: Month -> Day -> Effect PlainMonthDay
fromMonthAndDay month day = PlainMonthDay.from { month: fromEnum month, day: fromEnum day }

-- | Converts a `PlainMonthDay` to its purescript-datetime `Month` and `Day`
-- | components.
-- |
-- | ```purescript
-- | exampleToMonthAndDay :: Effect Unit
-- | exampleToMonthAndDay = do
-- |   monthDay <- PlainMonthDay.fromString "12-15"
-- |   let monthAndDay = PlainMonthDay.Compat.toMonthAndDay monthDay
-- |   Console.logShow monthAndDay
-- | ```
-- | ---
-- | ```text
-- | { day: (Day 15), month: December }
-- | ```
toMonthAndDay :: PlainMonthDay -> { month :: Month, day :: Day }
toMonthAndDay plainMonthDay =
  { month: unsafePartial fromJust (toEnum (_isoMonth plainMonthDay))
  , day: unsafePartial fromJust (toEnum (PlainMonthDay.day plainMonthDay))
  }
