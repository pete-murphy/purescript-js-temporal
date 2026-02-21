-- | Cookbook: Noon on a particular date
-- | https://tc39.es/proposal-temporal/docs/cookbook.html#noon-on-a-particular-date
module Examples.Cookbook.NoonOnDate where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.PlainDate as PlainDate
import JS.Temporal.PlainDateTime as PlainDateTime
import JS.Temporal.PlainTime as PlainTime

main :: Effect Unit
main = do
  date <- PlainDate.from_ "2020-05-14"
  noon <- PlainTime.from_ "12:00"
  let noonOnDate = PlainDate.toPlainDateTime noon date
  Console.log ("Noon on 2020-05-14: " <> PlainDateTime.toString_ noonOnDate)
