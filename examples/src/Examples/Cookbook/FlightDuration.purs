-- | Cookbook: Flight arrival/departure/duration
-- | https://tc39.es/proposal-temporal/docs/cookbook.html#flight-arrivaldepartureduration
module Examples.Cookbook.FlightDuration where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.Duration as Duration
import JS.Temporal.ZonedDateTime as ZonedDateTime
import TryPureScript (render, withConsole)

main :: Effect Unit
main = render =<< withConsole do
  departure <- ZonedDateTime.fromString "2020-03-08T11:55:00+08:00[Asia/Hong_Kong]"
  arrival <- ZonedDateTime.fromString "2020-03-08T09:50:00-07:00[America/Los_Angeles]"
  flightTime <- ZonedDateTime.until arrival departure
  Console.log ("Flight time: " <> Duration.toString flightTime)

  flightDuration <- Duration.from { minutes: 775 }
  arrival2 <- ZonedDateTime.add flightDuration departure
  arrivalInLA <- ZonedDateTime.withTimeZone "America/Los_Angeles" arrival2
  Console.log ("Arrival in LA: " <> ZonedDateTime.toString arrivalInLA)
