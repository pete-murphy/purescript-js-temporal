-- | Compilable doc examples for JS.Temporal.Instant.
module Examples.Docs.Instant where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Intl.DateTimeFormat as JS.Intl.DateTimeFormat
import JS.Intl.DurationFormat as JS.Intl.DurationFormat
import JS.Intl.Locale as Locale
import JS.Temporal.Instant as Instant
import JS.Temporal.Options.TemporalUnit as TemporalUnit

exampleFrom :: Effect Unit
exampleFrom = do
  -- [EXAMPLE JS.Temporal.Instant.from]
  locale <- Locale.new_ "en-US"
  instant <- Instant.from "2024-01-15T12:00:00Z"
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium", timeZone: "UTC" }
  Console.log (JS.Intl.DateTimeFormat.format formatter instant)
  -- [/EXAMPLE]

exampleUntil :: Effect Unit
exampleUntil = do
  -- [EXAMPLE JS.Temporal.Instant.until]
  locale <- Locale.new_ "en-US"
  earlier <- Instant.from "2020-01-09T00:00Z"
  later <- Instant.from "2020-01-09T04:00Z"
  result <- Instant.until { largestUnit: TemporalUnit.Hour } later earlier
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log ("4 hours: " <> JS.Intl.DurationFormat.format formatter result)
  -- [/EXAMPLE]

exampleSince :: Effect Unit
exampleSince = do
  -- [EXAMPLE JS.Temporal.Instant.since]
  locale <- Locale.new_ "en-US"
  earlier <- Instant.from "2020-01-09T00:00Z"
  later <- Instant.from "2020-01-09T04:00Z"
  elapsed <- Instant.since { largestUnit: TemporalUnit.Hour } earlier later
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log ("Elapsed: " <> JS.Intl.DurationFormat.format formatter elapsed)
  -- [/EXAMPLE]
