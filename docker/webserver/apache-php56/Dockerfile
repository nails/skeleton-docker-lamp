FROM php:5.6-apache

# Install: configuration files
COPY templates/apache2.conf /etc/apache2/
COPY templates/php.ini /usr/local/etc/php/
COPY templates/localhost.ssl.conf /etc/ssl/localhost/
COPY templates/cron.sh /cron.sh

RUN useradd -u 1000 -m www-bridge-user && \
    # Add backports (for LetsEncrypt)
    echo 'deb http://deb.debian.org/debian jessie-backports main' > /etc/apt/sources.list.d/backports.list && \
    # Install: dependencies
    apt-get update -y && \
    apt-get install -y --no-install-recommends \
    cron \
    git \
    zip \
    unzip \
    libpng-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libnotify-bin \
    curl \
    vim \
    libcurl4-openssl-dev \
    gnupg2 \
    mysql-client \
    ssh-client && \
    apt-get install python-certbot-apache -y -t jessie-backports && \
    rm -rf /var/lib/apt/lists/* && \
    # Install: PHP extensions
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install pdo pdo_mysql mysqli gd curl mcrypt zip && \
    # Install: Node
    curl -sL https://deb.nodesource.com/setup_9.x | bash - && \
    apt-get update -y && apt-get install -y nodejs && \
    # Install: Yarn
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update -y && apt-get install -y yarn && \
    # Install: composer
    curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/bin/composer && \
    # Enable: Apache modules
    a2enmod rewrite && \
    a2enmod ssl && \
    a2enmod headers && \
    a2enmod expires && \
    # Create local SSL certificate
    mkdir -p /etc/ssl/localhost && \
    openssl req -x509 -out /etc/ssl/localhost/localhost.crt -keyout /etc/ssl/localhost/localhost.key \
        -newkey rsa:2048 -nodes -sha256 \
        -subj '/CN=localhost' -extensions EXT -config /etc/ssl/localhost/localhost.ssl.conf && \
    # Restart apache
    service apache2 restart
