#!/bin/bash
if [[ -f ./www/scripts/watch.sh ]]; then
    docker-compose exec --user=1000:1000 webserver ./scripts/watch.sh
fi
