#!/bin/bash

docker info > /dev/null 2>&1 || (echo 'Docker Engine is not running' && exit 1);

# --------------------------------------------------------------------------

if [[ $1 == "root" ]]; then
    docker-compose exec webserver bash
else
    docker-compose exec --user=1000:1000 webserver bash
fi
