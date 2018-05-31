#!/usr/bin/env bash

echo "+------------------------------+"
echo "| Install Framework: WordPress |"
echo "+------------------------------+"

# --------------------------------------------------------------------------

echo "... installing WordPress"
curl -o ./www/wp-cli.phar -L https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x ./www/wp-cli.phar
./www/wp-cli.phar core download --path=./www
rm ./www/wp-cli.phar
