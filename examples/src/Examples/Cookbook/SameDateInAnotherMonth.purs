-- | Cookbook: Same date in another month
-- | https://tc39.es/proposal-temporal/docs/cookbook.html#same-date-in-another-month
module Examples.Cookbook.SameDateInAnotherMonth where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.PlainDate as PlainDate

main :: Effect Unit
main = do
  date <- PlainDate.from_ "2020-05-31"

  feb <- PlainDate.with_ { month: 2 } date
  Console.log ("May 31 in February (constrained): " <> PlainDate.toString_ feb)
