-- | Compilable doc examples for JS.Temporal.PlainTime.
module Examples.Docs.PlainTime where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Intl.DateTimeFormat as JS.Intl.DateTimeFormat
import JS.Intl.DurationFormat as JS.Intl.DurationFormat
import JS.Intl.Locale as JS.Intl.Locale
import JS.Temporal.Duration as Duration
import JS.Temporal.Options.Overflow as Overflow
import JS.Temporal.Options.TemporalUnit as TemporalUnit
import JS.Temporal.PlainTime as PlainTime

exampleFrom_ :: Effect Unit
exampleFrom_ = do
  -- [EXAMPLE JS.Temporal.PlainTime.from_]
  locale <- JS.Intl.Locale.new_ "en-US"
  time <- PlainTime.from_
    { hour: 9
    , minute: 30
    , second: 0
    }
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter time)
  -- [/EXAMPLE]

exampleFromString :: Effect Unit
exampleFromString = do
  -- [EXAMPLE JS.Temporal.PlainTime.fromString]
  locale <- JS.Intl.Locale.new_ "en-US"
  time <- PlainTime.fromString { overflow: Overflow.Constrain } "15:30:00"
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter time)
  -- [/EXAMPLE]

exampleAdd :: Effect Unit
exampleAdd = do
  -- [EXAMPLE JS.Temporal.PlainTime.add]
  locale <- JS.Intl.Locale.new_ "en-US"
  time <- PlainTime.fromString_ "14:30:00"
  twoHours <- Duration.from { hours: 2 }
  later <- PlainTime.add twoHours time
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter later)
  -- [/EXAMPLE]

exampleWith :: Effect Unit
exampleWith = do
  -- [EXAMPLE JS.Temporal.PlainTime.with]
  locale <- JS.Intl.Locale.new_ "en-US"
  time <- PlainTime.fromString_ "15:30:45"
  noon <- PlainTime.with { overflow: Overflow.Constrain } { hour: 12, minute: 0, second: 0 } time
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter noon)
  -- [/EXAMPLE]

exampleUntil :: Effect Unit
exampleUntil = do
  -- [EXAMPLE JS.Temporal.PlainTime.until]
  locale <- JS.Intl.Locale.new_ "en-US"
  start <- PlainTime.fromString_ "09:00:00"
  end <- PlainTime.fromString_ "17:30:00"
  duration <- PlainTime.until { largestUnit: TemporalUnit.Hour } end start
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter duration)
  -- [/EXAMPLE]

exampleSince :: Effect Unit
exampleSince = do
  -- [EXAMPLE JS.Temporal.PlainTime.since]
  locale <- JS.Intl.Locale.new_ "en-US"
  earlier <- PlainTime.fromString_ "08:00:00"
  later <- PlainTime.fromString_ "12:30:00"
  duration <- PlainTime.since { largestUnit: TemporalUnit.Hour } earlier later
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter duration)
  -- [/EXAMPLE]

exampleSubtract :: Effect Unit
exampleSubtract = do
  -- [EXAMPLE JS.Temporal.PlainTime.subtract]
  locale <- JS.Intl.Locale.new_ "en-US"
  time <- PlainTime.fromString_ "14:30:00"
  twoHours <- Duration.from { hours: 2 }
  earlier <- PlainTime.subtract twoHours time
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter earlier)
  -- [/EXAMPLE]

exampleRound :: Effect Unit
exampleRound = do
  -- [EXAMPLE JS.Temporal.PlainTime.round]
  locale <- JS.Intl.Locale.new_ "en-US"
  time <- PlainTime.fromString_ "09:30:45.123"
  rounded <- PlainTime.round { smallestUnit: TemporalUnit.Minute } time
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter rounded)
  -- [/EXAMPLE]

exampleToString :: Effect Unit
exampleToString = do
  -- [EXAMPLE JS.Temporal.PlainTime.toString]
  time <- PlainTime.fromString_ "14:30:45.123"
  Console.log (PlainTime.toString { smallestUnit: TemporalUnit.Millisecond } time)
  -- [/EXAMPLE]
