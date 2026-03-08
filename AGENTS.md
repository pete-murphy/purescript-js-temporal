# Agent Instructions

This project uses **bd** (beads) for issue tracking. Run `bd onboard` to get started.

## Quick Reference

```bash
bd ready              # Find available work
bd show <id>          # View issue details
bd update <id> --status in_progress  # Claim work
bd close <id>         # Complete work
bd sync               # Sync with git
```

## Landing the Plane (Session Completion)

**When ending a work session**, you MUST complete ALL steps below. Work is NOT complete until `git push` succeeds.

**MANDATORY WORKFLOW:**

1. **File issues for remaining work** - Create issues for anything that needs follow-up
2. **Run quality gates** (if code changed) - Tests, linters, builds
3. **Update issue status** - Close finished work, update in-progress items
4. **PUSH TO REMOTE** - This is MANDATORY:
   ```bash
   git pull --rebase
   bd sync
   git push
   git status  # MUST show "up to date with origin"
   ```
5. **Clean up** - Clear stashes, prune remote branches
6. **Verify** - All changes committed AND pushed
7. **Hand off** - Provide context for next session

**CRITICAL RULES:**

- Work is NOT complete until `git push` succeeds
- NEVER stop before pushing - that leaves work stranded locally
- NEVER say "ready to push when you are" - YOU must push
- If push fails, resolve and retry until it succeeds

## Development

This project uses Nix for development-related tooling, available via `nix develop`. This project uses `just` for common development tasks.

## Documentation

Documentation is written in commonmark, in PureScript comments directly above the function/value definition. All documentation in this library is expected to be on par with MDN at minimum. What that means is that:

- Prose documentation for all public API needs to match with MDN. Underscore variants (e.g., `from_`) only need to reference the non-underscored function (e.g., `from`), prose documentation does not need to be duplicated.
- Some examples have non-deterministic output (determined by current time, like `today` or `now` bindings), that is fine and expected: each time we run the doc-generation script, it's OK that we create a new timestamp
- For code documentation, we want to match any code snippets from MDN, but ported to idiomatic PureScript (some have already been translated). So _all_ code snippets that appear in the **Examples** section of the page in MDN (matching this query `$("section[aria-labelledby='examples']")`), should be ported.
- Code snippets are expected to use `Console.log` and should be accompanied by there actual output in a `text` code block.
- Code examples should use `purescript-js-intl` wherever appropriate to do localized formatting, corresponding to `toLocaleString` (or other `Intl`) usage in MDN examples. `JS.Intl.*` modules should always be imported fully qualified, to (hopefully) make it more obvious that they're from another package.
- Links are included wherever possible to MDN documentation, and if linking internally within the repo, links should use relative paths (from root of repo) to work both on GitHub and when rendered on Pursuit.
  - DON'T include file references in docs without links:
  ```
  -- | See docs/purescript-datetime-interop.md.
  ```
  do this instead:
  ```
  -- | See [./docs/purescript-datetime-interop.md](./docs/purescript-datetime-interop.md)
  ```

  - DON'T reference functions or values without code formatting (or link where possible):
  ```
  -- | Same as from with default options.
  ```
  do this instead:
  ```
  -- | Same as [`from`](#from) with default options.
  ```
- For public API functions that use `convertable-options` type class instances, we should add code examples even if there's none on MDN.

## Reference

There's a `reference` directory full of repos of packages for dev tooling (`spago`) and related libraries, etc. Currently:

```sh
❯ ls reference/
mdn                  purescript-quickcheck    spago
purescript-datetime  purescript-tidy-codegen  spec
```
