FROM mysql:5.7

ADD templates/custom_config.cnf /etc/mysql/conf.d/
ADD templates/grant-default-user.sql /docker-entrypoint-initdb.d/
