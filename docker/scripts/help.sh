#!/bin/bash
cat << EndOfMessage

Docker LAMP
===========

The following commands are available:

help             - Prints this message
build            - Executes ./www/build.sh within the context of the webserver container
build-containers - Builds the project containers
start            - Start all containers and build
stop             - Stop all containers
clean            - Stop, then remove, all containers
bash             - SSH into the webserver container
bash-root        - SSH into the webserver container, as root
test             - Run tests
up               - Alias of start
down             - Alias of stop

EndOfMessage
