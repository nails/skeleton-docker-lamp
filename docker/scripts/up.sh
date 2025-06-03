#!/bin/bash

docker info > /dev/null 2>&1 || (echo 'Docker Engine is not running' && exit 1);

# --------------------------------------------------------------------------

# Bring the containers up
docker-compose up -d || exit 1

# --------------------------------------------------------------------------

# Run the installer if the ./www directory is not there
if [[ -z "$(ls -A ./www)" ]]; then
    echo "Installing framework"
    docker-compose exec --user=1000:1000 webserver bash -c "/install-framework.sh" || exit 1
fi

# --------------------------------------------------------------------------

# Configure and start cron
echo "Installing crontabs"

# Dump the env vars so we can use it in cron
docker-compose exec --user=1000:1000 webserver bash -c "printenv > ~/env.sh" || exit 1
# Ensure they are prefixed with `export`
docker-compose exec --user=1000:1000 webserver bash -c "sed -iE 's/^\(.*\)=\(.*\)$/export \1=\"\2\"/g' ~/env.sh" || exit 1
# Escape nested quotes - replace all quotes with \"
docker-compose exec --user=1000:1000 webserver bash -c "sed -iE 's/\"/\\\\\"/g' ~/env.sh" || exit 1
# Unescape the surrounding VAR="" quotes
# NotE: For some reason the `-i` flag doesn't work with this regex so piping and redirecting
docker-compose exec --user=1000:1000 webserver bash -c "cat ~/env.sh | sed -E 's/^(.+)=\\\\\"(.*)\\\\\"/\1=\"\2\"/g' > ~/env.tmp && mv ~/env.tmp ~/env.sh" || exit 1

# Repeat for root
docker-compose exec webserver bash -c "printenv > ~/env.sh" || exit 1
docker-compose exec webserver bash -c "sed -iE 's/^\(.*\)=\(.*\)$/export \1=\"\2\"/g' ~/env.sh" || exit 1
docker-compose exec webserver bash -c "sed -iE 's/\"/\\\\\"/g' ~/env.sh" || exit 1
docker-compose exec webserver bash -c "cat ~/env.sh | sed -E 's/^(.+)=\\\\\"(.*)\\\\\"/\1=\"\2\"/g' > ~/env.tmp && mv ~/env.tmp ~/env.sh" || exit 1

# Install the crontabs
docker-compose exec --user=1000:1000 webserver bash -c "cat ~/crontab | crontab -" || exit 1
docker-compose exec webserver bash -c "cat ~/crontab | crontab -" || exit 1

# Restart cron
docker-compose exec webserver bash -c "service cron restart" || exit  1

# Restart Blackfire (if installed)
docker-compose exec webserver bash -c 'if [[ $(which blackfire) != "" ]]; then mkdir -p /var/log/blackfire && touch /var/log/blackfire/agent.log && /etc/init.d/blackfire-agent restart; fi' || exit 1

# --------------------------------------------------------------------------

# Set the Apache envvars
docker-compose exec webserver bash -c 'echo "export DOMAIN=\"${DOMAIN}\"" >> /env-apache.sh' || exit 1
docker-compose exec webserver bash -c 'echo "export PAGESPEED_ENABLE=\"${PAGESPEED_ENABLE}\"" >> /env-apache.sh' || exit 1

# --------------------------------------------------------------------------

# Install SSL certificate
make ssl-create || exit 1

# --------------------------------------------------------------------------

# If there is no vendor folder then execute a build
if [[ ! -d ./www/vendor ]]; then
    echo ""
    echo "No vendor folder detected; building project for first time"
    echo ""
    make build
fi
