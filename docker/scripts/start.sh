#!/bin/bash
docker-compose up -d
# Configure and start cron
docker-compose exec webserver /cron.sh
