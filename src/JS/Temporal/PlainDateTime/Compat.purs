-- | Conversions between `PlainDateTime` and the
-- | [`datetime`](https://pursuit.purescript.org/packages/purescript-datetime)
-- | `Data.DateTime.DateTime` type.
module JS.Temporal.PlainDateTime.Compat
  ( fromDateTime
  , toDateTime
  ) where

import Prelude

import Data.DateTime (DateTime(..))
import Data.DateTime as DateTime
import Effect (Effect)
import JS.Temporal.PlainDate as PlainDate
import JS.Temporal.PlainDate.Compat as PlainDate.Compat
import JS.Temporal.PlainDateTime as PlainDateTime
import JS.Temporal.PlainDateTime.Internal (PlainDateTime)
import JS.Temporal.PlainTime.Compat as PlainTime.Compat

-- | Converts a purescript-datetime `DateTime` to a `PlainDateTime`.
-- |
-- | ```purescript
-- | exampleFromDateTime :: Effect Unit
-- | exampleFromDateTime = do
-- |   let dateTime = Gen.evalGen genDateTime genState
-- |   plainDateTime <- PlainDateTime.Compat.fromDateTime dateTime
-- |   Console.log (PlainDateTime.toString plainDateTime)
-- | ```
-- | ---
-- | ```text
-- | 1984-05-21T06:36:54.368
-- | ```
fromDateTime :: DateTime -> Effect PlainDateTime
fromDateTime dateTime = do
  plainDate <- PlainDate.Compat.fromDate (DateTime.date dateTime)
  plainTime <- PlainTime.Compat.fromTime (DateTime.time dateTime)
  pure (PlainDate.toPlainDateTime plainTime plainDate)

-- | Converts a `PlainDateTime` to a purescript-datetime `DateTime`.
-- |
-- | ```purescript
-- | exampleToDateTime :: Effect Unit
-- | exampleToDateTime = do
-- |   dt <- PlainDateTime.fromString "2024-07-01T12:00:00"
-- |   Console.logShow (PlainDateTime.Compat.toDateTime dt)
-- | ```
-- | ---
-- | ```text
-- | (DateTime (Date (Year 2024) July (Day 1)) (Time (Hour 12) (Minute 0) (Second 0) (Millisecond 0)))
-- | ```
toDateTime :: PlainDateTime -> DateTime
toDateTime plainDateTime =
  DateTime
    (PlainDate.Compat.toDate (PlainDateTime.toPlainDate plainDateTime))
    (PlainTime.Compat.toTime (PlainDateTime.toPlainTime plainDateTime))
