#!/bin/bash

if ! grep -q ". .bashrc_home" $HOME/.bashrc; then
    echo "added .bashrc_home to .bashrc"
    echo ". .bashrc_home" >> $HOME/.bashrc
fi
