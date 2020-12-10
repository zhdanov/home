#!/bin/bash

mkdir $HOME/bin

pushd $HOME/bin
    curl -L https://raw.githubusercontent.com/werf/multiwerf/master/get.sh | bash
popd
