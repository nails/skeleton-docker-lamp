#!/bin/bash

if [[ $1 == "containers" ]]; then
    docker-compose build
elif [[ $1 == "xdebug" ]]; then
    docker-compose build --build-arg PHP_XDEBUG=1
elif [[ $1 == "fresh" ]]; then
    if [[ -f ./www/scripts/build.sh ]]; then
        docker-compose exec --user=1000:1000 webserver ./scripts/build.sh fresh
    fi
else
    if [[ -f ./www/scripts/build.sh ]]; then
        docker-compose exec --user=1000:1000 webserver ./scripts/build.sh
    fi
fi
