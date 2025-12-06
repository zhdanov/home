#!/bin/bash

if grep -q "#Port 22" /etc/ssh/sshd_config; then
    echo "changed ssh port to $HOME_SSH_PORT in /etc/ssh/sshd_config"
    sudo sed -i "/.*#Port 22.*/c\Port $HOME_SSH_PORT" /etc/ssh/sshd_config
fi

if grep -q "#ClientAliveInterval" /etc/ssh/sshd_config; then
    echo "changed ClientAliveInterval in /etc/ssh/sshd_config"
    sudo sed -i "/.*#ClientAliveInterval.*/c\ClientAliveInterval 30" /etc/ssh/sshd_config
fi

if grep -q "#TCPKeepAlive" /etc/ssh/sshd_config; then
    echo "changed TCPKeepAlive in /etc/ssh/sshd_config"
    sudo sed -i "/.*#TCPKeepAlive.*/c\TCPKeepAlive yes" /etc/ssh/sshd_config
fi

if grep -q "#ClientAliveCountMax" /etc/ssh/sshd_config; then
    echo "changed ClientAliveCountMax in /etc/ssh/sshd_config"
    sudo sed -i "/.*#ClientAliveCountMax.*/c\ClientAliveCountMax 99999" /etc/ssh/sshd_config
fi

if ! grep -q "Host github" /etc/ssh/ssh_config; then
    printf "Host github.com\n\tStrictHostKeyChecking no\n\tUserKnownHostsFile=/dev/null\n" | sudo tee -a /etc/ssh/ssh_config
fi
