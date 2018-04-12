# A Nails friendly LAMP environment using Docker

A _slightly_ opinionated, but **really easy to use** Docker LAMP stack.



## Features

  - A LAMP environment running:
    - Apache 2.4
    - PHP 7.2 or 5.6
    - MySQL 5.6
    - Composer
    - NodeJS
    - Certbot (for SSL certificates)
  - [Mailhog](https://github.com/mailhog/MailHog) installed for working with emails locally
  - [Nails Command Line Tool](https://github.com/nailsapp/command-line-tool)



## How to use

This repository is, more or less, just a wrapper for `docker-compose`; to make life a little easier we use a `Makefile` to wrap up some of the common commands.

Day-to-day, you'll likely use `make start` and `make stop` when working with this stack, but the following are available:


Command                  | Value
------------------------ | -----------------------------------------------------------------------
`make build`             | Executes `./www/build.sh` within the context of the webserver container
`make watch`             | Executes `./www/watch.sh` within the context of the webserver container
`make build-containers`  | Builds the project containers
`make start`             | Start all containers and build
`make stop`              | Stop all containers
`make clean`             | Stop, then remove, all containers
`make bash`              | SSH into the webserver container
`make bash-root`         | SSH into the webserver container, as root
`make test`              | Run tests
`ssl-create`             | Creates a new LetsEncrypt SSL certificate
`ssl-renew`              | Renews a previously created LetsEncrypt SSL certificate
`make up`                | Alias of start
`make down`              | Alias of stop

Feel free to add your own, as per your project's needs.

## Webserver

The webserver container has all you need enabled for development; you can specify custom configurations using the `./docker/webserver/templates/*` files.

In addition, the following directories are of interest:

- The webroot is available at `./www`
- Webserver logs are available at `./docker/webserver/logs`
- LetsEncrypt configurations are available at `./docker/webserver/letsencrypt`


## SSL

The webserver is equipped with a self-signed SSL certificate by default, so you can test secure connections on `localhost`. `certbot` is also available for generating, and renewing, valid certificates via LetsEncrypt.



## Database

Connect to the database using the following credentials:

Property      | Value
------------- | -------------
Host:         | `db`
Username:     | `root`
Password:     | `docker`
Port:         | `3306`
Database:     | `dev`

All database files are stored in `./docker/db/data` so that your data will survive containers being removed.


## Email

Property      | Value
------------- | -------------
Host          | `mail`
Username      | `<blank>`
Password      | `<blank>`
Port          | `1025`
GUI           | `http://localhost:8025`


## RoadMap

[ ] Environment specific containers/settings
[ ] Speed optimisations
