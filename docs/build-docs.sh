#!/bin/bash -e

if [ -z "$1" ]; then
    echo "ERROR: missing argument"
    echo ""
    echo "    Usage: build-docs.sh <build|serve>"
    exit 1
fi

# For building the docs, we require mkdocs + mkdocstrings-python
function install_mkdocs() {
    MKDOCS=$(command -v mkdocs)
    if [ -z ${MKDOCS} ]; then
        echo "-- Installing mkdocs ..."
        pip3 install --break-system-packages    \
            mkdocs                              \
            mkdocstrings-python                 \
            pymdown-extensions                  \
            mkdocs-material
        echo "-- Done"
    fi
    command -v mkdocs
}

function build_docs() {
    CURDIR=$(dirname $(readlink -f $0))
    # Set PYTHONPATH so python classes are found
    export PYTHONPATH=${CURDIR}/../:$PYTHONPATH
    python3 -m mkdocs $1
}

build_docs $1
