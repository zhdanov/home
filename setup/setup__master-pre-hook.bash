#!/bin/bash

if [[ -f "/etc/apt/sources.list.d/yandex-disk.list" ]]; then
    yandex-disk stop
fi

sudo systemctl stop gdm3
sudo systemctl stop cups-browsed
sudo systemctl stop ModemManager
sudo systemctl stop supervisor
sudo systemctl stop cups
