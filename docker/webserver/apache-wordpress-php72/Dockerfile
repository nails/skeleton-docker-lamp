FROM php:7.2-apache

# Install: configuration files
COPY templates/apache2.conf /etc/apache2/
COPY templates/php.ini /usr/local/etc/php/
COPY templates/localhost.ssl.conf /etc/ssl/localhost/
COPY templates/ssl-create.sh /ssl-create.sh

RUN useradd -u 1000 -m www-bridge-user && \
    cp /etc/skel/.bashrc ~/ && \
    cp /etc/skel/.profile ~/ && \
    # Install: dependencies
    apt-get update -y && \
    apt-get install -y --no-install-recommends \
    rsyslog \
    logrotate \
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
    rm -rf /var/lib/apt/lists/* && \
    # Logging: Enable cron logs
    sed -i "s:#cron:cron:g" /etc/rsyslog.conf && \
    # Install: certbot
    curl https://dl.eff.org/certbot-auto -o /usr/local/bin/certbot && \
    chmod a+x /usr/local/bin/certbot && \
    # Install: Node
    curl -sL https://deb.nodesource.com/setup_9.x | bash - && \
    apt-get update -y && apt-get install -y nodejs && \
    # Install: Yarn
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update -y && apt-get install -y yarn && \
    # Install: PHP extensions
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install pdo pdo_mysql mysqli gd curl zip && \
    pecl install mcrypt-1.0.1 && \
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
    service apache2 restart && \
    # Configure services to start on boot
    update-rc.d rsyslog enable && \
    update-rc.d cron enable

# Install: bash aliases (after www-bridge-user has been created)
COPY templates/.bash_aliases /root
COPY templates/.bash_aliases /home/www-bridge-user
