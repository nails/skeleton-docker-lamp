openssl genrsa \
    -out localhost.key 4096 && \

openssl req -new \
    -out localhost.csr \
    -key localhost.key \
    -config localhost.ssl.conf && \

openssl x509 -req \
    -days 3650 \
    -in localhost.csr \
    -signkey localhost.key \
    -out localhost.crt \
    -extensions req_ext \
    -extfile localhost.ssl.conf && \

openssl x509 -trustout \
    -signkey localhost.key \
    -days 365 \
    -req \
    -in localhost.csr \
    -out localhost.pem && \

mkdir -p ../apache-laravel-php72/templates/ssl && \
mkdir -p ../apache-nails-php72/templates/ssl && \
mkdir -p ../apache-php72/templates/ssl && \
mkdir -p ../apache-wordpress-php72/templates/ssl && \

cp localhost.crt ../apache-laravel-php72/templates/ssl && \
cp localhost.crt ../apache-nails-php72/templates/ssl && \
cp localhost.crt ../apache-php72/templates/ssl && \
cp localhost.crt ../apache-wordpress-php72/templates/ssl && \

cp localhost.csr ../apache-laravel-php72/templates/ssl && \
cp localhost.csr ../apache-nails-php72/templates/ssl && \
cp localhost.csr ../apache-php72/templates/ssl && \
cp localhost.csr ../apache-wordpress-php72/templates/ssl && \

cp localhost.key ../apache-laravel-php72/templates/ssl && \
cp localhost.key ../apache-nails-php72/templates/ssl && \
cp localhost.key ../apache-php72/templates/ssl && \
cp localhost.key ../apache-wordpress-php72/templates/ssl && \

cp localhost.pem ../apache-laravel-php72/templates/ssl && \
cp localhost.pem ../apache-nails-php72/templates/ssl && \
cp localhost.pem ../apache-php72/templates/ssl && \
cp localhost.pem ../apache-wordpress-php72/templates/ssl