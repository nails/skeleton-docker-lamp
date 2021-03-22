#!/bin/bash

docker info > /dev/null 2>&1 || echo 'Docker engine is not running' && exit 1;

# --------------------------------------------------------------------------

docker-compose stop