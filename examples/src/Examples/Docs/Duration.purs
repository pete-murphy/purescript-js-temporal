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

-- [EXAMPLE JS.Temporal.Duration.fromString]
exampleFromString :: Effect Unit
exampleFromString = do
  locale <- JS.Intl.Locale.new_ "en-US"
  duration <- Duration.fromString "PT2H30M"
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter duration)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.Duration.from]
exampleFrom :: Effect Unit
exampleFrom = do
  locale <- JS.Intl.Locale.new_ "en-US"
  twoHours <- Duration.from { hours: 2 }
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter twoHours)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.Duration.total]
exampleTotal :: Effect Unit
exampleTotal = do
  locale <- JS.Intl.Locale.new_ "en-US"
  duration <- Duration.from { hours: 2, minutes: 30 }
  totalHours <- Duration.total { unit: TemporalUnit.Hour } duration
  numberFormatter <- JS.Intl.NumberFormat.new [ locale ] { minimumFractionDigits: 1, maximumFractionDigits: 1 }
  Console.log ("Total hours: " <> JS.Intl.NumberFormat.format numberFormatter totalHours)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.Duration.add]
exampleAdd :: Effect Unit
exampleAdd = do
  locale <- JS.Intl.Locale.new_ "en-US"
  twoHours <- Duration.from { hours: 2 }
  thirtyMinutes <- Duration.from { minutes: 30 }
  combined <- Duration.add twoHours thirtyMinutes
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter combined)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.Duration.subtract]
exampleSubtract :: Effect Unit
exampleSubtract = do
  locale <- JS.Intl.Locale.new_ "en-US"
  threeHours <- Duration.from { hours: 3 }
  oneHour <- Duration.from { hours: 1 }
  remainder <- Duration.subtract threeHours oneHour
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter remainder)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.Duration.with]
exampleWith :: Effect Unit
exampleWith = do
  locale <- JS.Intl.Locale.new_ "en-US"
  duration <- Duration.from { hours: 2, minutes: 30 }
  updated <- Duration.with { minutes: 45 } duration
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter updated)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.Duration.compare]
exampleCompare :: Effect Unit
exampleCompare = do
  shorter <- Duration.from { hours: 1 }
  longer <- Duration.from { hours: 2 }
  ordering <- Duration.compare longer shorter
  Console.log ("Comparison result: " <> show ordering)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.Duration.round]
exampleRound :: Effect Unit
exampleRound = do
  roundedSource <- Duration.from { hours: 1, minutes: 30, seconds: 45 }
  rounded <- Duration.round { smallestUnit: TemporalUnit.Minute } roundedSource
  Console.log (Duration.toStringWithOptions { smallestUnit: TemporalUnit.Minute } rounded)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.Duration.toStringWithOptions]
exampleToString :: Effect Unit
exampleToString = do
  duration <- Duration.from { hours: 2, minutes: 30, seconds: 15, milliseconds: 400 }
  Console.log (Duration.toStringWithOptions { smallestUnit: TemporalUnit.Second } duration)

-- [/EXAMPLE]

