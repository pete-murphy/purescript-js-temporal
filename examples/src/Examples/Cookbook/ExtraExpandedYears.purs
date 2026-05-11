-- | Cookbook: Extra-expanded years
-- | https://tc39.es/proposal-temporal/docs/cookbook.html#extra-expanded-years
module Examples.Cookbook.ExtraExpandedYears where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.PlainDate as PlainDate

-- | Temporal supports years outside the common 4-digit range.
-- | Years > 9999 or < 0 use a sign prefix in ISO 8601 strings.
main :: Effect Unit
main = do
  -- Year 100,000
  farFuture <- PlainDate.from { year: 100000, month: 1, day: 1 }
  Console.log ("Far future: " <> PlainDate.toString farFuture)
  Console.log ("Year: " <> show (PlainDate.year farFuture))

  -- Negative year (1 BCE = year 0, 2 BCE = year -1, etc.)
  bce <- PlainDate.from { year: -44, month: 3, day: 15 }
  Console.log ("Ides of March, 44 BCE: " <> PlainDate.toString bce)
  Console.log ("Year: " <> show (PlainDate.year bce))
