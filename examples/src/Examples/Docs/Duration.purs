-- | Compilable doc examples for JS.Temporal.Duration.
module Examples.Docs.Duration where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Intl.DurationFormat as JS.Intl.DurationFormat
import JS.Intl.Locale as Locale
import JS.Intl.NumberFormat as JS.Intl.NumberFormat
import JS.Temporal.Duration as Duration
import JS.Temporal.Options.TemporalUnit as TemporalUnit

exampleFrom :: Effect Unit
exampleFrom = do
  -- [EXAMPLE JS.Temporal.Duration.from]
  locale <- Locale.new_ "en-US"
  duration <- Duration.from "PT2H30M"
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter duration)
  -- [/EXAMPLE]

exampleNew :: Effect Unit
exampleNew = do
  -- [EXAMPLE JS.Temporal.Duration.new]
  locale <- Locale.new_ "en-US"
  twoHours <- Duration.new { hours: 2 }
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter twoHours)
  -- [/EXAMPLE]

exampleTotal :: Effect Unit
exampleTotal = do
  -- [EXAMPLE JS.Temporal.Duration.total]
  locale <- Locale.new_ "en-US"
  duration <- Duration.new { hours: 2, minutes: 30 }
  totalHours <- Duration.total { unit: TemporalUnit.Hour } duration
  numberFormatter <- JS.Intl.NumberFormat.new [ locale ] { minimumFractionDigits: 1, maximumFractionDigits: 1 }
  Console.log ("Total hours: " <> JS.Intl.NumberFormat.format numberFormatter totalHours)
  -- [/EXAMPLE]

exampleSubtract :: Effect Unit
exampleSubtract = do
  -- [EXAMPLE JS.Temporal.Duration.subtract]
  locale <- Locale.new_ "en-US"
  threeHours <- Duration.new { hours: 3 }
  oneHour <- Duration.new { hours: 1 }
  remainder <- Duration.subtract threeHours oneHour
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter remainder)
  -- [/EXAMPLE]
