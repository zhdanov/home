#!/bin/bash

if grep -q "#Port 22" /etc/ssh/sshd_config; then
    echo "changed ssh port to $HOME_SSH_PORT in /etc/ssh/sshd_config"
    sudo sed -i "/.*#Port 22.*/c\Port $HOME_SSH_PORT" /etc/ssh/sshd_config
fi

if grep -q "#PermitRootLogin" /etc/ssh/sshd_config; then
    echo "set PermitRootLogin no in /etc/ssh/sshd_config"
    sudo sed -i "/.*#PermitRootLogin.*/c\PermitRootLogin no" /etc/ssh/sshd_config
fi


if [[ ! -d "$HOME/.ssh" ]]; then
    mkdir $HOME/.ssh
fi

if [[ ! -f "$HOME/.ssh/config" ]]; then
    touch ~/.ssh/config
    chmod 600 ~/.ssh/config
    cat <<EOF | sudo tee $HOME/.ssh/config
Host gitlab.loc
    Port 2222
EOF
fi
