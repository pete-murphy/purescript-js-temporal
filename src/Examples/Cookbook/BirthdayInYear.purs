-- | Cookbook: Birthday in 2030
-- | https://tc39.es/proposal-temporal/docs/cookbook.html#birthday-in-2030
module Examples.Cookbook.BirthdayInYear where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.PlainDate as PlainDate
import JS.Temporal.PlainMonthDay as PlainMonthDay

main :: Effect Unit
main = do
  birthday <- PlainMonthDay.from_ "12-15"
  birthdayIn2030 <- PlainMonthDay.toPlainDate { year: 2030 } birthday
  Console.log ("Birthday in 2030: " <> PlainDate.toString {} birthdayIn2030)
  Console.log ("Day of week (1=Mon, 7=Sun): " <> show (PlainDate.dayOfWeek birthdayIn2030))
