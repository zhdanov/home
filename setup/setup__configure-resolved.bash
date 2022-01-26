#!/bin/bash

if grep -q "#DNS=" /etc/systemd/resolved.conf; then
    echo "set DNS in /etc/systemd/resolved.conf"
    sudo sed -i "/.*#DNS=.*/c\DNS=8.8.4.4 8.8.8.8 2001:4860:4860::8844 2001:4860:4860::8888" /etc/systemd/resolved.conf

    sudo systemctl restart systemd-resolved
fi
