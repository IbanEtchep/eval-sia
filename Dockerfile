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
RUN useradd -m $USERNAME \
    && mkdir -p /var/www/html/Lascoumoune/$USERNAME \
    && chown -R $USERNAME:$USERNAME /var/www/html/Lascoumoune/$USERNAME

# Exposer le port 80
EXPOSE 80

# démarrer apache et mariadb et empêcher que le conteneur s'arrête
CMD service apache2 start && service mariadb start && service vsftpd start && tail -f /dev/null