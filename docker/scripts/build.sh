#!/bin/bash

if [[ $1 == "containers" ]]; then
    docker-compose pull && \
    docker-compose build
elif [[ $1 == "xdebug" ]]; then
    docker-compose pull && \
    docker-compose build --build-arg PHP_XDEBUG=1
elif [[ $1 == "blackfire" ]]; then

    echo "Blackfire Client ID:"
    read PHP_BLACKFIRE_CLIENT_ID

    echo "Blackfire Client Token:"
    read PHP_BLACKFIRE_CLIENT_TOKEN

    echo "Blackfire Server ID:"
    read PHP_BLACKFIRE_SERVER_ID

    echo "Blackfire Server Token:"
    read PHP_BLACKFIRE_SERVER_TOKEN

    docker-compose pull && \
    docker-compose build \
      --build-arg PHP_BLACKFIRE=1 \
      --build-arg PHP_BLACKFIRE_CLIENT_ID=$PHP_BLACKFIRE_CLIENT_ID \
      --build-arg PHP_BLACKFIRE_CLIENT_TOKEN=$PHP_BLACKFIRE_CLIENT_TOKEN \
      --build-arg PHP_BLACKFIRE_SERVER_ID=$PHP_BLACKFIRE_SERVER_ID \
      --build-arg PHP_BLACKFIRE_SERVER_TOKEN=$PHP_BLACKFIRE_SERVER_TOKEN \

elif [[ $1 == "fresh" ]]; then
    if [[ -f ./www/scripts/build.sh ]]; then
        docker-compose exec --user=1000:1000 webserver ./scripts/build.sh fresh
    fi
else
    if [[ -f ./www/scripts/build.sh ]]; then
        docker-compose exec --user=1000:1000 webserver ./scripts/build.sh
    fi
fi
