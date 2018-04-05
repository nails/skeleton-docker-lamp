FROM php:7.2-apache

# Create: user
RUN useradd -u 1000 -m www-bridge-user

# Install: dependencies
RUN apt-get update -y && \
    apt-get install -y \
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
    wget \
    gnupg2 \
    mysql-client

# Install: Node
RUN apt-get update && \
    curl -sL https://deb.nodesource.com/setup_9.x | bash - && \
    apt-get install -y nodejs

# Install: PHP extensions
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install pdo pdo_mysql mysqli gd curl
RUN pecl install mcrypt-1.0.1

# Install: composer
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/bin/composer

# Install: phpunit
RUN wget https://phar.phpunit.de/phpunit-6.5.phar && \
    chmod +x phpunit-6.5.phar && \
    mv phpunit-6.5.phar /usr/bin/phpunit

# Install: Nails Command Line Tool
RUN git clone https://github.com/nailsapp/command-line-tool ~/nails-command-line-tool && \
    mv ~/nails-command-line-tool/nails /usr/bin/nails

# Enable: mod_rewrite
RUN a2enmod rewrite
RUN service apache2 restart

# Install: configuration files
ADD templates/apache2.conf /etc/apache2/
ADD templates/php.ini /usr/local/etc/php/
