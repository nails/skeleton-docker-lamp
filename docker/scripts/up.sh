#!/bin/bash

# Run the installer if the ./www directory is not there
if [ ! -d ./www ]; then
    mkdir -p www
    INSTALLER=$(cat docker-compose.yml | sed -n 's/ *build: "\(docker\/webserver\/.*\)"/\1/p');
    INSTALLER_PATH="$INSTALLER/templates/install-framework.sh"
    if [ -f $INSTALLER_PATH ]; then
        ./"$INSTALLER_PATH"
    fi
fi

# Bring the containers up
docker-compose up -d

# Configure and start cron
docker-compose exec webserver /cron.sh

# If there is no vendor folder then execute a build
if [ ! -d ./www/vendor ]; then
    echo ""
    echo "No vendor folder detected; building project for first time"
    echo ""
    make build
fi
