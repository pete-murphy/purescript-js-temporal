# https://just.systems

@help:
    just --list

@test:
    spago test

# Run Temporal Cookbook examples (requires node with Temporal: use `nix develop`)
run-examples:
    spago run -m Examples.Main

@view-docs:
    spago docs -f html
    open generated-docs/html/index.html
