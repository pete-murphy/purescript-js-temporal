# purescript-datetime Interop

This document describes conversion functions between [purescript-datetime](https://github.com/purescript/purescript-datetime) types and js-temporal types. Use these when integrating with code that uses the purescript-datetime library.

## Type mappings

| js-temporal   | purescript-datetime       | Conversion approach                                                                 |
| ------------- | ------------------------- | ----------------------------------------------------------------------------------- |
| **PlainDate** | **Data.Date.Date**        | year/month/day (Temporal: 1–12; datetime: Month enum via fromEnum/toEnum)            |
| **PlainTime** | **Data.Time.Time**        | hour/minute/second/millisecond (drop micro/nanosecond when converting to datetime)   |
| **PlainDateTime** | **Data.DateTime.DateTime** | Compose PlainDate/PlainTime conversions with `date`/`time` and `toPlainDate`/`toPlainTime` |
| **Instant**   | **Data.DateTime.Instant** | epochMilliseconds / fromEpochMilliseconds with `Milliseconds` (datetime uses ms; Temporal uses ns) |
| **Duration**  | **Data.Time.Duration.Milliseconds** | fixed-unit durations only (days, hours, minutes, seconds, milliseconds); calendar units not supported |

**Out of scope:** ZonedDateTime (no datetime equivalent), PlainYearMonth/PlainMonthDay (no datetime equivalent).

## API

Add these functions to the existing modules. Use qualified imports: `PlainDate.fromDate`, `PlainDate.toDate`, etc.

| Function              | Signature                                           | Module                |
| --------------------- | --------------------------------------------------- | --------------------- |
| `fromDate`            | `Data.Date.Date -> Effect PlainDate`                | `JS.Temporal.PlainDate` |
| `toDate`              | `PlainDate -> Data.Date.Date`                       | `JS.Temporal.PlainDate` |
| `fromTime`            | `Data.Time.Time -> Effect PlainTime`                | `JS.Temporal.PlainTime` |
| `toTime`              | `PlainTime -> Data.Time.Time`                       | `JS.Temporal.PlainTime` |
| `fromDateTime`        | `Data.DateTime.DateTime -> Effect PlainDateTime`    | `JS.Temporal.PlainDateTime` |
| `toDateTime`          | `PlainDateTime -> Data.DateTime.DateTime`           | `JS.Temporal.PlainDateTime` |
| `fromDateTimeInstant` | `Data.DateTime.Instant.Instant -> Effect Instant`   | `JS.Temporal.Instant` |
| `toDateTimeInstant`   | `Instant -> Data.DateTime.Instant.Instant`          | `JS.Temporal.Instant` |
| `fromMilliseconds`    | `Data.Time.Duration.Milliseconds -> Effect Duration` | `JS.Temporal.Duration` |
| `toMilliseconds`      | `Duration -> Maybe Data.Time.Duration.Milliseconds` | `JS.Temporal.Duration` |

## Round-trip properties

These properties are verified by QuickCheck property tests:

1. **PlainDate:** `date -> PlainDate.fromDate -> PlainDate.toDate -> date`
2. **PlainTime:** `time -> PlainTime.fromTime -> PlainTime.toTime -> time` (millisecond precision)
3. **PlainDateTime:** `dateTime -> PlainDateTime.fromDateTime -> PlainDateTime.toDateTime -> dateTime`
4. **Instant:** `instant -> Instant.fromDateTimeInstant -> Instant.toDateTimeInstant -> instant` (within datetime Instant range)
5. **Duration (fixed units):** `d -> Duration.toMilliseconds -> (>>=) Duration.fromMilliseconds -> Duration.toMilliseconds -> Duration.toMilliseconds d` (when d has no calendar units)

## Precision and range notes

- **PlainTime ↔ Time:** Microsecond and nanosecond components are dropped when converting to purescript-datetime `Time`; they become 0 when converting back.
- **Duration ↔ Milliseconds:** Only fixed-unit durations (days, hours, minutes, seconds, milliseconds) convert. `toMilliseconds` returns `Nothing` for calendar units (years, months, weeks). Microseconds and nanoseconds are dropped.
- **Instant:** purescript-datetime uses milliseconds since epoch; Temporal uses nanoseconds. The datetime `Instant` type is bounded (approximately ±10^13 days from epoch). Values outside that range may not round-trip.
- **Month:** Temporal uses 1–12; purescript-datetime uses `Data.Date.Component.Month` (January..December). Conversion uses `fromEnum`/`toEnum`.
