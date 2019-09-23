#!/bin/bash

# Run the installer if the ./www directory is not there
if [[ ! -d ./www ]]; then
    mkdir -p www
    INSTALLER=$(cat docker-compose.yml | sed -n 's/ *build: "\(docker\/webserver\/.*\)"/\1/p');
    INSTALLER_PATH="$INSTALLER/templates/install-framework.sh"
    if [[ -f $INSTALLER_PATH ]]; then
        ./"$INSTALLER_PATH"
    fi
fi

# --------------------------------------------------------------------------

# Bring the containers up
docker-compose up -d

# --------------------------------------------------------------------------

# Start rsylog
docker-compose exec webserver bash -c "service rsyslog restart"

# --------------------------------------------------------------------------

# Configure and start cron
echo "Installing crontabs"

# Dump the env vars so we can use it in cron
docker-compose exec --user=1000:1000 webserver bash -c "printenv > ~/env.sh"
# Ensure they are prefixed with `export`
docker-compose exec --user=1000:1000 webserver bash -c "sed -iE 's/^\(.*\)=\(.*\)$/export \1=\"\2\"/g' ~/env.sh"
# Escape nested quotes - replace all quotes with \"
docker-compose exec --user=1000:1000 webserver bash -c "sed -iE 's/\"/\\\\\"/g' ~/env.sh"
# Unescape the surrounding VAR="" quotes
# NotE: For some reason the `-i` flag doesn't work with this regex so piping and redirecting
docker-compose exec --user=1000:1000 webserver bash -c "cat ~/env.sh | sed -E 's/^(.+)=\\\\\"(.*)\\\\\"/\1=\"\2\"/g' > ~/env.tmp && mv ~/env.tmp ~/env.sh"

# Repeat for root
docker-compose exec webserver bash -c "printenv > ~/env.sh"
docker-compose exec webserver bash -c "sed -iE 's/^\(.*\)=\(.*\)$/export \1=\"\2\"/g' ~/env.sh"
docker-compose exec webserver bash -c "sed -iE 's/\"/\\\\\"/g' ~/env.sh"
docker-compose exec webserver bash -c "cat ~/env.sh | sed -E 's/^(.+)=\\\\\"(.*)\\\\\"/\1=\"\2\"/g' > ~/env.tmp && mv ~/env.tmp ~/env.sh"

# Install the crontabs
docker-compose exec --user=1000:1000 webserver bash -c "cat ~/crontab | crontab -"
docker-compose exec webserver bash -c "cat ~/crontab | crontab -"

# Restart cron
docker-compose exec webserver bash -c "service cron restart"

# --------------------------------------------------------------------------

# Install SSL certificate
make ssl-create

# --------------------------------------------------------------------------

# If there is no vendor folder then execute a build
if [[ ! -d ./www/vendor ]]; then
    echo ""
    echo "No vendor folder detected; building project for first time"
    echo ""
    make build
fi
