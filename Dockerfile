FROM alpine/git AS clone-repo

ARG version=1.3.0

RUN git clone --depth 1 --recursive -b v${version} https://github.com/craigk5n/webcalendar.git /app

FROM php:7.4-apache

COPY --from=clone-repo /app /var/www/html
RUN chown -R www-data:www-data /var/www/html/includes && chmod -R 755 /var/www/html/includes

RUN apt-get update && apt-get install -y zlib1g-dev libpng-dev && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install -j$(nproc) mysqli gd