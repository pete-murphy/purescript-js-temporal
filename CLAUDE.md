# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

PureScript bindings for the JavaScript Temporal API. Uses the `purs-backend-es` compiler backend to target JavaScript ES modules.

## Development Environment

This project uses Nix flakes for a reproducible dev environment. Enter the shell with:

```
nix develop
```

This provides: `purs`, `spago`, `purs-tidy`, `purs-backend-es`, `nodejs`, `just`, and `alejandra`.

## Common Commands

- **Install dependencies:** `spago install` (or `run-install`)
- **Run tests:** `spago test` (or `run-test`)
- **Build:** `spago build`
- **Check formatting:** `purs-tidy check src test` (or `run-check-format`)
- **Format code:** `purs-tidy format-in-place src test`
- **REPL:** `spago repl`

## Architecture

- `src/` — Library source modules
- `test/Test/` — Test modules (entry point: `Test.Main`)
- `spago.yaml` — Package config and dependencies (registry 73.1.0)
- `flake.nix` — Nix dev environment with helper scripts

## Conventions

- PureScript source uses `purs-tidy` formatting
- Nix files use `alejandra` formatting
- All side effects must be in the `Effect` monad
- JavaScript FFI files use `.js` extension alongside their `.purs` counterparts
