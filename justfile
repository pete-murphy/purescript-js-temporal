# https://just.systems

@help:
    just --list

@test:
    spago test

@view-docs:
    spago docs -f html
    open generated-docs/html/index.html
