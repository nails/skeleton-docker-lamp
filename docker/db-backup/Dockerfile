FROM php:7.2.15-cli-alpine3.9

ADD templates/crontab /crontab
COPY templates/entry.sh /entry.sh
COPY templates/backup.sh /backup.sh

RUN chmod 755 /entry.sh /backup.sh && \
    /usr/bin/crontab /crontab && \
    # Install: dependencies
    apk upgrade && \
    apk add \
        git \
        zip \
        unzip \
        zlib-dev \
        php-zip && \
    # Install: PHP extensions
    docker-php-ext-install \
        zip && \
    # Install: Shed Command Line Tool
    git clone https://github.com/shedcollective/shed-cli-tool.git $HOME/shed-cli-tool && \
    ln -s $HOME/shed-cli-tool/dist/shed /usr/local/bin/shed

CMD ["/entry.sh"]
