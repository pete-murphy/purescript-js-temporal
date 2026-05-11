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

-- [EXAMPLE JS.Temporal.PlainTime.from_]
exampleFrom_ :: Effect Unit
exampleFrom_ = do
  locale <- JS.Intl.Locale.new_ "en-US"
  time <- PlainTime.from_
    { hour: 9
    , minute: 30
    , second: 0
    }
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter time)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.PlainTime.fromString]
exampleFromString :: Effect Unit
exampleFromString = do
  locale <- JS.Intl.Locale.new_ "en-US"
  time <- PlainTime.fromString { overflow: Overflow.Constrain } "15:30:00"
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter time)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.PlainTime.add]
exampleAdd :: Effect Unit
exampleAdd = do
  locale <- JS.Intl.Locale.new_ "en-US"
  time <- PlainTime.fromString_ "14:30:00"
  twoHours <- Duration.from { hours: 2 }
  later <- PlainTime.add twoHours time
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter later)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.PlainTime.with]
exampleWith :: Effect Unit
exampleWith = do
  locale <- JS.Intl.Locale.new_ "en-US"
  time <- PlainTime.fromString_ "15:30:45"
  noon <- PlainTime.with { overflow: Overflow.Constrain } { hour: 12, minute: 0, second: 0 } time
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter noon)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.PlainTime.until]
exampleUntil :: Effect Unit
exampleUntil = do
  locale <- JS.Intl.Locale.new_ "en-US"
  start <- PlainTime.fromString_ "09:00:00"
  end <- PlainTime.fromString_ "17:30:00"
  duration <- PlainTime.until { largestUnit: TemporalUnit.Hour } end start
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter duration)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.PlainTime.since]
exampleSince :: Effect Unit
exampleSince = do
  locale <- JS.Intl.Locale.new_ "en-US"
  earlier <- PlainTime.fromString_ "08:00:00"
  later <- PlainTime.fromString_ "12:30:00"
  duration <- PlainTime.since { largestUnit: TemporalUnit.Hour } earlier later
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter duration)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.PlainTime.subtract]
exampleSubtract :: Effect Unit
exampleSubtract = do
  locale <- JS.Intl.Locale.new_ "en-US"
  time <- PlainTime.fromString_ "14:30:00"
  twoHours <- Duration.from { hours: 2 }
  earlier <- PlainTime.subtract twoHours time
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter earlier)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.PlainTime.round]
exampleRound :: Effect Unit
exampleRound = do
  locale <- JS.Intl.Locale.new_ "en-US"
  time <- PlainTime.fromString_ "09:30:45.123"
  rounded <- PlainTime.round { smallestUnit: TemporalUnit.Minute } time
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter rounded)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.PlainTime.toString]
exampleToString :: Effect Unit
exampleToString = do
  time <- PlainTime.fromString_ "14:30:45.123"
  Console.log (PlainTime.toString { smallestUnit: TemporalUnit.Millisecond } time)
-- [/EXAMPLE]

