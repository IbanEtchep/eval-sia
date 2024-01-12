#!/bin/bash

if [ ! -d "/var/www/html/Lascoumoune/$USERNAME" ]; then
    mkdir -p /var/www/html/Lascoumoune/$USERNAME
    chown -R $USERNAME:$USERNAME /var/www/html/Lascoumoune/$USERNAME
fi

service apache2 start
service mariadb start
service vsftpd start

# Empêcher le conteneur de s'arrêter
tail -f /dev/null