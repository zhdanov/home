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
#    zip -r git-store.zip git-store
#    mv git-store.zip data-store/gitlab-prod/
popd

# backup cloned
mkdir -p /tmp/backup-git-store
pushd /tmp/backup-git-store
    for repo in `ls /home/$HOME_USER_NAME/git-store`; do git clone /home/$HOME_USER_NAME/git-store/$repo; done
    for repo in `ls /home/$HOME_USER_NAME/git-store`; do repo_dir="${repo::-4}" && zip -r $repo_dir.zip $repo_dir; done

    for clouddir in "${CLOUD_DIR_LIST[@]}"
    do
        cp *.zip /home/$HOME_USER_NAME/$clouddir/backup/git-store-cloned/
    done
popd
rm -rf /tmp/backup-git-store
