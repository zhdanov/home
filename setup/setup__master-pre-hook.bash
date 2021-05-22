#!/bin/bash

if ps ax | grep -v "grep" | grep -q "yandex-disk"; then
    yandex-disk stop
fi

sudo systemctl stop gdm3
sudo systemctl stop cups-browsed
sudo systemctl stop ModemManager
sudo systemctl stop supervisor
sudo systemctl stop cups
