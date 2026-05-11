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

-- [EXAMPLE JS.Temporal.PlainYearMonth.from]
exampleFrom :: Effect Unit
exampleFrom = do
  locale <- JS.Intl.Locale.new_ "en-US"
  yearMonth <- PlainYearMonth.from { year: 2024, month: 6 }
  firstDay <- PlainYearMonth.toPlainDate { day: 1 } yearMonth
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter firstDay)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.PlainYearMonth.fromString]
exampleFromString :: Effect Unit
exampleFromString = do
  locale <- JS.Intl.Locale.new_ "en-US"
  yearMonth <- PlainYearMonth.fromStringWithOptions { overflow: Overflow.Constrain } "2024-06"
  firstDay <- PlainYearMonth.toPlainDate { day: 1 } yearMonth
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter firstDay)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.PlainYearMonth.add]
exampleAdd :: Effect Unit
exampleAdd = do
  locale <- JS.Intl.Locale.new_ "en-US"
  yearMonth <- PlainYearMonth.fromString "2024-06"
  threeMonths <- Duration.from { months: 3 }
  later <- PlainYearMonth.addWithOptions { overflow: Overflow.Constrain } threeMonths yearMonth
  firstDay <- PlainYearMonth.toPlainDate { day: 1 } later
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter firstDay)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.PlainYearMonth.subtract]
exampleSubtract :: Effect Unit
exampleSubtract = do
  locale <- JS.Intl.Locale.new_ "en-US"
  yearMonth <- PlainYearMonth.fromString "2024-06"
  twoMonths <- Duration.from { months: 2 }
  earlier <- PlainYearMonth.subtractWithOptions { overflow: Overflow.Constrain } twoMonths yearMonth
  firstDay <- PlainYearMonth.toPlainDate { day: 1 } earlier
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter firstDay)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.PlainYearMonth.with]
exampleWith :: Effect Unit
exampleWith = do
  locale <- JS.Intl.Locale.new_ "en-US"
  yearMonth <- PlainYearMonth.fromString "2024-06"
  changed <- PlainYearMonth.withWithOptions { overflow: Overflow.Constrain } { month: 12 } yearMonth
  firstDay <- PlainYearMonth.toPlainDate { day: 1 } changed
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter firstDay)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.PlainYearMonth.until]
exampleUntil :: Effect Unit
exampleUntil = do
  locale <- JS.Intl.Locale.new_ "en-US"
  start <- PlainYearMonth.fromString "2024-01"
  end <- PlainYearMonth.fromString "2025-06"
  duration <- PlainYearMonth.untilWithOptions { largestUnit: TemporalUnit.Year } end start
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter duration)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.PlainYearMonth.since]
exampleSince :: Effect Unit
exampleSince = do
  locale <- JS.Intl.Locale.new_ "en-US"
  earlier <- PlainYearMonth.fromString "2022-06"
  later <- PlainYearMonth.fromString "2024-06"
  duration <- PlainYearMonth.sinceWithOptions { largestUnit: TemporalUnit.Year } earlier later
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter duration)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.PlainYearMonth.toString]
exampleToString :: Effect Unit
exampleToString = do
  yearMonth <- PlainYearMonth.fromString "2024-06"
  Console.log (PlainYearMonth.toStringWithOptions {} yearMonth)

-- [/EXAMPLE]

-- [EXAMPLE JS.Temporal.PlainYearMonth.toPlainDate]
exampleToPlainDate :: Effect Unit
exampleToPlainDate = do
  locale <- JS.Intl.Locale.new_ "en-US"
  yearMonth <- PlainYearMonth.fromString "2024-01"
  firstDay <- PlainYearMonth.toPlainDate { day: 1 } yearMonth
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter firstDay)
-- [/EXAMPLE]

