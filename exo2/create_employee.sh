#!/bin/bash

create_ftp_user() {
    local username=$1
    local password=$2
    local service=$3
    local service_group="service_$service"

    # Création du groupe s'il n'existe pas
    if ! getent group $service_group > /dev/null; then
        groupadd $service_group
    fi

    # Création de l'utilisateur et ajout au groupe
    useradd -m -g $service_group $username
    echo -e "$password\n$password" | passwd $username

    # Création du répertoire du service s'il n'existe pas
    if [ ! -d "/home/services/$service" ]; then
        mkdir -p /home/services/$service
        chown -R $username:$service_group /home/services/$service
    fi

    # Création du lien symbolique pour que l'utilisateur puisse accéder au dossier du service depuis son ftp
    ln -s /home/services/$service /home/$username/service

    # Gestion des permissions
    chown -R $username:$service_group /home/$username
    chmod -R g+rw /home/services/$service
}

create_ftp_user "nomutilisateur" "motdepasse" "ressources_humaines"
