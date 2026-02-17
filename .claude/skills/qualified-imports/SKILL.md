---
name: design-for-qualified-import
description: Design modules so they work well with qualified imports. Leave namespacing to the module system instead of encoding it in identifier names with prefixes or suffixes. Use when creating or organizing modules. Based on Johan Tibell's Haskell-cafe post.
---

# Design Modules for Qualified Import

Leave namespacing to the module system. Don't bake namespace prefixes/suffixes into identifier names.

## Core Rule

Name functions as if they will always be used qualified. Write `fold` in a module imported as `Array`, so usage reads `Array.fold` -- not `foldArray` or `arrayFold`.

## Why

1. **Redundancy**: If imported qualified, prefixes waste space (`Array.foldArray` is redundant)
2. **Robustness**: Qualified imports protect against name clashes when upstream modules add new exports
3. **Traceability**: The module qualifier tells you exactly where an identifier comes from

## In Practice (PureScript)

```purescript
-- Good: qualified import, clean names
import Data.Array as Array

result = Array.fold ...

-- Bad: unqualified with prefixed names
import Data.Array (foldArray)

result = foldArray ...
```

## Exceptions

- Infix operators look ugly qualified; import them explicitly and unqualified
- Very frequently used combinators (e.g. parser combinators in a parsing module) may be imported unqualified with explicit import lists
