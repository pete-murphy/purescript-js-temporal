#!/usr/bin/env bash
# Fetch reference material for the Temporal API.
# Run from the project root. Creates reference/spec and reference/mdn.

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REFERENCE="${ROOT}/reference"

mkdir -p "$REFERENCE"
cd "$REFERENCE"

echo "Fetching Temporal spec (tc39/proposal-temporal)..."
if [[ -d spec ]]; then
  (cd spec && git pull --rebase)
else
  git clone --depth 1 https://github.com/tc39/proposal-temporal spec
fi

echo "Fetching MDN Temporal docs (mdn/content, sparse checkout)..."
if [[ -d mdn ]]; then
  (cd mdn && git pull --rebase)
else
  git clone --depth 1 --filter=blob:none --sparse https://github.com/mdn/content mdn
  (cd mdn && git sparse-checkout set files/en-us/web/javascript/reference/global_objects/temporal)
fi

echo "Done. Reference material is in reference/spec and reference/mdn"
