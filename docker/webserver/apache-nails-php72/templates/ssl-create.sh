#!/bin/bash

echo "Installing SSL certificate for $DOMAIN"

if [  "$DOMAIN" != "localhost"  ]; then
    certbot certonly \
        --domain $DOMAIN \
        --domain www.$DOMAIN \
        --non-interactive \
        --agree-tos \
        -m $CERTBOT_EMAIL \
        --expand \
        --webroot \
        --webroot-path /var/www/html || exit 1

   SSL_CERT="/etc/letsencrypt/live/$DOMAIN/fullchain.pem"
   SSL_KEY="/etc/letsencrypt/live/$DOMAIN/privkey.pem"
   SSL_CHAIN="/etc/letsencrypt/live/$DOMAIN/privkey.pem"
else
    SSL_CERT="/etc/ssl/localhost/localhost.crt"
    SSL_KEY="/etc/ssl/localhost/localhost.key"
    SSL_CHAIN="/etc/ssl/localhost/localhost.key"
fi

sed -i -E "s:SSLCertificateFile(.*) (.*):SSLCertificateFile\1 $SSL_CERT:g" /etc/apache2/apache2.conf
sed -i -E "s:SSLCertificateKeyFile(.*) (.*):SSLCertificateKeyFile\1 $SSL_KEY:g" /etc/apache2/apache2.conf
sed -i -E "s:SSLCertificateChainFile(.*) (.*):SSLCertificateChainFile\1 $SSL_KEY:g" /etc/apache2/apache2.conf

echo "Reloading apache"
service apache2 reload
