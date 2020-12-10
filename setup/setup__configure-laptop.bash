#!/bin/bash

if grep -q "#HandleLidSwitch=" /etc/systemd/logind.conf; then
    echo "set HandleLidSwitch ignore in /etc/systemd/logind.conf"
    sudo sed -i "/.*#HandleLidSwitch=.*/c\HandleLidSwitch=ignore" /etc/systemd/logind.conf
fi
