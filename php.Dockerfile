FROM php:8.0-fpm-alpine3.14

RUN cp "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions gd mysqli opcache imap zip imagick memcached intl

RUN apk add --update --no-cache \
        unzip

RUN curl -sS https://getcomposer.org/installer -o composer-setup.php \
     && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
     && rm -rf composer-setup.php

COPY composer.json composer.lock ./

RUN composer install

WORKDIR /var/www/html/

COPY . .