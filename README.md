# js-temporal

PureScript bindings for the JavaScript [Temporal API](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Temporal).

## Installation

```bash
spago install js-temporal
```

## Documentation

Generate HTML documentation with:

```bash
spago docs -f html
```

Output is written to `generated-docs/html/index.html`. Open in a browser to browse the API.

When contributing documentation, reference material can be fetched with:

```bash
./scripts/fetch-reference.sh
```

This populates `reference/spec` (tc39 Temporal spec) and `reference/mdn` (MDN Temporal docs).

## Examples

The `src/Examples/` directory contains PureScript translations of recipes from the [Temporal Cookbook](https://tc39.es/proposal-temporal/docs/cookbook.html). Run all examples:

```bash
nix develop
just run-examples
```

Or run a single example:

```bash
spago run -m Examples.Cookbook.CurrentDateTime
```

## Setup

```bash
nix develop   # or: spago install
spago build
spago test
```

Node.js requires the Temporal flag: `node --harmony-temporal`. The `nix develop` shell provides a wrapped Node with this flag enabled.
