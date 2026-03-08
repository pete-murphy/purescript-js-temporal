-- | Compilable doc examples for JS.Temporal.PlainYearMonth.
module Examples.Docs.PlainYearMonth where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Intl.DateTimeFormat as JS.Intl.DateTimeFormat
import JS.Intl.DurationFormat as JS.Intl.DurationFormat
import JS.Intl.Locale as JS.Intl.Locale
import JS.Temporal.Duration as Duration
import JS.Temporal.Options.Overflow as Overflow
import JS.Temporal.Options.TemporalUnit as TemporalUnit
import JS.Temporal.PlainYearMonth as PlainYearMonth

exampleNew :: Effect Unit
exampleNew = do
  -- [EXAMPLE JS.Temporal.PlainYearMonth.new]
  locale <- JS.Intl.Locale.new_ "en-US"
  yearMonth <- PlainYearMonth.new 2024 6
  firstDay <- PlainYearMonth.toPlainDate { day: 1 } yearMonth
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter firstDay)
  -- [/EXAMPLE]

exampleFrom :: Effect Unit
exampleFrom = do
  -- [EXAMPLE JS.Temporal.PlainYearMonth.from]
  locale <- JS.Intl.Locale.new_ "en-US"
  yearMonth <- PlainYearMonth.from { overflow: Overflow.Constrain } "2024-06"
  firstDay <- PlainYearMonth.toPlainDate { day: 1 } yearMonth
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter firstDay)
  -- [/EXAMPLE]

exampleAdd :: Effect Unit
exampleAdd = do
  -- [EXAMPLE JS.Temporal.PlainYearMonth.add]
  locale <- JS.Intl.Locale.new_ "en-US"
  yearMonth <- PlainYearMonth.from_ "2024-06"
  threeMonths <- Duration.new { months: 3 }
  later <- PlainYearMonth.add { overflow: Overflow.Constrain } threeMonths yearMonth
  firstDay <- PlainYearMonth.toPlainDate { day: 1 } later
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter firstDay)
  -- [/EXAMPLE]

exampleSubtract :: Effect Unit
exampleSubtract = do
  -- [EXAMPLE JS.Temporal.PlainYearMonth.subtract]
  locale <- JS.Intl.Locale.new_ "en-US"
  yearMonth <- PlainYearMonth.from_ "2024-06"
  twoMonths <- Duration.new { months: 2 }
  earlier <- PlainYearMonth.subtract { overflow: Overflow.Constrain } twoMonths yearMonth
  firstDay <- PlainYearMonth.toPlainDate { day: 1 } earlier
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter firstDay)
  -- [/EXAMPLE]

exampleWith :: Effect Unit
exampleWith = do
  -- [EXAMPLE JS.Temporal.PlainYearMonth.with]
  locale <- JS.Intl.Locale.new_ "en-US"
  yearMonth <- PlainYearMonth.from_ "2024-06"
  changed <- PlainYearMonth.with { overflow: Overflow.Constrain } { month: 12 } yearMonth
  firstDay <- PlainYearMonth.toPlainDate { day: 1 } changed
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter firstDay)
  -- [/EXAMPLE]

exampleUntil :: Effect Unit
exampleUntil = do
  -- [EXAMPLE JS.Temporal.PlainYearMonth.until]
  locale <- JS.Intl.Locale.new_ "en-US"
  start <- PlainYearMonth.from_ "2024-01"
  end <- PlainYearMonth.from_ "2025-06"
  duration <- PlainYearMonth.until { largestUnit: TemporalUnit.Year } end start
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter duration)
  -- [/EXAMPLE]

exampleSince :: Effect Unit
exampleSince = do
  -- [EXAMPLE JS.Temporal.PlainYearMonth.since]
  locale <- JS.Intl.Locale.new_ "en-US"
  earlier <- PlainYearMonth.from_ "2022-06"
  later <- PlainYearMonth.from_ "2024-06"
  duration <- PlainYearMonth.since { largestUnit: TemporalUnit.Year } earlier later
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter duration)
  -- [/EXAMPLE]

exampleToString :: Effect Unit
exampleToString = do
  -- [EXAMPLE JS.Temporal.PlainYearMonth.toString]
  yearMonth <- PlainYearMonth.from_ "2024-06"
  Console.log (PlainYearMonth.toString {} yearMonth)
  -- [/EXAMPLE]

exampleToPlainDate :: Effect Unit
exampleToPlainDate = do
  -- [EXAMPLE JS.Temporal.PlainYearMonth.toPlainDate]
  locale <- JS.Intl.Locale.new_ "en-US"
  yearMonth <- PlainYearMonth.from_ "2024-01"
  firstDay <- PlainYearMonth.toPlainDate { day: 1 } yearMonth
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter firstDay)
  -- [/EXAMPLE]
