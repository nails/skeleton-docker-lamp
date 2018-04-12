#!/bin/bash
cat << EndOfMessage

Docker LAMP
===========

The following commands are available:

help             - Prints this message
build            - Executes ./www/build.sh within the context of the webserver container
watch            - Executes ./www/watch.sh within the context of the webserver container
build-containers - Builds the project containers
start            - Start all containers and build
stop             - Stop all containers
clean            - Stop, then remove, all containers
bash             - SSH into the webserver container
bash-root        - SSH into the webserver container, as root
test             - Run tests
ssl-create       - Creates a new LetsEncrypt SSL certificate
ssl-renew        - Renews a previously created LetsEncrypt SSL certificate
up               - Alias of start
down             - Alias of stop

EndOfMessage
