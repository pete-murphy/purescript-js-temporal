# Notes: Duration interop overflow fixes

## Problem

Duration add interop and round-trip tests were failing. Examples:
- Add interop: Temporal result (June 25) differed from datetime result (May 6) for the same addition
- Round-trip: `toMilliseconds -> fromMilliseconds -> toMilliseconds` produced different values

## Cause

PureScript `Int` is 32-bit signed. Expressions like `days * millisecondsPerDay` overflow when `days >= 25`, since `25 * 86_400_000 = 2_160_000_000` exceeds `2^31 - 1`. Overflow produced negative or wrong values, corrupting duration arithmetic and decomposition.

## Changes

- **test/Test/Main.purs**: Compute `totalMs` using `Number` arithmetic (`Int.toNumber` on each component before multiply/add). Use `Milliseconds totalMs` directly in `adjust`.

- **src/JS/Temporal/Duration.purs**:
  - **toMilliseconds**: Same fix — convert components to `Number` before multiplication to avoid overflow.
  - **decomposeMilliseconds**: Use `Number` for intermediate products (e.g. `Int.toNumber daysVal * msPerDay` instead of `daysVal * millisecondsPerDay`). Previously, `daysVal * millisecondsPerDay` overflowed when decomposing ~25+ days.

- **README.md**: Add Duration to purescript-datetime interop table with `Data.Time.Duration.Milliseconds`. Note that only fixed-unit durations are supported (no years, months, weeks).
