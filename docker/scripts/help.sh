#!/bin/bash
cat << EndOfMessage

Docker LAMP
===========

The following commands are available:

build            - Executes ./www/build.sh within the context of the web server container
build-containers - Builds the project containers
build-fresh      - Executes ./www/build.sh within the context of the web server container, passing "fresh" as an arg
build-xdebug     - Builds the project containers, installing and enabling Xdebug
clean            - Stop, then remove, all containers
down             - Stop all containers
help             - Prints this message
restart          - Restart all containers
seed             - Executes ./www/seed.sh within the context of the web server container
ssh              - SSH into the web server container
ssh-root         - SSH into the web server container, as root
ssl-create       - Creates a new LetsEncrypt SSL certificate
ssl-renew        - Renews a previously created LetsEncrypt SSL certificate
test             - Executes ./www/test.sh within the context of the web server container
test-fresh       - Executes ./www/test.sh within the context of the web server container, passing "fresh" as an arg
up               - Start all containers, install framework if necessary, configure cron, and configure SSL
watch            - Executes ./www/watch.sh within the context of the web server container

EndOfMessage
