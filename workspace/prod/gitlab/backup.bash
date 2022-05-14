#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "usage:"
    echo "./backup.bash user"
    exit 0
fi

HOME_USER_NAME=$1
SERVICE_NAME=gitlab-prod

if kubectl -n $SERVICE_NAME get statefulsets.apps | grep -q $SERVICE_NAME; then
    if [[ $(dirname "$0") =~ (.*)/(.*)/(.*)$ ]]; then
        BACKUP_FILE_NAME="${BASH_REMATCH[2]}-${BASH_REMATCH[3]}-backup.tar"
        kubectl -n $SERVICE_NAME exec -it $SERVICE_NAME-0 -c gitlab-ce -- gitlab-backup create BACKUP=prod CRON=1
        mv /home/$HOME_USER_NAME/data-store/$SERVICE_NAME/gitlab-data/backups/prod_gitlab_backup.tar /home/$HOME_USER_NAME/data-store/$SERVICE_NAME/$BACKUP_FILE_NAME
    fi
fi
