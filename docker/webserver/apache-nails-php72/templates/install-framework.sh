#!/usr/bin/env bash

echo "+--------------------------+"
echo "| Install Framework: Nails |"
echo "+--------------------------+"

# --------------------------------------------------------------------------

if ! [[ -x "$(command -v nails)" ]]; then
    echo "... installing Nails Command Line Tool"
    composer global require "nails/command-line-tool"
fi

echo "... installing Nails"
nails new:project --dir="www" --no-docker
