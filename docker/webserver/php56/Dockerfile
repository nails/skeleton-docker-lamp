FROM php:5.6-apache

RUN useradd -u 1000 -m www-bridge-user && \
    # Install: dependencies
    apt-get update -y && \
    apt-get install -y --no-install-recommends \
    git \
    zip \
    libpng-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libnotify-bin \
    curl \
    vim \
    libcurl4-openssl-dev \
    gnupg2 \
    mysql-client && \
    rm -rf /var/lib/apt/lists/* && \
    # Install: PHP extensions
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install pdo pdo_mysql mysqli gd curl mcrypt && \
    # Install: Node
    curl -sL https://deb.nodesource.com/setup_9.x | bash - && \
    apt-get install -y nodejs && \
    # Install: composer
    curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/bin/composer && \
    # Install: phpunit
    curl -sS https://phar.phpunit.de/phpunit-5.7.9.phar -o phpunit-5.7.9.phar && \
    chmod +x phpunit-5.7.9.phar && \
    mv phpunit-5.7.9.phar /usr/bin/phpunit && \
    # Install: Nails Command Line Tool
    git clone https://github.com/nailsapp/command-line-tool ~/nails-command-line-tool && \
    mv ~/nails-command-line-tool/nails /usr/bin/nails && \
    rm -rf ~/nails-command-line-tool && \
    # Enable: mod_rewrite
    a2enmod rewrite && \
    service apache2 restart

# Install: configuration files
ADD templates/apache2.conf /etc/apache2/
ADD templates/php.ini /usr/local/etc/php/
