#!/bin/bash

if [ "$@" == "containers" ]; then
    docker-compose build
elif [ "$@" == "fresh" ]; then
    if [ -f ./www/scripts/build.sh ]; then
        docker-compose exec --user=1000:1000 webserver ./scripts/build.sh fresh
    fi
else
    if [ -f ./www/scripts/build.sh ]; then
        docker-compose exec --user=1000:1000 webserver ./scripts/build.sh
    fi
fi
