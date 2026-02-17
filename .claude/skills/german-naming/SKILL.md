---
name: german-naming-convention
description: Enforces descriptive, unabbreviated naming for variables, functions, types, and modules. Use when writing or reviewing code to ensure names are readable plain English, not abbreviated or cryptic. Based on Chris Done's German Naming Convention.
---

# German Naming Convention

Use as many words as necessary to clearly name something. Never abbreviate.

## Rules

1. **No abbreviations**: Write `openFile` not `fopen`, `throwValidationError` not `throwVE`, `function` not `fct`, `definition` not `dfn`, `context` not `ctx`
2. **No single-letter names** (except in truly generic/polymorphic contexts like `identity x = x`)
3. **No acronyms as names**: Write `throwValidationError` not `throwVE`
4. **No Hungarian notation**: No prefix/suffix sigils encoding type information in the name

## Isomorphic Naming

Name variables after their types. If the type is `QualifiedTable`, the variable is `qualifiedTable`.

Bad:
```purescript
updateColExp :: QualifiedTable -> RenameField -> ColExp -> Effect ColExp
updateColExp qt rf (ColExp fld val) = ...
```

Good:
```purescript
updateColumnExpression :: QualifiedTable -> RenameField -> ColumnExpression -> Effect ColumnExpression
updateColumnExpression qualifiedTable renameField (ColumnExpression field value) = ...
```

## When Single Letters Are Acceptable

Only when the value is truly generic/polymorphic and no meaningful English noun exists:

```purescript
identity :: forall a. a -> a
identity x = x
```
