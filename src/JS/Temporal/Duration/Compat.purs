-- | Conversions between `Duration` and the
-- | [`datetime`](https://pursuit.purescript.org/packages/purescript-datetime)
-- | `Data.Time.Duration.Milliseconds` type.
-- |
-- | Only fixed-unit durations (days, hours, minutes, seconds, milliseconds)
-- | are supported; calendar units (years, months, weeks) have no fixed
-- | millisecond length.
module JS.Temporal.Duration.Compat
  ( fromMilliseconds
  , toMilliseconds
  ) where

import Prelude

import Data.Int as Int
import Data.Maybe (Maybe(..))
import Data.Newtype (unwrap)
import Data.Time.Duration (Milliseconds(..))
import Effect (Effect)
import JS.Temporal.Duration as Duration
import JS.Temporal.Duration.Internal (Duration)

millisecondsPerDay :: Int
millisecondsPerDay = 86400000

millisecondsPerHour :: Int
millisecondsPerHour = 3600000

millisecondsPerMinute :: Int
millisecondsPerMinute = 60000

millisecondsPerSecond :: Int
millisecondsPerSecond = 1000

-- | Creates a Temporal `Duration` from purescript-datetime `Milliseconds`.
-- |
-- | ```purescript
-- | exampleFromMilliseconds :: Effect Unit
-- | exampleFromMilliseconds = do
-- |   duration <- Duration.Compat.fromMilliseconds (Milliseconds 5000.0)
-- |   Console.log (Duration.toString duration)
-- | ```
-- | ---
-- | ```text
-- | PT5S
-- | ```
fromMilliseconds :: Milliseconds -> Effect Duration
fromMilliseconds milliseconds =
  let
    totalMilliseconds = unwrap milliseconds
    absolute = if totalMilliseconds < 0.0 then negate totalMilliseconds else totalMilliseconds
    components = decomposeMilliseconds absolute
    signMultiplier = if totalMilliseconds < 0.0 then -1 else 1
    fields =
      { days: signMultiplier * components.days
      , hours: signMultiplier * components.hours
      , minutes: signMultiplier * components.minutes
      , seconds: signMultiplier * components.seconds
      , milliseconds: signMultiplier * components.milliseconds
      }
  in
    Duration.from fields

-- | Converts a Temporal `Duration` to purescript-datetime `Milliseconds`. Returns
-- | `Nothing` if the duration contains calendar units (years, months, weeks).
-- | Microseconds and nanoseconds are dropped.
-- |
-- | ```purescript
-- | exampleToMilliseconds :: Effect Unit
-- | exampleToMilliseconds = do
-- |   duration <- Duration.from { seconds: 5 }
-- |   case Duration.Compat.toMilliseconds duration of
-- |     Just (Milliseconds ms) -> Console.log ("Milliseconds: " <> show ms)
-- |     Nothing -> Console.log "Cannot convert (has calendar units)"
-- | ```
-- | ---
-- | ```text
-- | Milliseconds: 5000.0
-- | ```
toMilliseconds :: Duration -> Maybe Milliseconds
toMilliseconds duration
  | Duration.years duration /= 0 = Nothing
  | Duration.months duration /= 0 = Nothing
  | Duration.weeks duration /= 0 = Nothing
  | otherwise =
      let
        totalMilliseconds :: Number
        totalMilliseconds =
          Int.toNumber (Duration.days duration) * Int.toNumber millisecondsPerDay
            + Int.toNumber (Duration.hours duration) * Int.toNumber millisecondsPerHour
            + Int.toNumber (Duration.minutes duration) * Int.toNumber millisecondsPerMinute
            + Int.toNumber (Duration.seconds duration) * Int.toNumber millisecondsPerSecond
            + Int.toNumber (Duration.milliseconds duration)
        signed =
          case Duration.sign duration of
            -1 -> negate totalMilliseconds
            _ -> totalMilliseconds
      in
        Just (Milliseconds signed)

decomposeMilliseconds :: Number -> { days :: Int, hours :: Int, minutes :: Int, seconds :: Int, milliseconds :: Int }
decomposeMilliseconds totalMilliseconds =
  let
    perDay = Int.toNumber millisecondsPerDay
    perHour = Int.toNumber millisecondsPerHour
    perMinute = Int.toNumber millisecondsPerMinute
    perSecond = Int.toNumber millisecondsPerSecond
    daysValue = Int.floor (totalMilliseconds / perDay)
    afterDays = totalMilliseconds - Int.toNumber daysValue * perDay
    hoursValue = Int.floor (afterDays / perHour)
    afterHours = afterDays - Int.toNumber hoursValue * perHour
    minutesValue = Int.floor (afterHours / perMinute)
    afterMinutes = afterHours - Int.toNumber minutesValue * perMinute
    secondsValue = Int.floor (afterMinutes / perSecond)
    millisecondsValue = Int.floor (afterMinutes - Int.toNumber secondsValue * perSecond)
  in
    { days: daysValue, hours: hoursValue, minutes: minutesValue, seconds: secondsValue, milliseconds: millisecondsValue }
