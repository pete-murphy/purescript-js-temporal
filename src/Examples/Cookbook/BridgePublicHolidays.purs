-- | Cookbook: Weekday of yearly occurrence (bridge public holidays)
-- | https://tc39.es/proposal-temporal/docs/cookbook.html#weekday-of-yearly-occurrence
module Examples.Cookbook.BridgePublicHolidays where

import Prelude

import Data.Foldable (intercalate)
import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.Duration as Duration
import JS.Temporal.PlainDate as PlainDate
import JS.Temporal.PlainMonthDay as PlainMonthDay

bridgePublicHolidays :: PlainMonthDay.PlainMonthDay -> Int -> Effect (Array PlainDate.PlainDate)
bridgePublicHolidays holiday year = do
  date <- PlainMonthDay.toPlainDate { year } holiday
  case PlainDate.dayOfWeek date of
    1 -> pure [ date ]
    3 -> pure [ date ]
    5 -> pure [ date ]
    2 -> do
      daysDuration <- Duration.new { days: 1 }
      monday <- PlainDate.subtract_ daysDuration date
      pure [ monday, date ]
    4 -> do
      daysDuration <- Duration.new { days: 1 }
      friday <- PlainDate.add_ daysDuration date
      pure [ date, friday ]
    _ -> pure []

main :: Effect Unit
main = do
  labourDay <- PlainMonthDay.from_ "05-01"

  noBridge <- bridgePublicHolidays labourDay 2020
  Console.log ("2020 (no bridge): " <> intercalate ", " (map PlainDate.toString_ noBridge))

  withBridge <- bridgePublicHolidays labourDay 2018
  Console.log ("2018 (bridge): " <> intercalate ", " (map PlainDate.toString_ withBridge))

  weekend <- bridgePublicHolidays labourDay 2021
  Console.log ("2021 (weekend): " <> intercalate ", " (map PlainDate.toString_ weekend))
