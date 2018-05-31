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
clean            - Stop, then remove, all containers
bash             - SSH into the web server container
bash-root        - SSH into the web server container, as root
test             - Run tests
ssl-create       - Creates a new LetsEncrypt SSL certificate
ssl-renew        - Renews a previously created LetsEncrypt SSL certificate

EndOfMessage
