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
import Data.Maybe (Maybe)
import Data.Newtype (unwrap)
import Data.Time.Duration (Milliseconds(..))
import Effect (Effect)
import JS.Temporal.Instant as Instant
import JS.Temporal.Instant.Internal (Instant)

-- | Converts a purescript-datetime `Instant` to a Temporal `Instant`.
-- |
-- | ```purescript
-- | exampleFromInstant :: Effect Unit
-- | exampleFromInstant = do
-- |   let dateTimeInstant = DateTime.Instant.fromDateTime bottom
-- |   instant <- Instant.Compat.fromInstant dateTimeInstant
-- |   Console.log (Instant.toString instant)
-- | ```
-- | ---
-- | ```text
-- | -271820-01-01T00:00:00Z
-- | ```
fromInstant :: DateTime.Instant.Instant -> Effect Instant
fromInstant dateTimeInstant = Instant.fromEpochMilliseconds (unwrap (DateTime.Instant.unInstant dateTimeInstant))

-- | Converts a Temporal `Instant` to a purescript-datetime `Instant`.
-- | Returns `Nothing` if the value is outside the datetime `Instant` range.
-- |
-- | ```purescript
-- | exampleToInstant :: Effect Unit
-- | exampleToInstant = do
-- |   instant <- Instant.fromString "2024-01-15T12:00:00Z"
-- |   case Instant.Compat.toInstant instant of
-- |     Just dateTimeInstant -> Console.log (show dateTimeInstant)
-- |     Nothing -> Console.log "Out of range"
-- | ```
-- | ---
-- | ```text
-- | (Instant (Milliseconds 1705320000000.0))
-- | ```
toInstant :: Instant -> Maybe DateTime.Instant.Instant
toInstant instant = DateTime.Instant.instant (Milliseconds (Instant.epochMilliseconds instant))

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
