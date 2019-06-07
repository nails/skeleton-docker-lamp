#!/usr/bin/env bash
shed project:backup:database \
    -n \
    --domain=$DOMAIN \
    --s3-key=$S3_ACCESS_KEY \
    --s3-secret=$S3_ACCESS_SECRET \
    --s3-bucket=$S3_BUCKET \
    --mysql-host=$MYSQL_HOST \
    --mysql-user=$MYSQL_USER \
    --mysql-password=$MYSQL_PASSWORD \
    --mysql-database=$MYSQL_DATABASE
