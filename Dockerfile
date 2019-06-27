FROM php:7-cli
MAINTAINER Kingsquare <docker@kingsquare.nl>

ENV TZ "Europe/Amsterdam"

RUN apt-get update && \
    apt-get install -qy --no-install-recommends \
        libmcrypt-dev \
        libbz2-dev \
        zlib1g-dev \
        libzip-dev \
        unzip \
        curl \
        git \
        && \
    docker-php-ext-install zip bz2 mbstring && \
    docker-php-ext-enable opcache && \
    echo "opcache.enable_cli = On" > /usr/local/etc/php/conf.d/opcache-cli.ini && \
    echo "date.timezone = $TZ" > /usr/local/etc/php/conf.d/timezone.ini && \
    echo "memory_limit=1024M" > /usr/local/etc/php/conf.d/memory-limit.ini && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    curl -o /usr/local/bin/phpunit https://phar.phpunit.de/phpunit.phar && \
    chmod +x /usr/local/bin/phpunit && \
    mkdir -p ~/.ssh /root/.ssh /etc/ssh
