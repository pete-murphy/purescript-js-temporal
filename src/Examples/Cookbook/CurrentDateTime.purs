-- | Cookbook: Current date and time
-- | https://tc39.es/proposal-temporal/docs/cookbook.html#current-date-and-time
module Examples.Cookbook.CurrentDateTime where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.Now as Now
import JS.Temporal.PlainDate as PlainDate
import JS.Temporal.PlainDateTime as PlainDateTime

main :: Effect Unit
main = do
  date <- Now.plainDateISO
  Console.log ("Current date (ISO 8601): " <> PlainDate.toString_ date)

  plainDateTime <- Now.plainDateTimeISO
  Console.log ("Current date and time: " <> PlainDateTime.toString_ plainDateTime)
