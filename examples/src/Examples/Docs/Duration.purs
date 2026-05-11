-- | Compilable doc examples for JS.Temporal.Duration.
module Examples.Docs.Duration where

import Prelude

import Data.Maybe (Maybe(..))
import Data.Time.Duration (Milliseconds(..))
import Effect (Effect)
import Effect.Class.Console as Console
import JS.Intl.DurationFormat as JS.Intl.DurationFormat
import JS.Intl.Locale as JS.Intl.Locale
import JS.Intl.NumberFormat as JS.Intl.NumberFormat
import JS.Temporal.Duration as Duration
import JS.Temporal.Options.TemporalUnit as TemporalUnit

exampleFromString :: Effect Unit
exampleFromString = do
  locale <- JS.Intl.Locale.new_ "en-US"
  duration <- Duration.fromString "PT2H30M"
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter duration)

exampleFrom :: Effect Unit
exampleFrom = do
  locale <- JS.Intl.Locale.new_ "en-US"
  twoHours <- Duration.from { hours: 2 }
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter twoHours)

exampleYears :: Effect Unit
exampleYears = do
  duration <- Duration.from { years: 3, months: 6 }
  Console.log ("Years: " <> show (Duration.years duration))

exampleMonths :: Effect Unit
exampleMonths = do
  duration <- Duration.from { years: 3, months: 6 }
  Console.log ("Months: " <> show (Duration.months duration))

exampleWeeks :: Effect Unit
exampleWeeks = do
  duration <- Duration.from { weeks: 2 }
  Console.log ("Weeks: " <> show (Duration.weeks duration))

exampleDays :: Effect Unit
exampleDays = do
  duration <- Duration.from { days: 10 }
  Console.log ("Days: " <> show (Duration.days duration))

exampleHours :: Effect Unit
exampleHours = do
  duration <- Duration.from { hours: 5 }
  Console.log ("Hours: " <> show (Duration.hours duration))

exampleMinutes :: Effect Unit
exampleMinutes = do
  duration <- Duration.from { minutes: 45 }
  Console.log ("Minutes: " <> show (Duration.minutes duration))

exampleSeconds :: Effect Unit
exampleSeconds = do
  duration <- Duration.from { seconds: 30 }
  Console.log ("Seconds: " <> show (Duration.seconds duration))

exampleMilliseconds :: Effect Unit
exampleMilliseconds = do
  duration <- Duration.from { milliseconds: 500 }
  Console.log ("Milliseconds: " <> show (Duration.milliseconds duration))

exampleMicroseconds :: Effect Unit
exampleMicroseconds = do
  duration <- Duration.from { microseconds: 250 }
  Console.log ("Microseconds: " <> show (Duration.microseconds duration))

exampleNanoseconds :: Effect Unit
exampleNanoseconds = do
  duration <- Duration.from { nanoseconds: 100 }
  Console.log ("Nanoseconds: " <> show (Duration.nanoseconds duration))

exampleSign :: Effect Unit
exampleSign = do
  positive <- Duration.from { hours: 2 }
  Console.log ("Sign of 2h: " <> show (Duration.sign positive))
  negated <- pure (Duration.negated positive)
  Console.log ("Sign of -2h: " <> show (Duration.sign negated))

exampleBlank :: Effect Unit
exampleBlank = do
  zero <- Duration.from { hours: 0 }
  nonZero <- Duration.from { hours: 1 }
  Console.log ("Zero is blank: " <> show (Duration.blank zero))
  Console.log ("1h is blank: " <> show (Duration.blank nonZero))

exampleNegated :: Effect Unit
exampleNegated = do
  locale <- JS.Intl.Locale.new_ "en-US"
  duration <- Duration.from { hours: 2, minutes: 30 }
  let neg = Duration.negated duration
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter neg)

exampleAbs :: Effect Unit
exampleAbs = do
  locale <- JS.Intl.Locale.new_ "en-US"
  duration <- Duration.from { hours: 2 }
  let neg = Duration.negated duration
  let positive = Duration.abs neg
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter positive)

exampleTotal :: Effect Unit
exampleTotal = do
  locale <- JS.Intl.Locale.new_ "en-US"
  duration <- Duration.from { hours: 2, minutes: 30 }
  totalHours <- Duration.total { unit: TemporalUnit.Hour } duration
  numberFormatter <- JS.Intl.NumberFormat.new [ locale ] { minimumFractionDigits: 1, maximumFractionDigits: 1 }
  Console.log ("Total hours: " <> JS.Intl.NumberFormat.format numberFormatter totalHours)

exampleAdd :: Effect Unit
exampleAdd = do
  locale <- JS.Intl.Locale.new_ "en-US"
  twoHours <- Duration.from { hours: 2 }
  thirtyMinutes <- Duration.from { minutes: 30 }
  combined <- Duration.add twoHours thirtyMinutes
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter combined)

exampleSubtract :: Effect Unit
exampleSubtract = do
  locale <- JS.Intl.Locale.new_ "en-US"
  threeHours <- Duration.from { hours: 3 }
  oneHour <- Duration.from { hours: 1 }
  remainder <- Duration.subtract threeHours oneHour
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter remainder)

exampleWith :: Effect Unit
exampleWith = do
  locale <- JS.Intl.Locale.new_ "en-US"
  duration <- Duration.from { hours: 2, minutes: 30 }
  updated <- Duration.with { minutes: 45 } duration
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter updated)

exampleCompare :: Effect Unit
exampleCompare = do
  shorter <- Duration.from { hours: 1 }
  longer <- Duration.from { hours: 2 }
  ordering <- Duration.compare longer shorter
  Console.log ("Comparison result: " <> show ordering)

exampleRound :: Effect Unit
exampleRound = do
  roundedSource <- Duration.from { hours: 1, minutes: 30, seconds: 45 }
  rounded <- Duration.round { largestUnit: TemporalUnit.Hour, smallestUnit: TemporalUnit.Second } roundedSource
  Console.log (Duration.toString rounded)

exampleToString :: Effect Unit
exampleToString = do
  duration <- Duration.from { hours: 2, minutes: 30, seconds: 15, milliseconds: 400 }
  Console.log (Duration.toString duration)

exampleToStringWithOptions :: Effect Unit
exampleToStringWithOptions = do
  duration <- Duration.from { hours: 2, minutes: 30, seconds: 15, milliseconds: 400 }
  Console.log (Duration.toStringWithOptions { smallestUnit: TemporalUnit.Second } duration)

exampleFromMilliseconds :: Effect Unit
exampleFromMilliseconds = do
  duration <- Duration.fromMilliseconds (Milliseconds 5000.0)
  Console.log (Duration.toString duration)

exampleToMilliseconds :: Effect Unit
exampleToMilliseconds = do
  duration <- Duration.from { seconds: 5 }
  case Duration.toMilliseconds duration of
    Just (Milliseconds ms) -> Console.log ("Milliseconds: " <> show ms)
    Nothing -> Console.log "Cannot convert (has calendar units)"
