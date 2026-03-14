-- | Compilable doc examples for JS.Temporal.Duration.
module Examples.Docs.Duration where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Intl.DurationFormat as JS.Intl.DurationFormat
import JS.Intl.Locale as JS.Intl.Locale
import JS.Intl.NumberFormat as JS.Intl.NumberFormat
import JS.Temporal.Duration as Duration
import JS.Temporal.Options.TemporalUnit as TemporalUnit

exampleFromString :: Effect Unit
exampleFromString = do
  -- [EXAMPLE JS.Temporal.Duration.fromString]
  locale <- JS.Intl.Locale.new_ "en-US"
  duration <- Duration.fromString "PT2H30M"
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter duration)
  -- [/EXAMPLE]

exampleFrom :: Effect Unit
exampleFrom = do
  -- [EXAMPLE JS.Temporal.Duration.from]
  locale <- JS.Intl.Locale.new_ "en-US"
  twoHours <- Duration.from { hours: 2 }
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter twoHours)
  -- [/EXAMPLE]

exampleTotal :: Effect Unit
exampleTotal = do
  -- [EXAMPLE JS.Temporal.Duration.total]
  locale <- JS.Intl.Locale.new_ "en-US"
  duration <- Duration.from { hours: 2, minutes: 30 }
  totalHours <- Duration.total { unit: TemporalUnit.Hour } duration
  numberFormatter <- JS.Intl.NumberFormat.new [ locale ] { minimumFractionDigits: 1, maximumFractionDigits: 1 }
  Console.log ("Total hours: " <> JS.Intl.NumberFormat.format numberFormatter totalHours)
  -- [/EXAMPLE]

exampleAdd :: Effect Unit
exampleAdd = do
  -- [EXAMPLE JS.Temporal.Duration.add]
  locale <- JS.Intl.Locale.new_ "en-US"
  twoHours <- Duration.from { hours: 2 }
  thirtyMinutes <- Duration.from { minutes: 30 }
  combined <- Duration.add twoHours thirtyMinutes
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter combined)
  -- [/EXAMPLE]

exampleSubtract :: Effect Unit
exampleSubtract = do
  -- [EXAMPLE JS.Temporal.Duration.subtract]
  locale <- JS.Intl.Locale.new_ "en-US"
  threeHours <- Duration.from { hours: 3 }
  oneHour <- Duration.from { hours: 1 }
  remainder <- Duration.subtract threeHours oneHour
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter remainder)
  -- [/EXAMPLE]

exampleWith :: Effect Unit
exampleWith = do
  -- [EXAMPLE JS.Temporal.Duration.with]
  locale <- JS.Intl.Locale.new_ "en-US"
  duration <- Duration.from { hours: 2, minutes: 30 }
  updated <- Duration.with { minutes: 45 } duration
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter updated)
  -- [/EXAMPLE]

exampleCompare :: Effect Unit
exampleCompare = do
  -- [EXAMPLE JS.Temporal.Duration.compare]
  shorter <- Duration.from { hours: 1 }
  longer <- Duration.from { hours: 2 }
  ordering <- Duration.compare longer shorter
  Console.log ("Comparison result: " <> show ordering)
  -- [/EXAMPLE]

exampleRound :: Effect Unit
exampleRound = do
  -- [EXAMPLE JS.Temporal.Duration.round]
  roundedSource <- Duration.from { hours: 1, minutes: 30, seconds: 45 }
  rounded <- Duration.round { smallestUnit: TemporalUnit.Minute } roundedSource
  Console.log (Duration.toString_ rounded)
  -- [/EXAMPLE]

exampleToString :: Effect Unit
exampleToString = do
  -- [EXAMPLE JS.Temporal.Duration.toString]
  duration <- Duration.from { hours: 2, minutes: 30, seconds: 15, milliseconds: 400 }
  Console.log (Duration.toString { smallestUnit: TemporalUnit.Second } duration)
  -- [/EXAMPLE]
