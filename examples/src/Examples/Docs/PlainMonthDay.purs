-- | Compilable doc examples for JS.Temporal.PlainMonthDay.
module Examples.Docs.PlainMonthDay where

import Prelude

import Effect (Effect)
import Effect.Class.Console as Console
import JS.Intl.DateTimeFormat as JS.Intl.DateTimeFormat
import JS.Intl.Locale as JS.Intl.Locale
import JS.Temporal.Options.Overflow as Overflow
import JS.Temporal.PlainMonthDay as PlainMonthDay

-- | Creates a PlainMonthDay from component fields. Options: overflow.
exampleFromWithOptions :: Effect Unit
exampleFromWithOptions = do
  holiday <- PlainMonthDay.fromWithOptions { overflow: Overflow.Constrain } { month: 7, day: 4 }
  Console.log (PlainMonthDay.toString holiday)

-- | Same as [`fromWithOptions`](#v:fromWithOptions) with default options.
exampleFrom :: Effect Unit
exampleFrom = do
  locale <- JS.Intl.Locale.new_ "en-US"
  holiday <- PlainMonthDay.from { month: 7, day: 4 }
  holidayIn2024 <- PlainMonthDay.toPlainDate { year: 2024 } holiday
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log (JS.Intl.DateTimeFormat.format formatter holidayIn2024)

-- | Creates a PlainMonthDay from an RFC 9557 / ISO 8601 month-day string
-- | (e.g. `"12-15"` or `"--01-15"`). Options: overflow.
exampleFromStringWithOptions :: Effect Unit
exampleFromStringWithOptions = do
  birthday <- PlainMonthDay.fromStringWithOptions { overflow: Overflow.Constrain } "12-15"
  Console.log (PlainMonthDay.toString birthday)

-- | Same as [`fromStringWithOptions`](#v:fromStringWithOptions) with default options.
exampleFromString :: Effect Unit
exampleFromString = do
  birthday <- PlainMonthDay.fromString "12-15"
  Console.log (PlainMonthDay.toString birthday)

-- | Calendar-specific month code, such as `M12`.
exampleMonthCode :: Effect Unit
exampleMonthCode = do
  mday <- PlainMonthDay.fromString "03-14"
  Console.log ("Month code: " <> PlainMonthDay.monthCode mday)

-- | Day of the month.
exampleDay :: Effect Unit
exampleDay = do
  mday <- PlainMonthDay.fromString "03-14"
  Console.log ("Day: " <> show (PlainMonthDay.day mday))

-- | Calendar identifier, such as `"iso8601"`.
exampleCalendarId :: Effect Unit
exampleCalendarId = do
  mday <- PlainMonthDay.fromString "03-14"
  Console.log ("Calendar: " <> PlainMonthDay.calendarId mday)

-- | Returns a new PlainMonthDay with specified fields replaced. Options: overflow.
exampleWithWithOptions :: Effect Unit
exampleWithWithOptions = do
  original <- PlainMonthDay.fromString "01-15"
  changed <- PlainMonthDay.withWithOptions { overflow: Overflow.Constrain } { day: 31 } original
  Console.log (PlainMonthDay.toString changed)

-- | Same as [`withWithOptions`](#v:withWithOptions) with default options.
exampleWith :: Effect Unit
exampleWith = do
  original <- PlainMonthDay.fromString "01-15"
  changed <- PlainMonthDay.with { day: 28 } original
  Console.log (PlainMonthDay.toString changed)

-- | Converts to PlainDate by supplying a year.
exampleToPlainDate :: Effect Unit
exampleToPlainDate = do
  locale <- JS.Intl.Locale.new_ "en-US"
  birthday <- PlainMonthDay.fromString "12-15"
  birthdayIn2030 <- PlainMonthDay.toPlainDate { year: 2030 } birthday
  formatter <- JS.Intl.DateTimeFormat.new [ locale ] { dateStyle: "long" }
  Console.log ("Birthday in 2030: " <> JS.Intl.DateTimeFormat.format formatter birthdayIn2030)

-- | Creates a `PlainMonthDay` from purescript-datetime `Month` and `Day` components.
exampleFromDateComponents :: Effect Unit
exampleFromDateComponents = do
  monthDay <- PlainMonthDay.fromString "12-15"
  roundTripped <- PlainMonthDay.fromDateComponents (PlainMonthDay.toDateComponents monthDay)
  Console.log (PlainMonthDay.toString roundTripped)

-- | Converts a `PlainMonthDay` to its purescript-datetime `Month` and `Day` components.
exampleToDateComponents :: Effect Unit
exampleToDateComponents = do
  monthDay <- PlainMonthDay.fromString "12-15"
  let components = PlainMonthDay.toDateComponents monthDay
  Console.log (show components.month <> " " <> show components.day)

-- | Serializes to ISO 8601 month-day format. Options: calendarName.
exampleToStringWithOptions :: Effect Unit
exampleToStringWithOptions = do
  mday <- PlainMonthDay.fromString "03-14"
  Console.log (PlainMonthDay.toStringWithOptions {} mday)

-- | Same as [`toStringWithOptions`](#v:toStringWithOptions) with default options.
exampleToString :: Effect Unit
exampleToString = do
  mday <- PlainMonthDay.fromString "03-14"
  Console.log (PlainMonthDay.toString mday)
