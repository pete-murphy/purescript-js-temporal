-- | Runs all doc examples in a stable order, emitting machine-parsable markers
-- | around each example's output for the sync script to capture.
-- |
-- | Run with: spago run -p js-temporal-examples -m Examples.Docs.Main
-- | The sync script invokes this and parses stdout for --- OUTPUT <qualifiedName> --- ... --- /OUTPUT ---
module Examples.Docs.Main where

import Prelude

import Data.Either (Either(..))
import Effect (Effect)
import Effect.Class.Console as Console
import Effect.Exception as Effect.Exception
import Examples.Docs.Duration as Duration
import Examples.Docs.Instant as Instant
import Examples.Docs.PlainDate as PlainDate
import Examples.Docs.PlainDateTime as PlainDateTime
import Examples.Docs.PlainMonthDay as PlainMonthDay
import Examples.Docs.PlainTime as PlainTime
import Examples.Docs.Now as Now
import Examples.Docs.PlainYearMonth as PlainYearMonth
import Examples.Docs.ZonedDateTime as ZonedDateTime

runExample :: String -> Effect Unit -> Effect Unit
runExample qualifiedName eff = do
  Console.log ("--- OUTPUT " <> qualifiedName <> " ---")
  result <- Effect.Exception.try eff
  case result of
    Left error ->
      Console.log ("[[EXAMPLE ERROR]] " <> Effect.Exception.message error)
    Right _ ->
      pure unit
  Console.log "--- /OUTPUT ---"

