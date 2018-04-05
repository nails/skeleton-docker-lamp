#!/bin/bash
if [ -f ./www/watch.sh ]; then
    docker-compose exec --user=1000:1000 webserver ./watch.sh
fi
