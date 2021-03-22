#!/bin/bash
if [[ -f ./www/scripts/seed.sh ]]; then

    docker info > /dev/null 2>&1 || echo 'Docker engine is not running' && exit 1;

    # --------------------------------------------------------------------------

    docker-compose exec --user=1000:1000 webserver ./scripts/seed.sh
fi
