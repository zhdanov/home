#!/bin/bash

#
# Copy backup file (production-gitlab-backup.tar) to /var/opt/gitlab/backups/prod_gitlab_backup.tar
#

BACKUP_NAME=prod

if kubectl -n gitlab-prod get statefulsets.apps | grep -q gitlab-prod; then
    kubectl -n gitlab-prod exec -it gitlab-prod-0 -c gitlab -- gitlab-ctl stop unicorn
    kubectl -n gitlab-prod exec -it gitlab-prod-0 -c gitlab -- gitlab-ctl stop puma
    kubectl -n gitlab-prod exec -it gitlab-prod-0 -c gitlab -- gitlab-ctl stop sidekiq

    sleep 5

    kubectl -n gitlab-prod exec -it gitlab-prod-0 -c gitlab -- chown -R git:root /var/opt/gitlab/backups
    kubectl -n gitlab-prod exec -it gitlab-prod-0 -c gitlab -- gitlab-backup restore BACKUP=$BACKUP_NAME

    sleep 5
 
    kubectl -n gitlab-prod exec -it gitlab-prod-0 -c gitlab -- /sbin/killall5
fi
