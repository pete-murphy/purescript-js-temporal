-- | Conversions between a Temporal `Instant` and the
-- | [`datetime`](https://pursuit.purescript.org/packages/purescript-datetime)
-- | `Data.DateTime.Instant.Instant` type, as well as the legacy JavaScript
-- | `Date` (via [`js-date`](https://pursuit.purescript.org/packages/purescript-js-date)).
module JS.Temporal.Instant.Compat
  ( fromInstant
  , toInstant
  , fromJSDate
  , toJSDate
  ) where

import Data.DateTime.Instant as DateTime.Instant
import Data.JSDate (JSDate)
import Data.JSDate as JSDate
import Data.Maybe (fromJust)
import Data.Newtype (unwrap)
import Data.Time.Duration (Milliseconds(..))
import Effect (Effect)
import JS.Temporal.Instant as Instant
import JS.Temporal.Instant.Internal (Instant)
import Partial.Unsafe (unsafePartial)

-- | Converts a purescript-datetime `Instant` to a Temporal `Instant`.
-- |
-- | ```purescript
-- | exampleFromInstant :: Effect Unit
-- | exampleFromInstant = do
-- |   let dateTime = Gen.evalGen genDateTime genState
-- |   instant <- Instant.Compat.fromInstant (DateTime.Instant.fromDateTime dateTime)
-- |   Console.log (Instant.toString instant)
-- | ```
-- | ---
-- | ```text
-- | 1984-05-21T06:36:54.368Z
-- | ```
fromInstant :: DateTime.Instant.Instant -> Effect Instant
fromInstant dateTimeInstant = Instant.fromEpochMilliseconds (unwrap (DateTime.Instant.unInstant dateTimeInstant))

-- | Converts a Temporal `Instant` to a purescript-datetime `Instant`.
-- |
-- | ```purescript
-- | exampleToInstant :: Effect Unit
-- | exampleToInstant = do
-- |   instant <- Instant.fromString "2024-01-15T12:00:00Z"
-- |   Console.logShow (Instant.Compat.toInstant instant)
-- | ```
-- | ---
-- | ```text
-- | (Instant (Milliseconds 1705320000000.0))
-- | ```
toInstant :: Instant -> DateTime.Instant.Instant
toInstant instant = unsafePartial fromJust (DateTime.Instant.instant (Milliseconds (Instant.epochMilliseconds instant)))

-- | Creates a Temporal `Instant` from a JavaScript `Date`.
-- |
-- | ```purescript
-- | exampleFromJSDate :: Effect Unit
-- | exampleFromJSDate = do
-- |   jsDate <- JSDate.parse "2024-01-15T12:00:00Z"
-- |   instant <- Instant.Compat.fromJSDate jsDate
-- |   Console.log (Instant.toString instant)
-- | ```
-- | ---
-- | ```text
-- | 2024-01-15T12:00:00Z
-- | ```
fromJSDate :: JSDate -> Effect Instant
fromJSDate jsDate = Instant.fromEpochMilliseconds (JSDate.getTime jsDate)

-- | Converts a Temporal `Instant` to a JavaScript `Date`. Sub-millisecond
-- | precision is dropped.
-- |
-- | ```purescript
-- | exampleToJSDate :: Effect Unit
-- | exampleToJSDate = do
-- |   instant <- Instant.fromString "2024-01-15T12:00:00Z"
-- |   isoString <- JSDate.toISOString (Instant.Compat.toJSDate instant)
-- |   Console.log isoString
-- | ```
-- | ---
-- | ```text
-- | 2024-01-15T12:00:00.000Z
-- | ```
toJSDate :: Instant -> JSDate
toJSDate instant = JSDate.fromTime (Instant.epochMilliseconds instant)
