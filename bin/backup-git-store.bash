#!/bin/bash
pushd /home/$USER/
    zip -r git-store.zip git-store
    mv git-store.zip data-store/gitlab-prod/
popd
