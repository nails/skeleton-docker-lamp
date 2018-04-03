FROM php:7-apache
RUN useradd -u 1000 -m www-bridge-user
RUN apt-get update -y && \
    apt-get install -y \
    libpng-dev \
    libmcrypt-dev \
    curl \
    libcurl4-openssl-dev
RUN docker-php-ext-install pdo pdo_mysql gd curl
RUN pecl install mcrypt-1.0.1
RUN a2enmod rewrite
RUN service apache2 restart

ADD templates/apache2.conf /etc/apache2/
ADD templates/php.ini /usr/local/etc/php/
#ADD templates/ssmtp.conf /etc/ssmtp/
#ADD templates/xdebug.ini /usr/local/etc/php/conf.d/
