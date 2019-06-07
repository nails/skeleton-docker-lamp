#!/usr/bin/env bash
shed project:backup:directories \
    -n \
    --domain=$DOMAIN \
    --s3-key=$S3_ACCESS_KEY \
    --s3-secret=$S3_ACCESS_SECRET \
    --s3-bucket=$S3_BUCKET \
    --directory=$DIRECTORY \
