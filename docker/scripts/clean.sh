#!/bin/bash

docker info > /dev/null 2>&1 || (echo 'Docker Engine is not running' && exit 1);

# --------------------------------------------------------------------------

docker-compose down --remove-orphans
