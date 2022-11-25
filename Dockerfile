FROM php

RUN apt-get update && apt-get full-upgrade -y \
     && apt-get install -y libzip-dev zip \
     && docker-php-ext-install pdo pdo_mysql sockets \
     && docker-php-ext-install zip
RUN curl -sS https://getcomposer.org/installer | php -- \
     --install-dir=/usr/local/bin --filename=composer

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /app
COPY ./laravel/ .
RUN composer install