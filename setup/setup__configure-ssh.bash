#!/bin/bash

if [[ $SETUP_TYPE == "master" ]]; then
    if grep -q "#Port 22" /etc/ssh/sshd_config; then
        echo "changed ssh port to $HOME_SSH_PORT in /etc/ssh/sshd_config"
        sudo sed -i "/.*#Port 22.*/c\Port $HOME_SSH_PORT" /etc/ssh/sshd_config
    fi
fi

if grep -q "#PermitRootLogin" /etc/ssh/sshd_config; then
    echo "set PermitRootLogin no in /etc/ssh/sshd_config"
    sudo sed -i "/.*#PermitRootLogin.*/c\PermitRootLogin no" /etc/ssh/sshd_config
fi
