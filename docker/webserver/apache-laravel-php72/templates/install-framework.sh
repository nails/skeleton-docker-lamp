#!/usr/bin/env bash

echo "+----------------------------+"
echo "| Install Framework: Laravel |"
echo "+----------------------------+"

# --------------------------------------------------------------------------

echo "... installing Laravel installer"
composer global require "laravel/installer"

echo "... installing Laravel"
laravel new www --force
