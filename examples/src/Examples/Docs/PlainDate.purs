-- | Compilable doc examples for JS.Temporal.PlainDate.
module Examples.Docs.PlainDate where

import Prelude

import Data.Int as Int
import Effect (Effect)
import Effect.Class.Console as Console
import JS.Intl.DateTimeFormat as JS.Intl.DateTimeFormat
import JS.Intl.Locale as Locale
import JS.Intl.NumberFormat as JS.Intl.NumberFormat
import JS.Temporal.Duration as Duration
import JS.Temporal.Now as Now
import JS.Temporal.Options.TemporalUnit as TemporalUnit
import JS.Temporal.PlainDate as PlainDate

exampleFrom :: Effect Unit
exampleFrom = do
  -- [EXAMPLE JS.Temporal.PlainDate.from_]
  locale <- Locale.new_ "en-US"
  date <- PlainDate.from_ "2024-01-15"
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter date)
  -- [/EXAMPLE]

exampleUntil :: Effect Unit
exampleUntil = do
  -- [EXAMPLE JS.Temporal.PlainDate.until]
  locale <- Locale.new_ "en-US"
  today <- Now.plainDateISO_
  futureDate <- PlainDate.from_ "2026-12-25"
  untilDuration <- PlainDate.until { largestUnit: TemporalUnit.Day } futureDate today
  numberFormatter <- JS.Intl.NumberFormat.new [ locale ] {}
  Console.log ("Days until Christmas 2026: " <> JS.Intl.NumberFormat.format numberFormatter (Int.toNumber (Duration.days untilDuration)))
  -- [/EXAMPLE]

exampleSince :: Effect Unit
exampleSince = do
  -- [EXAMPLE JS.Temporal.PlainDate.since]
  locale <- Locale.new_ "en-US"
  start <- PlainDate.from_ "2024-01-01"
  end <- PlainDate.from_ "2024-03-15"
  elapsed <- PlainDate.since { largestUnit: TemporalUnit.Day } start end
  numberFormatter <- JS.Intl.NumberFormat.new [ locale ] {}
  Console.log ("Elapsed: " <> JS.Intl.NumberFormat.format numberFormatter (Int.toNumber (Duration.days elapsed)) <> " days")
  -- [/EXAMPLE]

exampleSubtract :: Effect Unit
exampleSubtract = do
  -- [EXAMPLE JS.Temporal.PlainDate.subtract_]
  locale <- Locale.new_ "en-US"
  date <- PlainDate.from_ "2024-03-15"
  oneWeek <- Duration.new { weeks: 1 }
  earlier <- PlainDate.subtract_ oneWeek date
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter earlier)
  -- [/EXAMPLE]
