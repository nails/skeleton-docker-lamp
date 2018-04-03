#!/bin/bash
if [ -f ./www/build.sh ]; then
    docker-compose exec --user=1000:1000 webserver ./build.sh
fi
