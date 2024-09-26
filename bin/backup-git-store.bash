#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "usage:"
    echo "$0 username"
    exit 0
fi

CLOUD_DIR_LIST=(
Yandex.Disk
Dropbox
)

# backup bare
HOME_USER_NAME=$1
pushd /home/$HOME_USER_NAME/
    tar -cvf git-store.tar git-store
    mv git-store.tar data-store/gitlab-prod/
popd

# backup cloned
mkdir -p /tmp/backup-git-store
pushd /tmp/backup-git-store
    for repo in `ls /home/$HOME_USER_NAME/git-store`; do git clone /home/$HOME_USER_NAME/git-store/$repo; done
    for repo in `ls /home/$HOME_USER_NAME/git-store`; do repo_dir="${repo::-4}" && tar -cvjf $repo_dir.tar.bz2 $repo_dir; done

    for clouddir in "${CLOUD_DIR_LIST[@]}"
    do
        cp *.tar.bz2 /home/$HOME_USER_NAME/$clouddir/backup/git-store-cloned/
    done
popd
rm -rf /tmp/backup-git-store
