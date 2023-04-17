#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "usage:"
    echo "./backup.bash user"
    exit 0
fi

HOME_USER_NAME=$1
SERVICE_NAME=albums-prod

if kubectl -n $SERVICE_NAME get statefulsets.apps | grep -q $SERVICE_NAME; then
    if [[ $(dirname "$0") =~ (.*)/(.*)/(.*)$ ]]; then
        BACKUP_FILE_NAME="${BASH_REMATCH[2]}-${BASH_REMATCH[3]}-backup.tar"

        kubectl -n $SERVICE_NAME exec -it $SERVICE_NAME-0 -c mariadb -- mysqldump -ulychee -plychee -h127.0.0.1 lychee > /home/$HOME_USER_NAME/data-store/$SERVICE_NAME/dump.sql

        pushd /home/$HOME_USER_NAME/data-store/$SERVICE_NAME/
            zip -r dump.zip dump.sql
            tar cvf $BACKUP_FILE_NAME dump.zip
            rm dump.zip dump.sql
        popd
    fi
fi

ARCHIVE_DIR=/home/$HOME_USER_NAME/Yandex.Disk/archive/albums
if [[ -d $ARCHIVE_DIR ]]; then
    pushd $ARCHIVE_DIR
        sudo cp -R /home/$HOME_USER_NAME/data-store/$SERVICE_NAME/albums-conf .
        sudo cp -R /home/$HOME_USER_NAME/data-store/$SERVICE_NAME/albums-sym .
        sudo cp -R /home/$HOME_USER_NAME/data-store/$SERVICE_NAME/albums-uploads .
        sudo chown -R $HOME_USER_NAME:$HOME_USER_NAME $ARCHIVE_DIR
    popd
fi
