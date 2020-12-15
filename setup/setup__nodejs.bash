#!/bin/bash
sudo npm i -g npm n grunt

if [[ $(node --version) != "v$HOME_NODEJS_VERSION" ]]; then
    sudo n $HOME_NODEJS_VERSION
fi
