#!/bin/bash
chown www-bridge-user:crontab /var/spool/cron/crontabs/www-bridge-user
chmod 600 /var/spool/cron/crontabs/www-bridge-user
service cron start
