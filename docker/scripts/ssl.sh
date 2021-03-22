#!/bin/bash

docker info > /dev/null 2>&1 || (echo 'Docker Engine is not running' && exit 1);

# --------------------------------------------------------------------------

if [[ $1 == "create" ]]; then
    docker-compose exec webserver /ssl-create.sh
elif [[ $1 == "renew" ]]; then
    docker-compose exec webserver /ssl-renew.sh
fi
