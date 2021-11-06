FROM php:8.0-fpm-alpine3.14

RUN cp "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions gd mysqli opcache imap zip imagick memcached intl @composer-2.1.11

COPY composer.json composer.lock ./

RUN composer install

WORKDIR /var/www/html/

COPY . .