#!/bin/bash

[[ ! -d $HOME/bin ]] && mkdir $HOME/bin

if [[ ! -f "$HOME/bin/trdl" ]]; then
    pushd $HOME/bin
        curl -sSLO https://werf.io/install.sh && chmod +x install.sh
        ./install.sh --version 1.2 --channel stable
    popd
fi
