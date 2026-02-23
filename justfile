# https://just.systems

@help:
    just --list

@generate-options:
    cd script/generate-options && spago run ../../

@test:
    spago test

# Run Temporal Cookbook examples (requires node with Temporal: use `nix develop`)
run-examples:
    spago run -p js-temporal-examples

@view-docs:
    spago docs -f html
    open generated-docs/html/index.html

# Fetch or update the Temporal spec from tc39/proposal-temporal
fetch-spec:
    mkdir -p reference
    @if [ -d reference/spec ]; then \
        echo "Updating Temporal spec..."; \
        cd reference/spec && git pull --rebase; \
    else \
        echo "Cloning Temporal spec..."; \
        git clone --depth 1 https://github.com/tc39/proposal-temporal reference/spec; \
    fi

# Fetch or update MDN Temporal docs (sparse checkout)
fetch-mdn:
    mkdir -p reference
    @if [ -d reference/mdn ]; then \
        echo "Updating MDN Temporal docs..."; \
        cd reference/mdn && git pull --rebase; \
    else \
        echo "Cloning MDN Temporal docs (sparse)..."; \
        git clone --depth 1 --filter=blob:none --sparse https://github.com/mdn/content reference/mdn; \
        cd reference/mdn && git sparse-checkout set files/en-us/web/javascript/reference/global_objects/temporal; \
    fi

# Fetch all reference material (spec + MDN)
fetch-reference: fetch-spec fetch-mdn
