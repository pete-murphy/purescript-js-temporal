-- | Cookbook: Calendar input element
-- | https://tc39.es/proposal-temporal/docs/cookbook.html#calendar-input-element
module Examples.Cookbook.CalendarInput where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.PlainDate as PlainDate
import TryPureScript (render, withConsole)

-- | In a browser, you would read a date string from an `<input type="date">`
-- | element. The value is always an ISO 8601 date string (e.g. "2024-07-01").
-- | Here we simulate that by parsing such a string.
main :: Effect Unit
main = render =<< withConsole do
  -- Simulating reading from <input type="date">
  let inputValue = "2024-07-01"
  date <- PlainDate.fromString inputValue
  Console.log ("Selected date: " <> PlainDate.toString date)
  Console.log ("Year:  " <> show (PlainDate.year date))
  Console.log ("Month: " <> show (PlainDate.month date))
  Console.log ("Day:   " <> show (PlainDate.day date))
