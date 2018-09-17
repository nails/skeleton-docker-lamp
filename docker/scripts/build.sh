#!/bin/bash
if [ -f ./www/scripts/build.sh ]; then
    docker-compose exec --user=1000:1000 webserver ./scripts/build.sh
fi
