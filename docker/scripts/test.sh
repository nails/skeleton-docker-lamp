#!/bin/bash
if [[ -f ./www/scripts/test.sh ]]; then

    docker info > /dev/null 2>&1 || (echo 'Docker Engine is not running' && exit 1);

    # --------------------------------------------------------------------------

    docker-compose exec --user=1000:1000 webserver ./scripts/test.sh ${1}
fi
