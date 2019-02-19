#!/bin/bash
chown www-bridge-user:crontab /var/spool/cron/crontabs/www-bridge-user
chmod 600 /var/spool/cron/crontabs/www-bridge-user
chown root:crontab /var/spool/cron/crontabs/root
chmod 600 /var/spool/cron/crontabs/root
# Writing container vars so that crond picks them up
# This feels a little dirty, so opinions welcome
env >> /etc/environment
service cron start
