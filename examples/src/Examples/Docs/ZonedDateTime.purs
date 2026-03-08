-- | Compilable doc examples for JS.Temporal.ZonedDateTime.
module Examples.Docs.ZonedDateTime where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Intl.DateTimeFormat as JS.Intl.DateTimeFormat
import JS.Intl.DurationFormat as JS.Intl.DurationFormat
import JS.Intl.Locale as Locale
import JS.Temporal.Duration as Duration
import JS.Temporal.ZonedDateTime as ZonedDateTime

exampleFrom :: Effect Unit
exampleFrom = do
  -- [EXAMPLE JS.Temporal.ZonedDateTime.from_]
  locale <- Locale.new_ "en-US"
  zoned <- ZonedDateTime.from_ "2024-01-15T12:00:00-05:00[America/New_York]"
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter zoned)
  -- [/EXAMPLE]

exampleUntil :: Effect Unit
exampleUntil = do
  -- [EXAMPLE JS.Temporal.ZonedDateTime.until_]
  locale <- Locale.new_ "en-US"
  departure <- ZonedDateTime.from_ "2020-03-08T11:55:00+08:00[Asia/Hong_Kong]"
  arrival <- ZonedDateTime.from_ "2020-03-08T09:50:00-07:00[America/Los_Angeles]"
  flightTime <- ZonedDateTime.until_ arrival departure
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log ("Flight time: " <> JS.Intl.DurationFormat.format formatter flightTime)
  -- [/EXAMPLE]

exampleSince :: Effect Unit
exampleSince = do
  -- [EXAMPLE JS.Temporal.ZonedDateTime.since_]
  locale <- Locale.new_ "en-US"
  start <- ZonedDateTime.from_ "2024-01-01T00:00:00[America/New_York]"
  end <- ZonedDateTime.from_ "2024-03-15T12:00:00[America/New_York]"
  elapsed <- ZonedDateTime.since_ start end
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log ("Elapsed: " <> JS.Intl.DurationFormat.format formatter elapsed)
  -- [/EXAMPLE]

exampleSubtract :: Effect Unit
exampleSubtract = do
  -- [EXAMPLE JS.Temporal.ZonedDateTime.subtract_]
  locale <- Locale.new_ "en-US"
  zoned <- ZonedDateTime.from_ "2024-03-15T14:00:00[America/New_York]"
  twoHours <- Duration.new { hours: 2 }
  earlier <- ZonedDateTime.subtract_ twoHours zoned
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long", timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter earlier)
  -- [/EXAMPLE]
