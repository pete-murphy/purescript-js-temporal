-- | Runs all doc examples in a stable order, emitting machine-parsable markers
-- | around each example's output for the sync script to capture.
-- |
-- | Run with: spago run -p js-temporal-examples -m Examples.Docs.Main
-- | The sync script invokes this and parses stdout for --- OUTPUT <qualifiedName> --- ... --- /OUTPUT ---
module Examples.Docs.Main where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import Examples.Docs.Duration as Duration
import Examples.Docs.Instant as Instant
import Examples.Docs.PlainDate as PlainDate
import Examples.Docs.PlainDateTime as PlainDateTime
import Examples.Docs.PlainMonthDay as PlainMonthDay
import Examples.Docs.PlainTime as PlainTime
import Examples.Docs.PlainYearMonth as PlainYearMonth
import Examples.Docs.ZonedDateTime as ZonedDateTime

runExample :: String -> Effect Unit -> Effect Unit
runExample qualifiedName eff = do
  Console.log ("--- OUTPUT " <> qualifiedName <> " ---")
  eff
  Console.log "--- /OUTPUT ---"

main :: Effect Unit
main = do
  runExample "JS.Temporal.Duration.from" Duration.exampleFrom
  runExample "JS.Temporal.Duration.new" Duration.exampleNew
  runExample "JS.Temporal.Duration.total" Duration.exampleTotal
  runExample "JS.Temporal.Duration.subtract" Duration.exampleSubtract
  runExample "JS.Temporal.Instant.from" Instant.exampleFrom
  runExample "JS.Temporal.Instant.until" Instant.exampleUntil
  runExample "JS.Temporal.Instant.since" Instant.exampleSince
  runExample "JS.Temporal.PlainDate.from_" PlainDate.exampleFrom
  runExample "JS.Temporal.PlainDate.until" PlainDate.exampleUntil
  runExample "JS.Temporal.PlainDate.since" PlainDate.exampleSince
  runExample "JS.Temporal.PlainDate.subtract_" PlainDate.exampleSubtract
  runExample "JS.Temporal.PlainDateTime.new" PlainDateTime.exampleNew
  runExample "JS.Temporal.PlainDateTime.from_" PlainDateTime.exampleFrom
  runExample "JS.Temporal.PlainDateTime.from" PlainDateTime.exampleFromWithOptions
  runExample "JS.Temporal.PlainDateTime.add_" PlainDateTime.exampleAdd
  runExample "JS.Temporal.PlainDateTime.subtract_" PlainDateTime.exampleSubtract
  runExample "JS.Temporal.PlainDateTime.with_" PlainDateTime.exampleWith
  runExample "JS.Temporal.PlainDateTime.round" PlainDateTime.exampleRound
  runExample "JS.Temporal.PlainDateTime.toString_" PlainDateTime.exampleToString
  runExample "JS.Temporal.PlainDateTime.toZonedDateTime" PlainDateTime.exampleToZonedDateTime
  runExample "JS.Temporal.PlainDateTime.until" PlainDateTime.exampleUntil
  runExample "JS.Temporal.PlainDateTime.since" PlainDateTime.exampleSince
  runExample "JS.Temporal.PlainMonthDay.toPlainDate" PlainMonthDay.exampleToPlainDate
  runExample "JS.Temporal.PlainTime.from_" PlainTime.exampleFrom
  runExample "JS.Temporal.PlainTime.subtract" PlainTime.exampleSubtract
  runExample "JS.Temporal.PlainYearMonth.toPlainDate" PlainYearMonth.exampleToPlainDate
  runExample "JS.Temporal.ZonedDateTime.from_" ZonedDateTime.exampleFrom
  runExample "JS.Temporal.ZonedDateTime.until_" ZonedDateTime.exampleUntil
  runExample "JS.Temporal.ZonedDateTime.since_" ZonedDateTime.exampleSince
  runExample "JS.Temporal.ZonedDateTime.subtract_" ZonedDateTime.exampleSubtract
