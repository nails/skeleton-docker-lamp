#!/bin/bash

echo "Installing SSL certificate for $DOMAIN"

if [  "$DOMAIN" != "localhost"  ]; then
    certbot certonly \
        --domain $DOMAIN \
        --domain www.$DOMAIN \
        --non-interactive \
        --agree-tos \
        -m $CERTBOT_EMAIL \
        --webroot \
        --webroot-path /var/www/html || exit 1

    SSL_BLOCK="SSLEngine on\nSSLCertificateFile      /etc/letsencrypt/live/$DOMAIN/fullchain.pem\n    SSLCertificateKeyFile   /etc/letsencrypt/live/$DOMAIN/privkey.pem\n    SSLCertificateChainFile /etc/letsencrypt/live/$DOMAIN/privkey.pem"
else
    SSL_BLOCK="SSLEngine on\n    SSLCertificateFile    /etc/ssl/localhost/localhost.crt\n    SSLCertificateKeyFile /etc/ssl/localhost/localhost.key"
fi

sed -i "s:# SSL-BLOCK:$SSL_BLOCK:g" /etc/apache2/apache2.conf
echo "Reloading apache"
service apache2 reload