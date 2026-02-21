-- | Cookbook: Daily occurrence in local time
-- | https://tc39.es/proposal-temporal/docs/cookbook.html#daily-occurrence-in-local-time
module Examples.Cookbook.DailyOccurrence where

import Prelude

import Data.Foldable (traverse_)
import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.Duration as Duration
import JS.Temporal.Instant as Instant
import JS.Temporal.PlainDate as PlainDate
import JS.Temporal.PlainDateTime as PlainDateTime
import JS.Temporal.PlainTime as PlainTime
import JS.Temporal.ZonedDateTime as ZonedDateTime

calculateFirstFewOccurrences
  :: PlainDate.PlainDate -> PlainTime.PlainTime -> String -> Int -> Effect (Array Instant.Instant)
calculateFirstFewOccurrences startDate plainTime timeZone count = go startDate count []
  where
  go _ 0 acc = pure (acc)
  go date n acc = do
    let plainDateTime = PlainDate.toPlainDateTime plainTime date
    zoned <- PlainDateTime.toZonedDateTime timeZone plainDateTime
    let instant = ZonedDateTime.toInstant zoned
    daysDuration <- Duration.new { days: 1 }
    nextDate <- PlainDate.add_ daysDuration date
    go nextDate (n - 1) (acc <> [ instant ])

main :: Effect Unit
main = do
  startDate <- PlainDate.from_ "2017-03-10"
  time <- PlainTime.from_ "08:00"
  occurrences <- calculateFirstFewOccurrences startDate time "America/Los_Angeles" 4
  traverse_ (\i -> Console.log ("  " <> Instant.toString {} i)) occurrences
