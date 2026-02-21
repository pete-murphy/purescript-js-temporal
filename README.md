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

## Setup

```bash
nix develop   # or: spago install
spago build
spago test
```

Node.js requires the Temporal flag: `node --harmony-temporal`.
