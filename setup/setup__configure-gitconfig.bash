#!/bin/bash

if grep -q "%HOME_USER_NAME%" $HOME/.gitconfig; then
    echo "changed %HOME_USER_NAME% to $HOME_USER_NAME in .gitconfig"
    sed -i "s/%HOME_USER_NAME%/$HOME_USER_NAME/" $HOME/.gitconfig
fi

if grep -q "%HOME_USER_EMAIL%" $HOME/.gitconfig; then
    echo "changed %HOME_USER_EMAIL% to $HOME_USER_EMAIL in .gitconfig"
    sed -i "s/%HOME_USER_EMAIL%/$HOME_USER_EMAIL/" $HOME/.gitconfig
fi
