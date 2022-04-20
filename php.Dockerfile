## [1] Obraz bazowy
FROM php:7.4-fpm-alpine3.15
RUN apk update; \
    apk upgrade;
RUN docker-php-ext-install mysqli
