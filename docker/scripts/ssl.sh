#!/bin/bash

if [[ $1 == "create" ]]; then
    docker-compose exec webserver /ssl-create.sh
elif [[ $1 == "renew" ]]; then
    docker-compose exec webserver certbot renew
fi
