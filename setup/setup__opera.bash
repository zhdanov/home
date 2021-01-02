#!/bin/bash

if ! grep -q "opera-stable" /etc/apt/sources.list; then
    wget -qO- https://deb.opera.com/archive.key | sudo apt-key add -
    sudo add-apt-repository "deb [arch=i386,amd64] https://deb.opera.com/opera-stable/ stable non-free"
    sudo apt install -y opera-stable
fi
