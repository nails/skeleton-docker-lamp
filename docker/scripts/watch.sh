#!/bin/bash
if [[ -f ./www/scripts/watch.sh ]]; then

    docker info > /dev/null 2>&1 || (echo 'Docker Engine is not running' && exit 1);

    # --------------------------------------------------------------------------

    docker-compose exec --user=1000:1000 webserver ./scripts/watch.sh
fi
