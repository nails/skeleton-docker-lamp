# A Nails friendly LAMP environment using docker

A **really easy** docker LAMP stack.



## Features

  - A LAMP environment running:
    - Apache 2.4
    - PHP 7.2
    - MySQL 5.6
  - [Mailhog](https://github.com/mailhog/MailHog) installed for working with emails locally



## How to use

This repository is simply a wrapper for `docker-compose`; to make life a little easier we use a `Makefile` to wrap up some of the common commands. Feel free to add your own, as per your project's needs

- `build`  - Builds all the containers
- `start`  - Start all the containers
- `up`     - Alias of start
- `stop`   - Stop all the containers
- `down`   - Alias of stop
- `clean`  - Remove all the containers



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
