#!/bin/bash

if ! grep -q "$HOME_USER_NAME" $HOME_PHP_FPM_CONF_FILE; then
    echo "changed defaults to $HOME_USER_NAME in $HOME_PHP_FPM_CONF_FILE"

    sudo sed -i "s/^user = www-data/user = $HOME_USER_NAME/" "$HOME_PHP_FPM_CONF_FILE"
    sudo sed -i "s/^group = www-data/group = $HOME_USER_NAME/" "$HOME_PHP_FPM_CONF_FILE"
fi

