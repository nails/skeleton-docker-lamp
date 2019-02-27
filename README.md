# An easy to use LAMP environment using Docker

![license](https://img.shields.io/badge/license-MIT-green.svg)
[![CircleCI branch](https://img.shields.io/circleci/project/github/nails/skeleton-docker-lamp.svg)](https://circleci.com/gh/nails/skeleton-docker-lamp)
[![Scrutinizer Code Quality](https://scrutinizer-ci.com/g/nails/skeleton-docker-lamp/badges/quality-score.png)](https://scrutinizer-ci.com/g/nails/skeleton-docker-lamp)
[![Join the chat on Slack!](https://now-examples-slackin-rayibnpwqe.now.sh/badge.svg)](https://nails-app.slack.com/shared_invite/MTg1NDcyNjI0ODcxLTE0OTUwMzA1NTYtYTZhZjc5YjExMQ)

A _slightly_ opinionated, but **really easy to use** Docker LAMP stack with out-of-the-box support for some common frameworks.


## Features

  - A LAMP environment running:
    - Apache 2.4
    - PHP 7.2
    - MySQL 5.7
    - Composer
    - NodeJS/NPM
    - Yarn
    - Certbot (for SSL certificates)
  - [Out of the box support for various Frameworks](docker/docs/README.md#frameworks)
    - [Nails](docker/docs/README.md#nails)
    - [Laravel](docker/docs/README.md#laravel)
    - [WordPress](docker/docs/README.md#wordpress)
  - [Mailhog](https://github.com/mailhog/MailHog) installed for working with emails locally



## Table of Contents

- [Features](docker/docs/README.md#features)
- [How to use](docker/docs/README.md#how-to-use)
- [Configuration](docker/docs/README.md#configuration)
- [Containers](docker/docs/README.md#containers)
    - [Web Server](docker/docs/README.md#webserver)
        - [SSL](docker/docs/README.md#ssl)
        - [Cron](docker/docs/README.md#cron)
    - [Database](docker/docs/README.md#database)
        - [Backups](docker/docs/README.md#backups)
    - [Email](docker/docs/README.md#email)
- [Frameworks](docker/docs/README.md#frameworks)
    - [Nails](docker/docs/README.md#nails)
    - [Laravel](docker/docs/README.md#laravel)
    - [WordPress](docker/docs/README.md#wordpress)
