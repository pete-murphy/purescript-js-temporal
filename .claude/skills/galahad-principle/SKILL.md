---
name: galahad-principle
description: Recognize situations where 100% completion yields disproportionate value over 99%. Apply when making decisions about completeness of migrations, test coverage, conventions, or invariants. Based on Jonathan Lange's blog post.
---

# The Galahad Principle

Situations where getting to 100% yields disproportionate value compared to anything less.

> My strength is as the strength of ten, because my heart is pure.
> -- Alfred Tennyson, *Sir Galahad*

No one ever said "my strength is as the strength of eight because my heart is pure-ish."

## Why 100% Matters

1. **Simplicity**: 100% is simple. 76% is complex. If 100% of tests pass and one fails, you know exactly what to do. If many are already failing, a new failure is noise.

2. **Trust**: If 100% of X lives in one place, absence of evidence becomes evidence of absence. You only need to look in one place. Partial coverage means you can never be sure.

## Where This Applies

- **Migrations**: A library migration at 95% still requires maintaining two code paths. At 100%, delete the old one.
- **Test coverage**: At 100%, coverage reports point you to bugs. Below that, they're just guilt.
- **Conventions**: If every module follows the pattern, you can trust the pattern. One exception breaks the trust.
- **Invariants**: A guarantee that holds "most of the time" is not a guarantee.

## Practical Implication

When you're at 95%, the remaining 5% is not diminishing returns -- it's where the actual value lives. Push to 100% when the property is about trust or simplicity.
