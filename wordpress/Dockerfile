FROM alpine:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apk update \
    && apk add vim wget procps php php-curl php-dom php-exif php-fileinfo php-json php-mbstring php-mysqli php-openssl php-xml php-zip php-fpm
RUN mkdir /www \
    && wget https://wordpress.org/latest.tar.gz \
    && tar -xzvf latest.tar.gz \
    && mv wordpress /www \
    && rm -rf latest.tar.gz \
    && mv /www/wordpress/wp-config-sample.php /www/wordpress/wp-config.php

COPY ./srcs/wp-config.php /www/wordpress/wp-config.php

EXPOSE 5000