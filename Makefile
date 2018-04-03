help: # Outputs help information
	@./docker/scripts/help.sh

build: # Builds the project
	@./docker/scripts/build.sh

start: # Starts the project
	@./docker/scripts/start.sh

stop: # Stops the project
	@./docker/scripts/stop.sh

clean: # Cleans the project
	@./docker/scripts/clean.sh
