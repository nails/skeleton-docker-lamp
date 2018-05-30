#!/usr/bin/env bash

echo "+----------------------------+"
echo "| Install Framework: Laravel |"
echo "+----------------------------+"

# --------------------------------------------------------------------------

echo "... installing Laravel"
cd www && composer create-project --prefer-dist laravel/laravel .
