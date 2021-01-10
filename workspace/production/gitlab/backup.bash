#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "usage:"
    echo "./backup.bash user"
    exit 0
fi

HOME_USER_NAME=$1

if kubectl -n gitlab-prod get statefulsets.apps | grep -q gitlab-prod; then
    kubectl -n gitlab-prod exec -it gitlab-prod-0 -c gitlab -- gitlab-backup create BACKUP=prod CRON=1
    mv /home/$HOME_USER_NAME/data-store/gitlab-prod/gitlab-data/backups/prod_gitlab_backup.tar /home/$HOME_USER_NAME/data-store/gitlab-prod/
fi
