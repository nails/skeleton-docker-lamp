#!/bin/bash
if [[ -f ./www/scripts/test.sh ]]; then
    docker-compose exec --user=1000:1000 webserver ./scripts/test.sh ${1}
fi
