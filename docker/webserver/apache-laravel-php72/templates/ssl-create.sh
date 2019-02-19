#!/bin/bash
if [  "$DOMAIN" != "localhost"  ]; then

    # Generate the certificate
    certbot certonly \
        --domain $DOMAIN \
        --domain www.$DOMAIN \
        --non-interactive \
        --agree-tos \
        -m $CERTBOT_EMAIL \
        --webroot \
        --webroot-path /var/www/html &\
    # Install the certificate
    echo "Install certificate to apache2.conf"

else
    echo "Refusing to generate certificate for localhost"
fi