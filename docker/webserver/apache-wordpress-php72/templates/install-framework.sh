#!/usr/bin/env bash

echo "+------------------------------+"
echo "| Install Framework: WordPress |"
echo "+------------------------------+"

# --------------------------------------------------------------------------

echo "... installing WordPress"
composer create-project roots/bedrock www/

# --------------------------------------------------------------------------

echo "... setting up base theme"
curl -X POST \
  https://underscores.me/ \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -d 'underscoresme_generate=1&underscoresme_sass=1&underscoresme_name=custom-theme' \
  -o ./www/web/app/themes/custom-theme.zip
unzip -q -d ./www/web/app/themes/ ./www/web/app/themes/custom-theme.zip
rm -f ./www/web/app/themes/custom-theme.zip

# --------------------------------------------------------------------------

echo "... Generating configs"
AUTH_KEY=`openssl rand -base64 64 | tr -d '\n'`
SECURE_AUTH_KEY=`openssl rand -base64 64 | tr -d '\n'`
LOGGED_IN_KEY=`openssl rand -base64 64 | tr -d '\n'`
NONCE_KEY=`openssl rand -base64 64 | tr -d '\n'`
AUTH_SALT=`openssl rand -base64 64 | tr -d '\n'`
SECURE_AUTH_SALT=`openssl rand -base64 64 | tr -d '\n'`
LOGGED_IN_SALT=`openssl rand -base64 64 | tr -d '\n'`
NONCE_SALT=`openssl rand -base64 64 | tr -d '\n'`

echo "# WP Configs" > ./www/.env
echo 'DB_HOST=${DB_HOST}' >> ./www/.env
echo 'DB_NAME=${DB_DATABASE}' >> ./www/.env
echo 'DB_USER=${DB_USERNAME}' >> ./www/.env
echo 'DB_PASSWORD=${DB_PASSWORD}' >> ./www/.env
echo 'WP_ENV=${ENVIRONMENT}' >> ./www/.env
echo 'WP_HOME=http://${DOMAIN}' >> ./www/.env
echo 'WP_SITEURL=${WP_HOME}/wp' >> ./www/.env
echo "AUTH_KEY='${AUTH_KEY}'" >> ./www/.env
echo "SECURE_AUTH_KEY='${SECURE_AUTH_KEY}'" >> ./www/.env
echo "LOGGED_IN_KEY='${LOGGED_IN_KEY}'" >> ./www/.env
echo "NONCE_KEY='${NONCE_KEY}'" >> ./www/.env
echo "AUTH_SALT='${AUTH_SALT}'" >> ./www/.env
echo "SECURE_AUTH_SALT='${SECURE_AUTH_SALT}'" >> ./www/.env
echo "LOGGED_IN_SALT='${LOGGED_IN_SALT}'" >> ./www/.env
echo "NONCE_SALT='${NONCE_SALT}'" >> ./www/.env

# --------------------------------------------------------------------------

echo "... Generating build and watch scripts"
mkdir -p ./www/scripts
cp ./docker/webserver/apache-wordpress-php72/templates/scripts/build.sh ./www/scripts/build.sh
cp ./docker/webserver/apache-wordpress-php72/templates/scripts/watch.sh ./www/scripts/watch.sh
cp ./docker/webserver/apache-wordpress-php72/templates/theme/package.json ./www/web/app/themes/custom-theme/package.json
cp ./docker/webserver/apache-wordpress-php72/templates/theme/webpack.config.js ./www/web/app/themes/custom-theme/webpack.config.js
cp ./docker/webserver/apache-wordpress-php72/templates/theme/theme.js ./www/web/app/themes/custom-theme/js/theme.js
chmod +x ./www/scripts/build.sh
chmod +x ./www/scripts/watch.sh

# Inject the custom JS into the theme
# Is this an ugly hack? ¯\_(ツ)_/¯
echo "" >> ./www/web/app/themes/custom-theme/functions.php
echo "function custom_theme_scripts_2() {" >> ./www/web/app/themes/custom-theme/functions.php
echo "    wp_enqueue_script('custom-theme-js', get_template_directory_uri() . '/js/theme.min.js');" >> ./www/web/app/themes/custom-theme/functions.php
echo "}" >> ./www/web/app/themes/custom-theme/functions.php
echo "add_action('wp_enqueue_scripts', 'custom_theme_scripts_2');" >> ./www/web/app/themes/custom-theme/functions.php
echo "" >> ./www/web/app/themes/custom-theme/functions.php

# --------------------------------------------------------------------------

# Copy the welcome file
rm -f ./www/web/index.php
cp ./docker/webserver/apache-wordpress-php72/templates/index.php ./www/web/index.php
