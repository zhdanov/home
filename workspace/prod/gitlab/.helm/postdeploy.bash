#!/bin/bash

if [[ ! -d "$HOME/.ssh" ]]; then
    mkdir $HOME/.ssh
fi

if [[ ! -f "$HOME/.ssh/config" ]]; then
    touch $HOME/.ssh/config
    chmod 600 $HOME/.ssh/config
fi

if ! grep -q "Host gitlab-prod" $HOME/.ssh/config; then
    cat <<EOF | sudo tee $HOME/.ssh/config
Host gitlab-prod.loc
    Port 2222
Host gitlab-prod.gitlab-prod
    Port 2222
EOF
fi

if ! grep -q "gitlab-prod.gitlab-prod" /etc/hosts; then
    cat <<EOF | sudo tee -a /etc/hosts
192.168.49.2 gitlab-prod.gitlab-prod
EOF
fi
