FROM debian:latest

#Installation lamp
RUN apt update && apt install -y \
    apache2 \
    php8.2 \
    libapache2-mod-php \
    php-mysql \
    mariadb-server

# démarrer apache et mariadb et empêcher que le conteneur s'arrête
CMD service apache2 start && service mariadb start && tail -f /dev/null