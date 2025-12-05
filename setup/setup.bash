#!/bin/bash

if [[ ! $1 =~ ^(vbox|slave|master)$ ]]; then
    echo "usage:"
    echo "./setup/setup.bash vbox"
    echo "./setup/setup.bash slave"
    echo "./setup/setup.bash master"
    exit 1
else
    SETUP_TYPE=$1
fi

pushd "$(dirname "$0")"
    set +eux
    . setup_def.bash
    set -eux

    # dotfiles
    . setup__bashrc.bash
    . setup__configure-gitconfig.bash
    . setup__configure-i3.bash

    source $HOME/.bashrc

    # soft
    . setup__packages.bash

    # configs
    . setup__configure-ssh.bash
    . setup__configure-resolved.bash
    . setup__configure-laptop.bash
    . setup__configure-vim.bash
    . setup__configure-visudo.bash
    . setup__kubernetes.bash
popd
