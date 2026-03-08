-- | Compilable doc examples for JS.Temporal.PlainTime.
module Examples.Docs.PlainTime where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Intl.DateTimeFormat as JS.Intl.DateTimeFormat
import JS.Intl.Locale as Locale
import JS.Temporal.Duration as Duration
import JS.Temporal.PlainTime as PlainTime

exampleFrom :: Effect Unit
exampleFrom = do
  -- [EXAMPLE JS.Temporal.PlainTime.from_]
  locale <- Locale.new_ "en-US"
  time <- PlainTime.from_ "15:30:00"
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter time)
  -- [/EXAMPLE]

exampleSubtract :: Effect Unit
exampleSubtract = do
  -- [EXAMPLE JS.Temporal.PlainTime.subtract]
  locale <- Locale.new_ "en-US"
  time <- PlainTime.from_ "14:30:00"
  twoHours <- Duration.new { hours: 2 }
  earlier <- PlainTime.subtract twoHours time
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { timeStyle: "medium" }
  Console.log (JS.Intl.DateTimeFormat.format formatter earlier)
  -- [/EXAMPLE]
