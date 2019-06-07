FROM php:7.2.15-cli-alpine3.9

ADD templates/crontab /crontab
COPY templates/entry.sh /entry.sh
COPY templates/backup-database.sh /backup/database.sh
COPY templates/backup-directory.sh /backup/directory.sh

RUN chmod 755 /entry.sh /backup/database.sh /backup/directory.sh && \
    /usr/bin/crontab /crontab && \
    # Install: dependencies
    apk upgrade && \
    apk add \
        bash \
        git \
        zip \
        unzip \
        zlib-dev \
        php-zip \
        mysql-client \
        python \
        py-pip && \
    # Install: PHP extensions
    docker-php-ext-install \
        zip && \
    # Install: Shed Command Line Tool
    git clone https://github.com/shedcollective/shed-cli-tool.git $HOME/shed-cli-tool && \
    ln -s $HOME/shed-cli-tool/dist/shed /usr/local/bin/shed &&\
    # Install: s3cmd
    pip install python-dateutil && \
    mkdir -p $HOME/s3cmd && \
    cd $HOME/s3cmd && \
    wget https://sourceforge.net/projects/s3tools/files/s3cmd/2.0.2/s3cmd-2.0.2.tar.gz && \
    tar -xzf s3cmd-2.0.2.tar.gz && \
    cd s3cmd-2.0.2 && \
    python setup.py install && \
    ln -s $HOME/s3cmd/s3cmd-2.0.2/s3cmd /usr/local/bin/s3cmd

CMD ["/entry.sh"]
