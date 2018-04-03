help: # Outputs help information
	@./docker/scripts/help.sh

build: # Builds the project
	@./docker/scripts/build.sh

up: start
start: # Starts the project
	@./docker/scripts/start.sh

down: stop
stop: # Stops the project
	@./docker/scripts/stop.sh

clean: # Cleans the project
	@./docker/scripts/clean.sh
