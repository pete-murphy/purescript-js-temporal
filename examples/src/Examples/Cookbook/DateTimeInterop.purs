-- | Cookbook: Converting between purescript-datetime and js-temporal
-- | Corresponds to "Legacy Date => Temporal" and "Temporal => legacy Date"
-- | using purescript-datetime types. See docs/purescript-datetime-interop.md
module Examples.Cookbook.DateTimeInterop where

import Prelude

import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.Instant as Instant
import JS.Temporal.PlainDate as PlainDate

main :: Effect Unit
main = do
  plainDate <- PlainDate.from_ "2000-01-01"
  let date = PlainDate.toDate plainDate
  plainDate2 <- PlainDate.fromDate date
  Console.log ("PlainDate <-> Date round-trip: " <> PlainDate.toString_ plainDate2)

  temporalInstant <- Instant.from "2020-01-01T00:00:01.000Z"
  case Instant.toDateTimeInstant temporalInstant of
    Just dtInstant -> do
      temporalBack <- Instant.fromDateTimeInstant dtInstant
      Console.log ("Instant <-> datetime round-trip: " <> Instant.toString_ temporalBack)
    Nothing ->
      Console.log "toDateTimeInstant returned Nothing (out of range)"
