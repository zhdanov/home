#!/bin/bash

if [[ ! $1 =~ ^(slave|master)$ ]]; then
    echo "usage:"
    echo "./setup/setup.bash slave"
    echo "./setup/setup.bash master"
    exit 0
else
    SETUP_TYPE=$1
fi

pushd "$(dirname "$0")"
    set -eux
    . ./setup__dotfiles.bash
    . ./setup__workspace.bash
popd

exec bash
