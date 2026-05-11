# Rename Tool — TODO

## Done

- [x] Core `renamePurs`: CST-based simultaneous rename of identifiers, strings, comments
- [x] Core `renameJs`: simultaneous text-based rename for JS FFI files
- [x] `Main.purs` CLI with config file parsing and `--dry-run`
- [x] Unit tests (19 cases): identifier, swap, string, comment, qualified,
      export list, foreign import, no false positives, doc comment, type
      signature, multiple renames, JS FFI, derived names, string swap, trailing
      comments, realistic purs/js snippets, word boundary, internal names
- [x] Property-based tests (QuickCheck):
  - `renamePurs [] input == input` (identity)
  - Idempotent for non-chaining renames
  - Roundtrip: result re-parses to same output
- [x] Codebase invariant checks (run with `--check-invariants`):
  - EXAMPLE block ↔ declaration name consistency
  - `runExample` label ↔ function reference consistency
  - No underscored exports in `src/JS/Temporal/`

## Known violations found by invariant checks (47 total)

- **1 EXAMPLE/decl mismatch**: `Duration.purs` has tag `toStringWithOptions` but
  function is still `exampleToString` (from incomplete recent commit)
- **1 runExample mismatch**: same Duration issue in `Main.purs`
- **45 underscored exports**: all the `_` functions awaiting rename

## Future work

- [ ] **Property: rename entry order independence** — result should be the same
      regardless of order in the rename array (longest-first matching handles this)
- [ ] **Doc comment anchor consistency** (property 6) — verify `(#anchor)` is
      lowercase of the function name in "Same as" comments
- [ ] **Foreign import ↔ JS FFI consistency** (property 5) — cross-reference
      `foreign import _foo` with `export function _foo` / `export const _foo`
- [ ] **Test label consistency** (property 7) — verify `Console.log "Mod.func"`
      labels in `test/Test/Main.purs` match actual function names
- [ ] **Build the actual rename config** for the full codebase refactor and
      run the tool
