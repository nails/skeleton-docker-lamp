#!/usr/bin/env bash
# @todo - check if already installed

echo "+----------------------------+"
echo "| Install Framework: Laravel |"
echo "+----------------------------+"

# --------------------------------------------------------------------------

echo "... emptying working directory"
rm -rf /var/www/html/*
rm -rf /var/www/html/.[a-z]*

echo "... installing Laravel"
su - www-bridge-user -c "cd /var/www/html && composer create-project --prefer-dist laravel/laravel ."
