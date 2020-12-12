#!/bin/bash

[[ ! -d $HOME/bin ]] && mkdir $HOME/bin

if [[ ! -f "$HOME/bin/multiwerf" ]]; then
    pushd $HOME/bin
        curl -L https://raw.githubusercontent.com/werf/multiwerf/master/get.sh | bash
    popd
fi
