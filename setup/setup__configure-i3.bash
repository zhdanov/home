#!/bin/bash

if grep -q "%HOME_USER_NAME%" $HOME/.config/i3/config; then
    echo "changed %HOME_USER_NAME% to $HOME_USER_NAME in .config/i3/config"
    sed -i "s/%HOME_USER_NAME%/$HOME_USER_NAME/" $HOME/.config/i3/config
fi
