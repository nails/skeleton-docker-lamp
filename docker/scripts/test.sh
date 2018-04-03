#!/bin/bash
if [ -f ./www/phpunit.xml ]; then
    docker-compose exec --user=1000:1000 webserver phpunit
fi
