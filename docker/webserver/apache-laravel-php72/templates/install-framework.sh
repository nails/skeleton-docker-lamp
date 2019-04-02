#!/usr/bin/env bash

echo "+----------------------------+"
echo "| Install Framework: Laravel |"
echo "+----------------------------+"

# --------------------------------------------------------------------------

if ! [[ -x "$(command -v laravel)" ]]; then
    echo "... installing Laravel installer"
    composer global require "laravel/installer"
fi

echo "... installing Laravel"
laravel new www --force
