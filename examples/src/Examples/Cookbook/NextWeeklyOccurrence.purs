-- | Cookbook: Next weekly occurrence
-- | https://tc39.es/proposal-temporal/docs/cookbook.html#next-weekly-occurrence
module Examples.Cookbook.NextWeeklyOccurrence where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Temporal.Duration as Duration
import JS.Temporal.PlainDate as PlainDate
import JS.Temporal.PlainDateTime as PlainDateTime
import JS.Temporal.PlainTime as PlainTime
import JS.Temporal.ZonedDateTime as ZonedDateTime
import JS.Temporal.ZonedDateTime.Internal (compare) as ZonedDateTimeCompare

nextWeeklyOccurrence
  :: ZonedDateTime.ZonedDateTime
  -> Int
  -> PlainTime.PlainTime
  -> String
  -> Effect ZonedDateTime.ZonedDateTime
nextWeeklyOccurrence now weekday eventTime eventTimeZone = do
  nowInEventTimeZone <- ZonedDateTime.withTimeZone eventTimeZone now
  let plainDate = ZonedDateTime.toPlainDate nowInEventTimeZone
  let daysToAdd = (weekday + 7 - ZonedDateTime.dayOfWeek nowInEventTimeZone) `mod` 7
  daysDuration <- Duration.new { days: daysToAdd }
  nextDate <- PlainDate.add_ daysDuration plainDate

  let plainDateTime = PlainDate.toPlainDateTime eventTime nextDate
  nextOccurrence <- PlainDateTime.toZonedDateTime eventTimeZone plainDateTime

  let ordering = ZonedDateTimeCompare.compare now nextOccurrence
  if ordering == GT then do
    weeksDuration <- Duration.new { weeks: 1 }
    next <- ZonedDateTime.add_ weeksDuration nextOccurrence
    ZonedDateTime.withTimeZone (ZonedDateTime.timeZoneId now) next
  else
    ZonedDateTime.withTimeZone (ZonedDateTime.timeZoneId now) nextOccurrence

main :: Effect Unit
main = do
  eventTime <- PlainTime.from_ "08:45"
  rightBefore <- ZonedDateTime.from_ "2020-03-26T15:30+00:00[Europe/London]"
  next <- nextWeeklyOccurrence rightBefore 4 eventTime "America/Los_Angeles"
  Console.log ("Next Thursday 8:45 LA time: " <> ZonedDateTime.toString_ next)
