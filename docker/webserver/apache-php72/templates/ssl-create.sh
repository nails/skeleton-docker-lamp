#!/bin/bash

# Remove www.
if [[ $DOMAIN =~ ^www\. ]]; then
    SSL_DOMAIN=${DOMAIN:4};
else
    SSL_DOMAIN=${DOMAIN};
fi

echo "Installing SSL certificate for ${SSL_DOMAIN}"

# --------------------------------------------------------------------------

# Generate certificate and set variables
if [[  "${SSL_DOMAIN}" != "localhost"  ]]; then

    # Calculate which domains to create a certificate for
    DOMAINS=()
    if [[ "$(dig +short ${SSL_DOMAIN}.)" != "" ]]; then
        DOMAINS=( "${DOMAINS[@]}" "${SSL_DOMAIN}" )
    fi
    if [[ "$(dig +short www.${SSL_DOMAIN}.)" != "" ]]; then
        DOMAINS=( "${DOMAINS[@]}" "www.${SSL_DOMAIN}" )
    fi
    DOMAINS=$(IFS=$','; echo "${DOMAINS[*]}")

    echo "Generating certificate for:"
    echo ${DOMAINS}

    certbot certonly \
        --domains ${DOMAINS} \
        --non-interactive \
        --agree-tos \
        -m ${CERTBOT_EMAIL} \
        --expand \
        --webroot \
        --webroot-path /var/www/html || exit 1

   SSL_CERT="/etc/letsencrypt/live/${SSL_DOMAIN}/cert.pem"
   SSL_KEY="/etc/letsencrypt/live/${SSL_DOMAIN}/privkey.pem"
   SSL_CHAIN="/etc/letsencrypt/live/${SSL_DOMAIN}/chain.pem"
else
    SSL_CERT="/etc/ssl/localhost/localhost.crt"
    SSL_KEY="/etc/ssl/localhost/localhost.key"
    SSL_CHAIN="/etc/ssl/localhost/localhost.pem"
fi

# --------------------------------------------------------------------------

# Write the variables to Apache conf
sed -i -E "s:SSLCertificateFile(.*) (.*):SSLCertificateFile\1 ${SSL_CERT}:g" /etc/apache2/apache2.conf
sed -i -E "s:SSLCertificateKeyFile(.*) (.*):SSLCertificateKeyFile\1 ${SSL_KEY}:g" /etc/apache2/apache2.conf
sed -i -E "s:SSLCertificateChainFile(.*) (.*):SSLCertificateChainFile\1 ${SSL_CHAIN}:g" /etc/apache2/apache2.conf

# --------------------------------------------------------------------------

# Reload apache
echo "Reloading Apache"
service apache2 reload
