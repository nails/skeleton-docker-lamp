#!/usr/bin/env bash
composer install
cd ./web/app/themes/custom-theme
yarn install
yarn build