#!/bin/bash
cat << EndOfMessage

Docker LAMP
===========

The following commands are available:

help             - Prints this message
build            - Executes ./www/build.sh within the context of the web server container
watch            - Executes ./www/watch.sh within the context of the web server container
build-containers - Builds the project containers
up               - Start all containers, install framework if necessary, and start cron
down             - Stop all containers
restart          - Restart all containers
seed             - Executes ./www/seed.sh within the context of the web server container
clean            - Stop, then remove, all containers
ssh              - SSH into the web server container
ssh-root         - SSH into the web server container, as root
test             - Run tests
test-fresh       - Run tests using a freshly migrated database
ssl-create       - Creates a new LetsEncrypt SSL certificate
ssl-renew        - Renews a previously created LetsEncrypt SSL certificate

EndOfMessage
