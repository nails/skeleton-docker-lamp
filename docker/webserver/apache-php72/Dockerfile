FROM php:7.2-apache-stretch

ARG PHP_XDEBUG

# Install: configuration files
COPY templates/apache2.conf /etc/apache2/
COPY templates/php.ini /usr/local/etc/php/
COPY templates/xdebug.ini /usr/local/etc/php/conf.d/
COPY templates/localhost.ssl.conf /etc/ssl/localhost/
COPY templates/ssl-create.sh /ssl-create.sh
COPY templates/cron.sh /cron.sh

RUN useradd -u 1000 -m www-bridge-user && \
    cp /etc/skel/.bashrc ~/ && \
    cp /etc/skel/.profile ~/ && \
    # Install: dependencies
    apt-get update -y && \
    apt-get install -y --no-install-recommends \
        dnsutils \
        rsyslog \
        logrotate \
        cron \
        git \
        zip \
        unzip \
        libpng-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libicu-dev \
        libnotify-bin \
        libcurl4-openssl-dev \
        curl \
        vim \
        gnupg2 \
        mysql-client \
        ssh-client && \
    # Purge so apt-get update is more reliable
    rm -rf /var/lib/apt/lists/* && \
    # Logging: Enable cron logs
    sed -i "s:#cron:cron:g" /etc/rsyslog.conf && \
    # Install: certbot
    curl https://dl.eff.org/certbot-auto -o /usr/local/bin/certbot && \
    chmod a+x /usr/local/bin/certbot && \
    # Install: Node
    curl -sL https://deb.nodesource.com/setup_11.x | bash - && \
    apt-get update -y && apt-get install -y \
        nodejs && \
    # Install: Yarn
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update -y && apt-get install -y \
        yarn && \
    # Install: PHP extensions
    docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-configure intl && \
    docker-php-ext-install \
        pdo \
        pdo_mysql \
        mysqli \
        gd \
        curl \
        zip \
        intl && \
    # Install: Xdebug
    if [ "$PHP_XDEBUG" = "1" ]; then pecl install xdebug; else rm /usr/local/etc/php/conf.d/xdebug.ini; fi && \
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
    # Generate a key
    openssl genrsa \
        -out /etc/ssl/localhost/localhost.key 4096 && \
    # Create a CSR
    openssl req -new \
        -out /etc/ssl/localhost/localhost.csr \
        -key /etc/ssl/localhost/localhost.key \
        -config /etc/ssl/localhost/localhost.ssl.conf &&\
    # Generate the certificate
    openssl x509 -req \
        -days 3650 \
        -in /etc/ssl/localhost/localhost.csr \
        -signkey /etc/ssl/localhost/localhost.key \
        -out /etc/ssl/localhost/localhost.crt \
        -extensions req_ext \
        -extfile /etc/ssl/localhost/localhost.ssl.conf && \
    # Generate chainfile
    openssl x509 -trustout \
        -signkey /etc/ssl/localhost/localhost.key \
        -days 365 \
        -req \
        -in /etc/ssl/localhost/localhost.csr \
        -out /etc/ssl/localhost/localhost.pem && \
    # Restart apache
    service apache2 restart && \
    # Configure services to start on boot
    update-rc.d rsyslog enable && \
    update-rc.d cron enable

# Install: bash aliases (after www-bridge-user has been created)
COPY templates/.bash_aliases /root
COPY templates/.bash_aliases /home/www-bridge-user
