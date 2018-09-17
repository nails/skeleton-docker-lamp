#!/bin/bash
if [ -f ./www/test.sh ]; then
    docker-compose exec --user=1000:1000 webserver ./test.sh
fi
