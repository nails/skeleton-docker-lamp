# An easy to use LAMP environment using Docker

![license](https://img.shields.io/badge/license-MIT-green.svg)
[![CircleCI branch](https://img.shields.io/circleci/project/github/nails/skeleton-docker-lamp.svg)](https://circleci.com/gh/nails/skeleton-docker-lamp)
[![Scrutinizer Code Quality](https://scrutinizer-ci.com/g/nails/skeleton-docker-lamp/badges/quality-score.png)](https://scrutinizer-ci.com/g/nails/skeleton-docker-lamp)
[![Join the chat on Slack!](https://now-examples-slackin-rayibnpwqe.now.sh/badge.svg)](https://nails-app.slack.com/shared_invite/MTg1NDcyNjI0ODcxLTE0OTUwMzA1NTYtYTZhZjc5YjExMQ)

A _slightly_ opinionated, but **really easy to use** Docker LAMP stack with out-of-the-box support for some common frameworks.



## Table of Contents

- [Features](#features)
- [How to use](#how-to-use)
- [Configuration](#configuration)
- [Containers](#containers)
    - [Web Server](#webserver)
        - [SSL](#ssl)
        - [Cron](#cron)
    - [Database](#database)
        - [Backups](#backups)
    - [Email](#email)
- [Frameworks](#frameworks)
    - [Nails](#nails)
    - [Laravel](#laravel)
    - [WordPress](#wordpress)



## How to use

This repository is, more or less, just a wrapper for `docker-compose` with some sparkle sprinkled on top; to make life a little easier we use a `Makefile` to wrap up some of the common commands.

Day-to-day, you'll likely use `make up` and `make down` when working with this stack, but the following are available:


Command                  | Value
------------------------ | -----------------------------------------------------------------------
`make build`             | Executes `./www/build.sh` within the context of the web server container
`make build-containers`  | Builds the project containers
`make build-fresh`       | Executes ./www/build.sh within the context of the web server container, passing "fresh" as an arg
`make clean`             | Stop, then remove, all containers
`make down`              | Stop all containers
`make restart`           | Restart all containers
`make seed`              | Executes `./www/seed.sh` within the context of the web server container
`make ssh`               | SSH into the web server container
`make ssh-root`          | SSH into the web server container, as root
`make ssl-create`        | Creates a new LetsEncrypt SSL certificate
`make ssl-renew`         | Renews a previously created LetsEncrypt SSL certificate
`make test`              | Executes `./www/test.sh` within the context of the web server container
`make test-fresh`        | Executes `./www/test.sh` within the context of the web server container, triggering a database refresh
`make up`                | Start all containers, install framework if necessary, configure cron, and configure SSL
`make watch`             | Executes `./www/watch.sh` within the context of the web server container

Feel free to add your own, as per your project's needs.



## Configuration

`docker-compose.yml` contains the basic requirements to run the project, exclusive of any credentials (e.g database). Configure your containers for the appropriate environment using `docker-compose.override.yml`.

> The included override contains default credentials for a development environment and should be replaced for other environments.



## Containers


### Web server

The web server container has all you need enabled for development; you can specify custom configurations using the `./docker/webserver/templates/*` files.

In addition, the following directories are of interest:

- The web root is available at `./www`
- Web server logs are available at `./docker/webserver/logs`
- LetsEncrypt configurations are available at `./docker/webserver/letsencrypt`

> By default an Apache / PHP 7.2 container is made with the Nails CLI tool installed; you can swap this out for a PHP 5.6 web server by updating the build image used in `docker-compose.yml` to `docker/webserver/apache-php56`. Alternatively, you can use one of the [framework](#frameworks) orientated images.

> Note: On first install the `www` folder will be created and the chosen framework (if applicable) installed into it.


#### SSL

The web server is equipped with a self-signed SSL certificate by default, so you can test secure connections on `localhost`. `certbot` is also available for generating, and renewing, valid certificates via LetsEncrypt.

> When working on `localhost` *expect* for your browser to throw unsecure errors. This is because a self-signed certificate is being used and is unavoidable when using `localhost`.


#### Cron

There is an empty crontab which you can populate at `./docker/webserver/crontab`. This will populate in the web server when `make up` is called. If needed, you can populate root's crontab using the template at `./docker/webserver/crontab-root`.

> The crontab is synced to the container each time `make up` is called. Changes made _within_ the container (using `crontab -e`) will be synced back to the host immediately.



### Database

By default you can connect to the database using the following credentials:

Property      | Value
------------- | -------------
Host:         | `db`
Username:     | `docker`
Password:     | `docker`
Port:         | `3306`
Database:     | `dev`

All database files are stored in `./docker/db/data` so that your data will survive containers being removed.

> It is recommended to secure your installation using non-default credentials in non-development environments. Do this by adjusting the `docker-compose.override.yml` file.


#### Backups

Automated off-site backups to S3 are easily configured using the `db-backup` Dockerfile. Simply add the following configuration to your `docker-compose.override.yml` file:

```
 db-backup:
     build: "docker/db-backup"
     links:
         - db
     volumes:
         - './docker/db-backup/logs:/var/log:delegated'
     environment:
         - S3_ACCESS_TOKEN=my-super-secret-access-token
         - S3_ACCESS_SECRET=my-super-secret-access-secret
         - S3_BUCKET=my-s3-bucket
         - MYSQL_HOST=db
         - MYSQL_USER=docker
         - MYSQL_PASSWORD=docker
         - MYSQL_DATABASE=dev
```

> Remember to update the env vars according to your configuration.

You can configure the backup schedule by editing `./docker/db-backup/templates/crontab`, by default (and when enabled), the backups will run daily at midnight (00:00).

Under the hood, the backup is powered by the [Shed CLI tool](https://github.com/shedcollective/shed-cli-tool).



### Email

By default, all email is routed to MailHog (as specified in `docker-compose.override.yml`); this acts as a catch-all to avoid email being sent to real addresses.

> Remember to use valid email settings when deploying to non-development environments.


Property      | Value
------------- | -------------
Host          | `mail`
Username      | `<blank>`
Password      | `<blank>`
Port          | `1025`
GUI           | `http://localhost:8025`



## Frameworks

By default, the web server is a fairly standard Apache instance with PHP 7.2 installed. There are various other web server flavours available, simply change the `Dockerfile` which `docker-compose` will use in the project's `docker-compose.yml` file.

> Note: On first install the `www` folder will be created and the chosen framework installed into it. This installation will *not* run if the `www` folder is detected. When not using a framework, a holding page will be installed instead.


### Nails

**`docker/webserver/apache-nails-php72`**

This framework will install Nails to `www` with default settings. It will also install the [Nails Command Line Tool](https://github.com/nails/command-line-tool).


### Laravel

**`docker/webserver/apache-laravel-php72`**

This framework will install Laravel to `www` with default settings.


### WordPress

**`docker/webserver/apache-wordpress-php72`**

This framework will install Wordpress to `www` with default settings.
