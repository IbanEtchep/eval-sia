FROM debian:latest

#Installation lamp
RUN apt update && apt install -y \
    apache2 \
    php8.2 \
    libapache2-mod-php \
    php-mysql \
    mariadb-server \
    vsftpd

# Ajouter l'utilisateur et créer son dossier web
ARG USERNAME=user
RUN useradd -m $USERNAME

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Exposer le port 80
EXPOSE 80

# démarrer apache et mariadb et empêcher que le conteneur s'arrête
CMD service apache2 start && service mariadb start && service vsftpd start && tail -f /dev/null

ENTRYPOINT ["/entrypoint.sh"]