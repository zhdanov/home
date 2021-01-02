#!/bin/bash

if [[ ! -f "/etc/apt/sources.list.d/google-chrome.list" ]]; then
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

    sudo apt -y install ./google-chrome-stable_current_amd64.deb

    rm google-chrome-stable_current_amd64.deb
fi
