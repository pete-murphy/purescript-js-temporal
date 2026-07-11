-- | Conversions between `PlainTime` and the
-- | [`datetime`](https://pursuit.purescript.org/packages/purescript-datetime)
-- | `Data.Time.Time` type.
module JS.Temporal.PlainTime.Compat
  ( fromTime
  , toTime
  ) where

import Prelude

import Data.Enum (fromEnum, toEnum)
import Data.Maybe (fromJust)
import Data.Time (Time(..))
import Data.Time as Time
import Effect (Effect)
import JS.Temporal.PlainTime as PlainTime
import JS.Temporal.PlainTime.Internal (PlainTime)
import Partial.Unsafe (unsafePartial)

-- | Converts a purescript-datetime `Time` to a `PlainTime`. Microsecond and
-- | nanosecond components are set to zero.
-- |
-- | ```purescript
-- | exampleFromTime :: Effect Unit
-- | exampleFromTime = do
-- |   let time = Gen.evalGen genTime genState
-- |   plainTime <- PlainTime.Compat.fromTime time
-- |   Console.log (PlainTime.toString plainTime)
-- | ```
-- | ---
-- | ```text
-- | 06:15:42.936
-- | ```
fromTime :: Time -> Effect PlainTime
fromTime time =
  PlainTime.from
    { hour: fromEnum (Time.hour time)
    , minute: fromEnum (Time.minute time)
    , second: fromEnum (Time.second time)
    , millisecond: fromEnum (Time.millisecond time)
    }

-- | Converts a `PlainTime` to a purescript-datetime `Time`.
-- | Microsecond and nanosecond are dropped (treated as zero).
-- |
-- | ```purescript
-- | exampleToTime :: Effect Unit
-- | exampleToTime = do
-- |   time <- PlainTime.fromString "14:30:00"
-- |   Console.log (show (PlainTime.Compat.toTime time))
-- | ```
-- | ---
-- | ```text
-- | (Time (Hour 14) (Minute 30) (Second 0) (Millisecond 0))
-- | ```
toTime :: PlainTime -> Time
toTime plainTime =
  unsafePartial fromJust
    ( Time
        <$> toEnum (PlainTime.hour plainTime)
        <*> toEnum (PlainTime.minute plainTime)
        <*> toEnum (PlainTime.second plainTime)
        <*> toEnum (PlainTime.millisecond plainTime)
    )
