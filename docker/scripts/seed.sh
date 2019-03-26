#!/bin/bash
if [[ -f ./www/scripts/seed.sh ]]; then
    docker-compose exec --user=1000:1000 webserver ./scripts/seed.sh
fi
