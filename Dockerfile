FROM mysql:8.0.12 as mysql

COPY ./mysql/sql /docker-entrypoint-initdb.d

FROM composer:latest as composer

FROM php:7.3.11-fpm-alpine as php

RUN apk add --no-cache freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev gettext gettext-dev && \
  docker-php-ext-configure gd \
    --with-gd \
    --with-freetype-dir=/usr/include/ \
    --with-png-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/ && \
  NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
  docker-php-ext-install -j${NPROC} gd && \
  docker-php-ext-install mysqli opcache pdo_mysql gettext && \
  apk del --no-cache freetype-dev libpng-dev libjpeg-turbo-dev

COPY --from=composer /usr/bin/composer /usr/bin/composer

WORKDIR /app

COPY php/composer.* /app/

COPY php/wp/src /app/src

RUN apk --no-cache add shadow && \
    usermod -u 1000 www-data && \
    chown -R www-data:www-data /app

ENTRYPOINT sh -c "composer install && php-fpm"

FROM nginx:1.15.2-alpine as nginx

RUN rm -rf /etc/nginx/conf.d

COPY ./nginx/backend/conf/default.conf /etc/nginx/conf.d/default.conf
COPY  --from=php /app/src /app/src

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]