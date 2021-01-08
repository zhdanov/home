#!/bin/bash

sudo sed -i -e '/^.*gitlab-prod\.loc.*$/d' /etc/hosts
echo `minikube ip`" gitlab-prod.loc" | sudo tee -a /etc/hosts


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
EOF
fi
