# js-temporal

PureScript bindings for the JavaScript [Temporal API](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Temporal).

## Installation

```bash
spago install js-temporal
```

## Documentation

Module documentation is [published on Pursuit](https://pursuit.purescript.org/packages/purescript-js-temporal).

## Examples

The [`examples/`](./examples/) directory contains PureScript translations of recipes from the [Temporal Cookbook](https://tc39.es/proposal-temporal/docs/cookbook.html). Each one can be run in the browser on [Try PureScript](https://try.purescript.org):

- Frequently Asked Questions
  - [Current date and time](https://try.purescript.org/?github=pete-murphy%2Fpurescript-js-temporal%2Fmain%2Fexamples%2Fsrc%2FExamples%2FCookbook%2FCurrentDateTime.purs)
  - [Unix timestamp](https://try.purescript.org/?github=pete-murphy%2Fpurescript-js-temporal%2Fmain%2Fexamples%2Fsrc%2FExamples%2FCookbook%2FUnixTimestamp.purs)
- Converting between Temporal types and legacy Date
  - [Convert between legacy Date and Temporal](https://try.purescript.org/?github=pete-murphy%2Fpurescript-js-temporal%2Fmain%2Fexamples%2Fsrc%2FExamples%2FCookbook%2FJSDateInterop.purs)
- Construction
  - [Calendar input element](https://try.purescript.org/?github=pete-murphy%2Fpurescript-js-temporal%2Fmain%2Fexamples%2Fsrc%2FExamples%2FCookbook%2FCalendarInput.purs)
- Converting between types
  - [Noon on a particular date](https://try.purescript.org/?github=pete-murphy%2Fpurescript-js-temporal%2Fmain%2Fexamples%2Fsrc%2FExamples%2FCookbook%2FNoonOnDate.purs)
  - [Birthday in 2030](https://try.purescript.org/?github=pete-murphy%2Fpurescript-js-temporal%2Fmain%2Fexamples%2Fsrc%2FExamples%2FCookbook%2FBirthdayInYear.purs)
- Serialization
  - [Zoned instant from instant and time zone](https://try.purescript.org/?github=pete-murphy%2Fpurescript-js-temporal%2Fmain%2Fexamples%2Fsrc%2FExamples%2FCookbook%2FSerialization.purs)
- Sorting
  - [Sort PlainDateTime values](https://try.purescript.org/?github=pete-murphy%2Fpurescript-js-temporal%2Fmain%2Fexamples%2Fsrc%2FExamples%2FCookbook%2FSortPlainDateTime.purs)
  - [Sort ISO date/time strings](https://try.purescript.org/?github=pete-murphy%2Fpurescript-js-temporal%2Fmain%2Fexamples%2Fsrc%2FExamples%2FCookbook%2FSortInstantStrings.purs)
- Rounding
  - [Round a time down to whole hours](https://try.purescript.org/?github=pete-murphy%2Fpurescript-js-temporal%2Fmain%2Fexamples%2Fsrc%2FExamples%2FCookbook%2FRoundTimeDown.purs)
  - [Round a date to the nearest start of the month](https://try.purescript.org/?github=pete-murphy%2Fpurescript-js-temporal%2Fmain%2Fexamples%2Fsrc%2FExamples%2FCookbook%2FRoundDateToMonth.purs)
- Time zone conversion
  - [Preserving local time](https://try.purescript.org/?github=pete-murphy%2Fpurescript-js-temporal%2Fmain%2Fexamples%2Fsrc%2FExamples%2FCookbook%2FPreservingLocalTime.purs)
  - [Preserving exact time](https://try.purescript.org/?github=pete-murphy%2Fpurescript-js-temporal%2Fmain%2Fexamples%2Fsrc%2FExamples%2FCookbook%2FPreservingExactTime.purs)
  - [Daily occurrence in local time](https://try.purescript.org/?github=pete-murphy%2Fpurescript-js-temporal%2Fmain%2Fexamples%2Fsrc%2FExamples%2FCookbook%2FDailyOccurrence.purs)
  - [UTC offset for a zoned event](https://try.purescript.org/?github=pete-murphy%2Fpurescript-js-temporal%2Fmain%2Fexamples%2Fsrc%2FExamples%2FCookbook%2FUtcOffset.purs)
  - [Dealing with dates and times in a fixed location](https://try.purescript.org/?github=pete-murphy%2Fpurescript-js-temporal%2Fmain%2Fexamples%2Fsrc%2FExamples%2FCookbook%2FFixedLocation.purs)
  - [Book a meeting across time zones](https://try.purescript.org/?github=pete-murphy%2Fpurescript-js-temporal%2Fmain%2Fexamples%2Fsrc%2FExamples%2FCookbook%2FBookMeeting.purs)
- Arithmetic
  - [How many days until a future date](https://try.purescript.org/?github=pete-murphy%2Fpurescript-js-temporal%2Fmain%2Fexamples%2Fsrc%2FExamples%2FCookbook%2FDaysUntilFutureDate.purs)
  - [Unit-constrained duration between now and a past/future zoned event](https://try.purescript.org/?github=pete-murphy%2Fpurescript-js-temporal%2Fmain%2Fexamples%2Fsrc%2FExamples%2FCookbook%2FUnitConstrainedDuration.purs)
  - [Next offset transition in a time zone](https://try.purescript.org/?github=pete-murphy%2Fpurescript-js-temporal%2Fmain%2Fexamples%2Fsrc%2FExamples%2FCookbook%2FNextOffsetTransition.purs)
  - [Comparison of an exact time to business hours](https://try.purescript.org/?github=pete-murphy%2Fpurescript-js-temporal%2Fmain%2Fexamples%2Fsrc%2FExamples%2FCookbook%2FBusinessHours.purs)
  - [Flight arrival/departure/duration](https://try.purescript.org/?github=pete-murphy%2Fpurescript-js-temporal%2Fmain%2Fexamples%2Fsrc%2FExamples%2FCookbook%2FFlightDuration.purs)
  - [Push back a launch date](https://try.purescript.org/?github=pete-murphy%2Fpurescript-js-temporal%2Fmain%2Fexamples%2Fsrc%2FExamples%2FCookbook%2FPushBackLaunchDate.purs)
  - [Schedule a reminder ahead of matching a record-setting duration](https://try.purescript.org/?github=pete-murphy%2Fpurescript-js-temporal%2Fmain%2Fexamples%2Fsrc%2FExamples%2FCookbook%2FRecordReminder.purs)
  - [Nth weekday of the month](https://try.purescript.org/?github=pete-murphy%2Fpurescript-js-temporal%2Fmain%2Fexamples%2Fsrc%2FExamples%2FCookbook%2FNthWeekdayOfMonth.purs) ([variant](https://try.purescript.org/?github=pete-murphy%2Fpurescript-js-temporal%2Fmain%2Fexamples%2Fsrc%2FExamples%2FCookbook%2FGetWeeklyDaysInMonth.purs))
  - [Manipulating the day of the month](https://try.purescript.org/?github=pete-murphy%2Fpurescript-js-temporal%2Fmain%2Fexamples%2Fsrc%2FExamples%2FCookbook%2FManipulatingDayOfMonth.purs)
  - [Same date in another month](https://try.purescript.org/?github=pete-murphy%2Fpurescript-js-temporal%2Fmain%2Fexamples%2Fsrc%2FExamples%2FCookbook%2FSameDateInAnotherMonth.purs)
  - [Next weekly occurrence](https://try.purescript.org/?github=pete-murphy%2Fpurescript-js-temporal%2Fmain%2Fexamples%2Fsrc%2FExamples%2FCookbook%2FNextWeeklyOccurrence.purs)
  - [Weekday of yearly occurrence](https://try.purescript.org/?github=pete-murphy%2Fpurescript-js-temporal%2Fmain%2Fexamples%2Fsrc%2FExamples%2FCookbook%2FBridgePublicHolidays.purs)
- Advanced use cases
  - [Extra-expanded years](https://try.purescript.org/?github=pete-murphy%2Fpurescript-js-temporal%2Fmain%2Fexamples%2Fsrc%2FExamples%2FCookbook%2FExtraExpandedYears.purs)
  - [Adjustable Hijri calendar](https://try.purescript.org/?github=pete-murphy%2Fpurescript-js-temporal%2Fmain%2Fexamples%2Fsrc%2FExamples%2FCookbook%2FHijriCalendar.purs)

## Locale-aware formatting with `js-intl`

Temporal types work directly with [`js-intl`](https://pursuit.purescript.org/packages/purescript-js-intl) for locale-aware formatting—useful any time you need to display a date, time, or duration to a user.

**Formatting dates and times** with `DateTimeFormat`:

```purescript
import JS.Intl.DateTimeFormat as DateTimeFormat
import JS.Intl.Locale as Locale
import JS.Temporal.PlainDate as PlainDate

do
  locale <- Locale.new_ "en-US"
  date <- PlainDate.from_ { year: 2024, month: 7, day: 1 }
  formatter <- DateTimeFormat.new [ locale ] { dateStyle: "long" }
  log (DateTimeFormat.format formatter date)
  -- "July 1, 2024"
```

**Formatting durations** with `DurationFormat`:

```purescript
import JS.Intl.DurationFormat as DurationFormat
import JS.Intl.Locale as Locale
import JS.Temporal.Duration as Duration

do
  locale <- Locale.new_ "en-US"
  duration <- Duration.from { hours: 2, minutes: 30 }
  formatter <- DurationFormat.new [ locale ] { style: "long" }
  log (DurationFormat.format formatter duration)
  -- "2 hours and 30 minutes"
```

All Temporal types that represent a point in time (`PlainDate`, `PlainTime`, `PlainDateTime`, `PlainYearMonth`, `PlainMonthDay`, `Instant`, `ZonedDateTime`) work with `DateTimeFormat`, and `Duration` works with `DurationFormat`. See the [`examples/`](./examples/) directory for more usage patterns.

## `datetime` interop

Each Temporal type has a `Compat` submodule with conversion functions to and from [`datetime`](https://pursuit.purescript.org/packages/purescript-datetime) types, so you can integrate with existing code that uses `Data.Date`, `Data.Time`, `Data.DateTime`, or `Data.DateTime.Instant`. The convention follows the parent modules: `from*` constructs the Temporal type, `to*` converts out of it.

| Module                            | Converts to/from                     |
| --------------------------------- | ------------------------------------ |
| `PlainDate.Compat.(from\|to)Date` | `Data.Date.Date`                     |
| `PlainTime.Compat.(from\|to)Time` | `Data.Time.Time`                     |
| `PlainDateTime.Compat.(from\|to)DateTime` | `Data.DateTime.DateTime`     |
| `Instant.Compat.(from\|to)Instant` | `Data.DateTime.Instant.Instant`     |
| `Duration.Compat.(from\|to)Milliseconds` | `Data.Time.Duration.Milliseconds` |
| `PlainYearMonth.Compat.(from\|to)Components` | `{ year :: Year, month :: Month }` |
| `PlainMonthDay.Compat.(from\|to)Components` | `{ month :: Month, day :: Day }` |

```purescript
import JS.Temporal.PlainDate.Compat as PlainDate.Compat

do
  plainDate <- PlainDate.Compat.fromDate date
  let date' = PlainDate.Compat.toDate plainDate
```

All conversions round-trip at the precision supported by `datetime` (milliseconds). Microsecond and nanosecond components are dropped when converting to `datetime` types.

`Duration.Compat` supports fixed-unit durations only (days, hours, minutes, seconds, milliseconds); calendar units (years, months, weeks) are not supported.

`Instant.Compat` additionally converts to and from the legacy JavaScript `Date` with `(from|to)JSDate` (via [`js-date`](https://pursuit.purescript.org/packages/purescript-js-date)).

`ZonedDateTime` has no `datetime` equivalent, so there is no `ZonedDateTime.Compat`.
