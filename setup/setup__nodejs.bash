#!/bin/bash
sudo npm i -g npm n

if [[ $(node --version) != "v$HOME_NODEJS_VERSION" ]]; then
    sudo n $HOME_NODEJS_VERSION
fi
