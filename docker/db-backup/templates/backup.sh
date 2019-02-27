shed project:db:backup \
    --token=$S3_ACCESS_TOKEN \
    --secret=$S3_ACCESS_SECRET \
    --bucket=$S3_BUCKET \
    --mysql-host=$MYSQL_HOST \
    --mysql-user=$MYSQL_USER \
    --mysql-password=$MYSQL_PASSWORD \
    --mysql-database=$MYSQL_DATABASE
