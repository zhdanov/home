#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "usage:"
    echo "$0 username"
    exit 0
fi

HOME_USER_NAME=$1
pushd /home/$HOME_USER_NAME/
    zip -r git-store.zip git-store
    mv git-store.zip data-store/gitlab-prod/
popd
