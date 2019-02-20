#!/bin/bash

if [ "$@" == "create" ]; then
    docker-compose exec webserver /ssl-create.sh
elif [ "$@" == "renew" ]; then
    docker-compose exec webserver certbot renew
fi
