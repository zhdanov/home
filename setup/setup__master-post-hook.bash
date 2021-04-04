#!/bin/bash

if [[ -f "/etc/apt/sources.list.d/yandex-disk.list" ]]; then
    yandex-disk start
fi

sudo swapoff -a && sudo swapon -a
