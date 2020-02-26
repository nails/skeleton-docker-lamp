# --------------------------------------------------------------------------
# Builds the project
# - Executes ./www/scripts/build.sh within the context of the web server container
# --------------------------------------------------------------------------
build:
	@./docker/scripts/build.sh


# --------------------------------------------------------------------------
# Builds the project containers
# --------------------------------------------------------------------------
build-containers:
	@./docker/scripts/build.sh containers


# --------------------------------------------------------------------------
# Drops the database and runs a full build
# - Drops the database
# - Executes ./www/scripts/build.sh within the context of the web server container
# --------------------------------------------------------------------------
build-fresh:
	@./docker/scripts/build.sh fresh


# --------------------------------------------------------------------------
# Builds the project containers (with Xdebug)
# --------------------------------------------------------------------------
build-xdebug:
	@./docker/scripts/build.sh xdebug


# --------------------------------------------------------------------------
# Builds the project containers (with Blackfire)
# --------------------------------------------------------------------------
build-blackfire:
	@./docker/scripts/build.sh blackfire


# --------------------------------------------------------------------------
# Stop, then remove, all containers
# --------------------------------------------------------------------------
clean:
	@./docker/scripts/clean.sh


# --------------------------------------------------------------------------
# Stop all containers
# --------------------------------------------------------------------------
down:
	@./docker/scripts/down.sh


# --------------------------------------------------------------------------
# Outputs help information
# --------------------------------------------------------------------------
help:
	@./docker/scripts/help.sh


# --------------------------------------------------------------------------
# Restart all containers
# --------------------------------------------------------------------------
restart:
	@./docker/scripts/restart.sh


# --------------------------------------------------------------------------
# Seed the database
# - Executes ./www/scripts/seed.sh within the context of the web server container
# --------------------------------------------------------------------------
seed:
	@./docker/scripts/seed.sh


# --------------------------------------------------------------------------
# SSH into the web server container
# --------------------------------------------------------------------------
ssh:
	@./docker/scripts/ssh.sh


# --------------------------------------------------------------------------
# SSH into the web server container, as root
# --------------------------------------------------------------------------
ssh-root:
	@./docker/scripts/ssh.sh root


# --------------------------------------------------------------------------
# Renews a previously created LetsEncrypt SSL certificate
# --------------------------------------------------------------------------
ssl-create:
	@./docker/scripts/ssl.sh create


# --------------------------------------------------------------------------
# Renews a previously created LetsEncrypt SSL certificate
# --------------------------------------------------------------------------
ssl-renew:
	@./docker/scripts/ssl.sh renew


# --------------------------------------------------------------------------
# Run tests
# Executes ./www/test.sh within the context of the web server container
# --------------------------------------------------------------------------
test:
	@./docker/scripts/test.sh


# --------------------------------------------------------------------------
# Run tests on a fresh database
# Executes ./www/test.sh within the context of the web server container
# --------------------------------------------------------------------------
test-fresh:
	@./docker/scripts/test.sh fresh


# --------------------------------------------------------------------------
# Start all containers, install framework if necessary, configure cron, and configure SSL
# --------------------------------------------------------------------------
up:
	@./docker/scripts/up.sh


# --------------------------------------------------------------------------
# Watches the project for changes
# - Executes ./www/scripts/watch.sh within the context of the web server container
# --------------------------------------------------------------------------
watch:
	@./docker/scripts/watch.sh
