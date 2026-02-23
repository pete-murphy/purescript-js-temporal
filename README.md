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

## Setup

```bash
nix develop   # or: spago install
spago build
spago test
```

Node.js requires the Temporal flag: `node --harmony-temporal`. The `nix develop` shell provides a wrapped Node with this flag enabled.
