# A Nails friendly LAMP environment using Docker

A _slightly_ opinionated, but **really easy to use** Docker LAMP stack.



## Features

  - A LAMP environment running:
    - Apache 2.4
    - PHP 7.2
    - MySQL 5.6
    - Composer
    - NodeJS
  - [Mailhog](https://github.com/mailhog/MailHog) installed for working with emails locally
  - [Nails Command Line Tool](https://github.com/nailsapp/command-line-tool)



## How to use

This repository is, more or less, just a wrapper for `docker-compose`; to make life a little easier we use a `Makefile` to wrap up some of the common commands.

Day-to-day, you'll likely use `make start` and `make stop` when working with this stack, but the following are available:

- `make build`            - Executes ./www/build.sh within the context of the webserver container
- `make build-containers` - Builds the project containers
- `make start`            - Start all containers and build
- `make stop`             - Stop all containers
- `make clean`            - Stop, then remove, all containers
- `make bash`             - SSH into the webserver container
- `make bash-root`        - SSH into the webserver container, as root
- `make test`             - Run tests
- `make up`               - Alias of start
- `make down`             - Alias of stop

Feel free to add your own, as per your project's needs.

## Database

- Host:     `db`
- Username: `root`
- Password: `docker`
- Port:     `3306`
- Database: `dev`



## Email

- Host:     `mail`
- Username: `<blank>`
- Password: `<blank>`
- Port:     `1025`
- GUI:      `http://localhost:8025`
