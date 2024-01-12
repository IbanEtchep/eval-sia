FROM debian:latest

#Installation lamp
RUN apt update && apt install -y \
    apache2 \
    php8.2 \
    libapache2-mod-php \
    php-mysql \
    mariadb-server \
