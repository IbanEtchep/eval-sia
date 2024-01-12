#!/bin/bash

#création de l'utilisateur
useradd -m $USERNAME
echo "$USERNAME:$PASSWORD" | chpasswd

# Dossier web utilisateur
if [ ! -d "/var/www/html/Lascoumoune/$USERNAME" ]; then
    mkdir -p /var/www/html/Lascoumoune/$USERNAME
    chown -R $USERNAME:$USERNAME /var/www/html/Lascoumoune/$USERNAME
fi


# Télécharger et installer PHPMyAdmin
if [ ! -d "/var/www/html/phpmyadmin" ]; then
    wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.zip -O phpmyadmin.zip
    unzip phpmyadmin.zip -d /var/www/html
    mv /var/www/html/phpMyAdmin-*-all-languages /var/www/html/phpmyadmin
    rm phpmyadmin.zip
fi

service apache2 start
service mariadb start
service vsftpd start

# Empêcher le conteneur de s'arrêter
tail -f /dev/null