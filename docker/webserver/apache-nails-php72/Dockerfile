FROM php:7.2-apache-stretch

ARG PHP_XDEBUG=0
ARG PHP_BLACKFIRE=0
ARG PHP_BLACKFIRE_CLIENT_ID=""
ARG PHP_BLACKFIRE_CLIENT_TOKEN=""
ARG PHP_BLACKFIRE_SERVER_ID=""
ARG PHP_BLACKFIRE_SERVER_TOKEN=""

# Install: configuration files
COPY templates/apache2.conf /etc/apache2/
COPY templates/php.ini /usr/local/etc/php/
COPY templates/xdebug.ini /usr/local/etc/php/conf.d/
COPY templates/blackfire.ini /usr/local/etc/php/conf.d/zz-blackfire.ini
COPY templates/opcache.ini /usr/local/etc/php/conf.d/
COPY templates/ssl-create.sh /ssl-create.sh
COPY templates/cron.sh /cron.sh

# Install SSL certificate
COPY templates/ssl/localhost.crt /etc/ssl/localhost/
COPY templates/ssl/localhost.csr /etc/ssl/localhost/
COPY templates/ssl/localhost.key /etc/ssl/localhost/
COPY templates/ssl/localhost.pem /etc/ssl/localhost/

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
    /usr/local/bin/certbot --version -n && \
    # Install: Node
    curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    apt-get update -y && apt-get install -y --no-install-recommends \
        nodejs && \
    # Install: Yarn
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update -y && \
    apt-get install -y --no-install-recommends \
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
    # Install: Blackfire
    if [ "$PHP_BLACKFIRE" = "1" ]; then echo "Installing Blackfire"; else rm /usr/local/etc/php/conf.d/zz-blackfire.ini; fi && \
    if [ "$PHP_BLACKFIRE" = "1" ]; then curl -sS https://packages.blackfire.io/gpg.key | apt-key add -; fi && \
    if [ "$PHP_BLACKFIRE" = "1" ]; then echo "deb http://packages.blackfire.io/debian any main" | tee /etc/apt/sources.list.d/blackfire.list; fi && \
    if [ "$PHP_BLACKFIRE" = "1" ]; then apt-get update -y; fi && \
    if [ "$PHP_BLACKFIRE" = "1" ]; then apt-get install -y --no-install-recommends blackfire-agent; fi && \
    if [ "$PHP_BLACKFIRE" = "1" ]; then blackfire-agent --register --server-id=$PHP_BLACKFIRE_SERVER_ID --server-token=$PHP_BLACKFIRE_SERVER_TOKEN; fi && \
    if [ "$PHP_BLACKFIRE" = "1" ]; then apt-get install -y --no-install-recommends blackfire-php; fi && \
    if [ "$PHP_BLACKFIRE" = "1" ]; then su www-bridge-user -c "blackfire config --client-id=$PHP_BLACKFIRE_CLIENT_ID --client-token=$PHP_BLACKFIRE_CLIENT_TOKEN"; fi && \
    if [ "$PHP_BLACKFIRE" = "1" ]; then /etc/init.d/blackfire-agent restart; fi && \
    # Install: composer
    curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/bin/composer && \
    # Install: Nails Command Line Tool
    su www-bridge-user -c 'composer global require nails/command-line-tool --no-ansi' && \
    ln -s /home/www-bridge-user/.composer/vendor/bin/nails /usr/local/bin/nails && \
    ln -s /home/www-bridge-user/.composer/vendor/bin/nails-cli /usr/local/bin/nails-cli && \
    # Enable: Apache modules
    curl "https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_amd64.deb" > ~/mod_pagespeed.deb && \
    dpkg -i ~/mod_pagespeed.deb && \
    a2enmod rewrite && \
    a2enmod ssl && \
    a2enmod headers && \
    a2enmod expires && \
    # Add env vars to Apache
    touch /env-apache.sh && \
    echo ". /env-apache.sh" >> /etc/apache2/envvars && \
    # Configure services to start on boot
    update-rc.d rsyslog enable && \
    update-rc.d cron enable

# Install: bash aliases (after www-bridge-user has been created)
COPY templates/.bash_aliases /root
COPY templates/.bash_aliases /home/www-bridge-user

# Late install of some config files
COPY templates/pagespeed.conf /etc/apache2/mods-available/
