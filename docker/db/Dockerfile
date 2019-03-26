FROM mysql:5.7

# Ensure the mysql user runs as 1000:1000; same as the www-bridge-user
RUN sed -i 's/mysql:x:999:999/mysql:x:1000:1000/g' /etc/passwd && \
    sed -i 's/mysql:x:999:/mysql:x:1000:/g' /etc/group

ADD templates/custom_config.cnf /etc/mysql/conf.d/
ADD templates/grant-default-user.sql /docker-entrypoint-initdb.d/
