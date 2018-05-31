#!/usr/bin/env bash

echo "+----------------------------+"
echo "| Install Framework: Laravel |"
echo "+----------------------------+"

# --------------------------------------------------------------------------

echo "... installing Laravel"
composer create-project --prefer-dist laravel/laravel www
