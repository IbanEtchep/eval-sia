FROM debian:latest

#Installation lamp
RUN apt update && apt install -y \
    apache2 \
    php8.2 \
    libapache2-mod-php \
    php-mysql \
    mariadb-server \
    vsftpd \
    wget \
    unzip

COPY /ftp/vsftpd.conf /etc/vsftpd.conf

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Exposer les ports
EXPOSE 80
EXPOSE 21

# démarrer apache et mariadb et empêcher que le conteneur s'arrête
CMD service apache2 start && service mariadb start && service vsftpd start && tail -f /dev/null

ENTRYPOINT ["/entrypoint.sh"]