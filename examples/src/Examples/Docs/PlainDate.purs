-- | Compilable doc examples for JS.Temporal.PlainDate.
module Examples.Docs.PlainDate where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Intl.DateTimeFormat as JS.Intl.DateTimeFormat
import JS.Intl.DurationFormat as JS.Intl.DurationFormat
import JS.Intl.Locale as JS.Intl.Locale
import JS.Temporal.Duration as Duration
import JS.Temporal.Now as Now
import JS.Temporal.Options.CalendarName as CalendarName
import JS.Temporal.Options.Overflow as Overflow
import JS.Temporal.Options.TemporalUnit as TemporalUnit
import JS.Temporal.PlainDate as PlainDate
import JS.Temporal.PlainDateTime as PlainDateTime
import JS.Temporal.PlainMonthDay as PlainMonthDay
import JS.Temporal.PlainTime as PlainTime
import JS.Temporal.PlainYearMonth as PlainYearMonth
import JS.Temporal.ZonedDateTime as ZonedDateTime

exampleNew :: Effect Unit
exampleNew = do
  -- [EXAMPLE JS.Temporal.PlainDate.new]
  locale <- JS.Intl.Locale.new_ "en-US"
  date <- PlainDate.new 2024 7 1
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter date)
  -- [/EXAMPLE]

exampleFrom :: Effect Unit
exampleFrom = do
  -- [EXAMPLE JS.Temporal.PlainDate.from]
  locale <- JS.Intl.Locale.new_ "en-US"
  date <- PlainDate.from { overflow: Overflow.Constrain } "2024-01-15"
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter date)
  -- [/EXAMPLE]

exampleAdd :: Effect Unit
exampleAdd = do
  -- [EXAMPLE JS.Temporal.PlainDate.add]
  locale <- JS.Intl.Locale.new_ "en-US"
  date <- PlainDate.from_ "2024-03-15"
  oneWeek <- Duration.new { weeks: 1 }
  later <- PlainDate.add { overflow: Overflow.Constrain } oneWeek date
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter later)
  -- [/EXAMPLE]

exampleUntil :: Effect Unit
exampleUntil = do
  -- [EXAMPLE JS.Temporal.PlainDate.until]
  locale <- JS.Intl.Locale.new_ "en-US"
  today <- Now.plainDateISO_
  futureDate <- PlainDate.from_ "2026-12-25"
  untilDuration <- PlainDate.until { largestUnit: TemporalUnit.Day } futureDate today
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log (JS.Intl.DurationFormat.format formatter untilDuration <> " until Christmas 2026")
  -- [/EXAMPLE]

exampleSince :: Effect Unit
exampleSince = do
  -- [EXAMPLE JS.Temporal.PlainDate.since]
  locale <- JS.Intl.Locale.new_ "en-US"
  start <- PlainDate.from_ "2024-01-01"
  end <- PlainDate.from_ "2024-03-15"
  elapsed <- PlainDate.since { largestUnit: TemporalUnit.Day } start end
  formatter <- JS.Intl.DurationFormat.new [ locale ] { style: "long" }
  Console.log ("Elapsed: " <> JS.Intl.DurationFormat.format formatter elapsed)
  -- [/EXAMPLE]

exampleWith :: Effect Unit
exampleWith = do
  -- [EXAMPLE JS.Temporal.PlainDate.with]
  locale <- JS.Intl.Locale.new_ "en-US"
  date <- PlainDate.from_ "2021-07-06"
  lastDayOfMonth <- PlainDate.with { overflow: Overflow.Constrain } { day: PlainDate.daysInMonth date } date
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter lastDayOfMonth)
  -- [/EXAMPLE]

exampleWithCalendar :: Effect Unit
exampleWithCalendar = do
  -- [EXAMPLE JS.Temporal.PlainDate.withCalendar]
  date <- PlainDate.from_ "2024-01-15"
  gregory <- PlainDate.withCalendar "gregory" date
  Console.log (PlainDate.toString { calendarName: CalendarName.Always } gregory)
  -- [/EXAMPLE]

exampleSubtract :: Effect Unit
exampleSubtract = do
  -- [EXAMPLE JS.Temporal.PlainDate.subtract]
  locale <- JS.Intl.Locale.new_ "en-US"
  date <- PlainDate.from_ "2024-03-15"
  oneWeek <- Duration.new { weeks: 1 }
  earlier <- PlainDate.subtract { overflow: Overflow.Constrain } oneWeek date
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter earlier)
  -- [/EXAMPLE]

exampleToString :: Effect Unit
exampleToString = do
  -- [EXAMPLE JS.Temporal.PlainDate.toString]
  date <- PlainDate.from_ "2024-01-15"
  Console.log (PlainDate.toString { calendarName: CalendarName.Never } date)
  -- [/EXAMPLE]

exampleToPlainYearMonth :: Effect Unit
exampleToPlainYearMonth = do
  -- [EXAMPLE JS.Temporal.PlainDate.toPlainYearMonth]
  date <- PlainDate.from_ "2024-01-15"
  Console.log (PlainYearMonth.toString_ (PlainDate.toPlainYearMonth date))
  -- [/EXAMPLE]

exampleToPlainMonthDay :: Effect Unit
exampleToPlainMonthDay = do
  -- [EXAMPLE JS.Temporal.PlainDate.toPlainMonthDay]
  date <- PlainDate.from_ "2024-01-15"
  Console.log (PlainMonthDay.toString_ (PlainDate.toPlainMonthDay date))
  -- [/EXAMPLE]

exampleToPlainDateTime :: Effect Unit
exampleToPlainDateTime = do
  -- [EXAMPLE JS.Temporal.PlainDate.toPlainDateTime]
  date <- PlainDate.from_ "2024-01-15"
  time <- PlainTime.from_ "09:30:00"
  Console.log (PlainDateTime.toString_ (PlainDate.toPlainDateTime time date))
  -- [/EXAMPLE]

exampleToZonedDateTime :: Effect Unit
exampleToZonedDateTime = do
  -- [EXAMPLE JS.Temporal.PlainDate.toZonedDateTime]
  date <- PlainDate.from_ "2024-01-15"
  zoned <- PlainDate.toZonedDateTime "America/New_York" date
  Console.log (ZonedDateTime.toString_ zoned)
  -- [/EXAMPLE]
