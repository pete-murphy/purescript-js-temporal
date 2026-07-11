-- | Compilable doc examples for JS.Temporal.Instant.Compat.
module Examples.Docs.Instant.Compat where

import Prelude

import Data.DateTime.Instant as DateTime.Instant
import Data.JSDate as JSDate
import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.Instant as Instant
import JS.Temporal.Instant.Compat as Instant.Compat

-- | Converts a purescript-datetime `Instant` to a Temporal `Instant`.
exampleFromInstant :: Effect Unit
exampleFromInstant = do
  let dateTimeInstant = DateTime.Instant.fromDateTime bottom
  instant <- Instant.Compat.fromInstant dateTimeInstant
  Console.log (Instant.toString instant)

-- | Converts a Temporal `Instant` to a purescript-datetime `Instant`.
exampleToInstant :: Effect Unit
exampleToInstant = do
  instant <- Instant.fromString "2024-01-15T12:00:00Z"
  Console.logShow (Instant.Compat.toInstant instant)

-- | Creates a Temporal `Instant` from a JavaScript `Date`.
exampleFromJSDate :: Effect Unit
exampleFromJSDate = do
  jsDate <- JSDate.parse "2024-01-15T12:00:00Z"
  instant <- Instant.Compat.fromJSDate jsDate
  Console.log (Instant.toString instant)

-- | Converts a Temporal `Instant` to a JavaScript `Date`. Sub-millisecond
-- | precision is dropped.
exampleToJSDate :: Effect Unit
exampleToJSDate = do
  instant <- Instant.fromString "2024-01-15T12:00:00Z"
  isoString <- JSDate.toISOString (Instant.Compat.toJSDate instant)
  Console.log isoString
