-- | Cookbook: Converting between Temporal types and legacy Date
-- | https://tc39.es/proposal-temporal/docs/cookbook.html#converting-between-temporal-types-and-legacy-date
module Examples.Cookbook.JSDateInterop where

import Prelude

import Data.JSDate as JSDate
import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.Instant as Instant
import JS.Temporal.Instant.Compat as Instant.Compat
import JS.Temporal.PlainDate as PlainDate
import JS.Temporal.ZonedDateTime as ZonedDateTime
import TryPureScript (render, withConsole)

main :: Effect Unit
main = render =<< withConsole do
  -- === Legacy Date → Temporal.Instant and/or Temporal.ZonedDateTime ===

  legacyDate <- JSDate.parse "2020-01-01T00:00:01.000Z"
  instant <- Instant.Compat.fromJSDate legacyDate
  Console.log ("Legacy Date → Instant: " <> Instant.toString instant)

  let zoned = Instant.toZonedDateTimeISO "America/New_York" instant
  Console.log ("Legacy Date → ZonedDateTime: " <> ZonedDateTime.toString zoned)

  -- === Date-only values: Legacy Date → Temporal.PlainDate ===

  -- When a legacy Date represents a date-only value, interpret it in UTC
  -- to avoid off-by-one errors from time zone shifts.
  utcDate <- JSDate.parse "2020-06-15T00:00:00Z"
  utcInstant <- Instant.Compat.fromJSDate utcDate
  let utcZoned = Instant.toZonedDateTimeISO "UTC" utcInstant
  let plainDate = ZonedDateTime.toPlainDate utcZoned
  Console.log ("Legacy Date → PlainDate: " <> PlainDate.toString plainDate)

  -- === Temporal types → Legacy Date ===

  instant2 <- Instant.fromString "2020-01-01T00:00:01.000Z"
  let legacyBack = Instant.Compat.toJSDate instant2
  isoStr <- JSDate.toISOString legacyBack
  Console.log ("Instant → Legacy Date: " <> isoStr)