main :: Effect Unit
main = do
  runExample "JS.Temporal.Duration.from" Duration.exampleFrom
  runExample "JS.Temporal.Duration.new" Duration.exampleNew
  runExample "JS.Temporal.Duration.total" Duration.exampleTotal
  runExample "JS.Temporal.Duration.add" Duration.exampleAdd
  runExample "JS.Temporal.Duration.subtract" Duration.exampleSubtract
  runExample "JS.Temporal.Duration.with" Duration.exampleWith
  runExample "JS.Temporal.Duration.compare" Duration.exampleCompare
  runExample "JS.Temporal.Duration.round" Duration.exampleRound
  runExample "JS.Temporal.Duration.toString" Duration.exampleToString
  runExample "JS.Temporal.Instant.new" Instant.exampleNew
  runExample "JS.Temporal.Instant.from" Instant.exampleFrom
  runExample "JS.Temporal.Instant.fromEpochMilliseconds" Instant.exampleFromEpochMilliseconds
  runExample "JS.Temporal.Instant.fromEpochNanoseconds" Instant.exampleFromEpochNanoseconds
  runExample "JS.Temporal.Instant.add" Instant.exampleAdd
  runExample "JS.Temporal.Instant.subtract" Instant.exampleSubtract
  runExample "JS.Temporal.Instant.until" Instant.exampleUntil
  runExample "JS.Temporal.Instant.since" Instant.exampleSince
  runExample "JS.Temporal.Instant.round" Instant.exampleRound
  runExample "JS.Temporal.Instant.toZonedDateTimeISO" Instant.exampleToZonedDateTimeISO
  runExample "JS.Temporal.Instant.toString" Instant.exampleToString
  runExample "JS.Temporal.Now.instant" Now.exampleInstant
  runExample "JS.Temporal.Now.plainDateISO_" Now.examplePlainDateISO_
  runExample "JS.Temporal.Now.plainDateISO" Now.examplePlainDateISO
  runExample "JS.Temporal.Now.plainDateTimeISO_" Now.examplePlainDateTimeISO_
  runExample "JS.Temporal.Now.plainDateTimeISO" Now.examplePlainDateTimeISO
  runExample "JS.Temporal.Now.plainTimeISO_" Now.examplePlainTimeISO_
  runExample "JS.Temporal.Now.plainTimeISO" Now.examplePlainTimeISO
  runExample "JS.Temporal.Now.zonedDateTimeISO_" Now.exampleZonedDateTimeISO_
  runExample "JS.Temporal.Now.zonedDateTimeISO" Now.exampleZonedDateTimeISO
  runExample "JS.Temporal.Now.timeZoneId" Now.exampleTimeZoneId
  runExample "JS.Temporal.PlainDate.new" PlainDate.exampleNew
  runExample "JS.Temporal.PlainDate.from" PlainDate.exampleFrom
  runExample "JS.Temporal.PlainDate.add" PlainDate.exampleAdd
  runExample "JS.Temporal.PlainDate.until" PlainDate.exampleUntil
  runExample "JS.Temporal.PlainDate.since" PlainDate.exampleSince
  runExample "JS.Temporal.PlainDate.with" PlainDate.exampleWith
  runExample "JS.Temporal.PlainDate.withCalendar" PlainDate.exampleWithCalendar
  runExample "JS.Temporal.PlainDate.subtract" PlainDate.exampleSubtract
  runExample "JS.Temporal.PlainDate.toString" PlainDate.exampleToString
  runExample "JS.Temporal.PlainDate.toPlainYearMonth" PlainDate.exampleToPlainYearMonth
  runExample "JS.Temporal.PlainDate.toPlainMonthDay" PlainDate.exampleToPlainMonthDay
  runExample "JS.Temporal.PlainDate.toPlainDateTime" PlainDate.exampleToPlainDateTime
  runExample "JS.Temporal.PlainDate.toZonedDateTime" PlainDate.exampleToZonedDateTime
  runExample "JS.Temporal.PlainDateTime.new" PlainDateTime.exampleNew
  runExample "JS.Temporal.PlainDateTime.from" PlainDateTime.exampleFrom
  runExample "JS.Temporal.PlainDateTime.add" PlainDateTime.exampleAdd
  runExample "JS.Temporal.PlainDateTime.subtract" PlainDateTime.exampleSubtract
  runExample "JS.Temporal.PlainDateTime.with" PlainDateTime.exampleWith
  runExample "JS.Temporal.PlainDateTime.withPlainTime" PlainDateTime.exampleWithPlainTime
  runExample "JS.Temporal.PlainDateTime.withCalendar" PlainDateTime.exampleWithCalendar
  runExample "JS.Temporal.PlainDateTime.round" PlainDateTime.exampleRound
  runExample "JS.Temporal.PlainDateTime.toString" PlainDateTime.exampleToString
  runExample "JS.Temporal.PlainDateTime.toPlainDate" PlainDateTime.exampleToPlainDate
  runExample "JS.Temporal.PlainDateTime.toPlainTime" PlainDateTime.exampleToPlainTime
  runExample "JS.Temporal.PlainDateTime.toZonedDateTime" PlainDateTime.exampleToZonedDateTime
  runExample "JS.Temporal.PlainDateTime.until" PlainDateTime.exampleUntil
  runExample "JS.Temporal.PlainDateTime.since" PlainDateTime.exampleSince
  runExample "JS.Temporal.PlainMonthDay.new" PlainMonthDay.exampleNew
  runExample "JS.Temporal.PlainMonthDay.from" PlainMonthDay.exampleFrom
  runExample "JS.Temporal.PlainMonthDay.with" PlainMonthDay.exampleWith
  runExample "JS.Temporal.PlainMonthDay.toString" PlainMonthDay.exampleToString
  runExample "JS.Temporal.PlainMonthDay.toPlainDate" PlainMonthDay.exampleToPlainDate
  runExample "JS.Temporal.PlainTime.new" PlainTime.exampleNew
  runExample "JS.Temporal.PlainTime.from" PlainTime.exampleFrom
  runExample "JS.Temporal.PlainTime.add" PlainTime.exampleAdd
  runExample "JS.Temporal.PlainTime.subtract" PlainTime.exampleSubtract
  runExample "JS.Temporal.PlainTime.with" PlainTime.exampleWith
  runExample "JS.Temporal.PlainTime.until" PlainTime.exampleUntil
  runExample "JS.Temporal.PlainTime.since" PlainTime.exampleSince
  runExample "JS.Temporal.PlainTime.round" PlainTime.exampleRound
  runExample "JS.Temporal.PlainTime.toString" PlainTime.exampleToString
  runExample "JS.Temporal.PlainYearMonth.new" PlainYearMonth.exampleNew
  runExample "JS.Temporal.PlainYearMonth.from" PlainYearMonth.exampleFrom
  runExample "JS.Temporal.PlainYearMonth.add" PlainYearMonth.exampleAdd
  runExample "JS.Temporal.PlainYearMonth.subtract" PlainYearMonth.exampleSubtract
  runExample "JS.Temporal.PlainYearMonth.with" PlainYearMonth.exampleWith
  runExample "JS.Temporal.PlainYearMonth.until" PlainYearMonth.exampleUntil
  runExample "JS.Temporal.PlainYearMonth.since" PlainYearMonth.exampleSince
  runExample "JS.Temporal.PlainYearMonth.toString" PlainYearMonth.exampleToString
  runExample "JS.Temporal.PlainYearMonth.toPlainDate" PlainYearMonth.exampleToPlainDate
  runExample "JS.Temporal.ZonedDateTime.new" ZonedDateTime.exampleNew
  runExample "JS.Temporal.ZonedDateTime.from" ZonedDateTime.exampleFrom
  runExample "JS.Temporal.ZonedDateTime.add" ZonedDateTime.exampleAdd
  runExample "JS.Temporal.ZonedDateTime.subtract" ZonedDateTime.exampleSubtract
  runExample "JS.Temporal.ZonedDateTime.with" ZonedDateTime.exampleWith
  runExample "JS.Temporal.ZonedDateTime.withTimeZone" ZonedDateTime.exampleWithTimeZone
  runExample "JS.Temporal.ZonedDateTime.withCalendar" ZonedDateTime.exampleWithCalendar
  runExample "JS.Temporal.ZonedDateTime.withPlainTime" ZonedDateTime.exampleWithPlainTime
  runExample "JS.Temporal.ZonedDateTime.withPlainDate" ZonedDateTime.exampleWithPlainDate
  runExample "JS.Temporal.ZonedDateTime.until" ZonedDateTime.exampleUntil
  runExample "JS.Temporal.ZonedDateTime.since" ZonedDateTime.exampleSince
  runExample "JS.Temporal.ZonedDateTime.round" ZonedDateTime.exampleRound
  runExample "JS.Temporal.ZonedDateTime.startOfDay" ZonedDateTime.exampleStartOfDay
  runExample "JS.Temporal.ZonedDateTime.getTimeZoneTransition" ZonedDateTime.exampleGetTimeZoneTransition
  runExample "JS.Temporal.ZonedDateTime.toInstant" ZonedDateTime.exampleToInstant
  runExample "JS.Temporal.ZonedDateTime.toPlainDateTime" ZonedDateTime.exampleToPlainDateTime
  runExample "JS.Temporal.ZonedDateTime.toPlainDate" ZonedDateTime.exampleToPlainDate
  runExample "JS.Temporal.ZonedDateTime.toPlainTime" ZonedDateTime.exampleToPlainTime
  runExample "JS.Temporal.ZonedDateTime.toPlainYearMonth" ZonedDateTime.exampleToPlainYearMonth
  runExample "JS.Temporal.ZonedDateTime.toPlainMonthDay" ZonedDateTime.exampleToPlainMonthDay
  runExample "JS.Temporal.ZonedDateTime.toString" ZonedDateTime.exampleToString
