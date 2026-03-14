# js-temporal

PureScript bindings for the JavaScript [Temporal API](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Temporal).

## Installation

```bash
spago install js-temporal
```

## Documentation

Module documentation is [published on Pursuit](https://pursuit.purescript.org/packages/purescript-js-temporal).

## Examples

The [`examples/`](./examples/) directory is a separate Spago package containing PureScript translations of recipes from the [Temporal Cookbook](https://tc39.es/proposal-temporal/docs/cookbook.html). Run all examples:

```bash
nix develop
just run-examples
```

Or run a single example:

```bash
spago run -p js-temporal-examples -m Examples.Cookbook.CurrentDateTime
```

## Locale-aware formatting with js-intl

Temporal types work directly with [`purescript-js-intl`](https://pursuit.purescript.org/packages/purescript-js-intl) for locale-aware formatting — useful any time you need to display a date, time, or duration to a user.

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

## `purescript-datetime` interop

The library provides conversion functions between `purescript-js-temporal` types and [`purescript-datetime`](https://pursuit.purescript.org/packages/purescript-datetime) types, so you can integrate with existing code that uses `Data.Date`, `Data.Time`, `Data.DateTime`, or `Data.DateTime.Instant`.

| `purescript-js-temporal` | `purescript-datetime`             |
| ------------------------ | --------------------------------- |
| `PlainDate`              | `Data.Date.Date`                  |
| `PlainTime`              | `Data.Time.Time`                  |
| `PlainDateTime`          | `Data.DateTime.DateTime`          |
| `Instant`                | `Data.DateTime.Instant`           |
| `Duration`               | `Data.Time.Duration.Milliseconds` |

Each module exports `fromX` / `toX` functions for its corresponding type — for example, `PlainDate.fromDate` and `PlainDate.toDate`. All conversions round-trip at the precision supported by `purescript-datetime` (milliseconds). Microsecond and nanosecond components are dropped when converting to `purescript-datetime` types.

`Duration.fromMilliseconds` and `Duration.toMilliseconds` support fixed-unit durations only (days, hours, minutes, seconds, milliseconds); calendar units (years, months, weeks) are not supported.

`ZonedDateTime`, `PlainYearMonth`, and `PlainMonthDay` have no `purescript-datetime` equivalents.
