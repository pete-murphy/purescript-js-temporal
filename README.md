# js-temporal

PureScript bindings for the JavaScript [Temporal API](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Temporal).

## Installation

```bash
spago install js-temporal
```

## Documentation

Module documentation is [published on Pursuit](https://pursuit.purescript.org/packages/purescript-js-temporal).

## Examples

The `examples/` directory is a separate Spago package containing PureScript translations of recipes from the [Temporal Cookbook](https://tc39.es/proposal-temporal/docs/cookbook.html). Run all examples:

```bash
nix develop
just run-examples
```

Or run a single example:

```bash
spago run -p js-temporal-examples -m Examples.Cookbook.CurrentDateTime
```

## purescript-datetime Interop

The library provides conversion functions between js-temporal types and [purescript-datetime](https://github.com/purescript/purescript-datetime) types, so you can integrate with existing code that uses `Data.Date`, `Data.Time`, `Data.DateTime`, or `Data.DateTime.Instant`.

| js-temporal     | purescript-datetime                |
| --------------- | --------------------------------- |
| `PlainDate`     | `Data.Date.Date`                  |
| `PlainTime`     | `Data.Time.Time`                  |
| `PlainDateTime` | `Data.DateTime.DateTime`         |
| `Instant`       | `Data.DateTime.Instant`           |
| `Duration`      | `Data.Time.Duration.Milliseconds` |

Each module exports `fromX` / `toX` functions for its corresponding type — for example, `PlainDate.fromDate` and `PlainDate.toDate`. All conversions round-trip at the precision supported by purescript-datetime (milliseconds). Microsecond and nanosecond components are dropped when converting to purescript-datetime types.

`Duration.fromMilliseconds` and `Duration.toMilliseconds` support fixed-unit durations only (days, hours, minutes, seconds, milliseconds); calendar units (years, months, weeks) are not supported.

`ZonedDateTime`, `PlainYearMonth`, and `PlainMonthDay` have no purescript-datetime equivalents.
