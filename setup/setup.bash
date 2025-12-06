#!/bin/bash

# ↓ setup__master
# ↓ setup__slave
# ↓ setup__ctr_debian.bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

pushd "$SCRIPT_DIR" > /dev/null

    set +eux
    . setup_def.bash
    set -eux

    # dotfiles
    . setup__bashrc.bash
    . setup__configure-gitconfig.bash
    . setup__configure-vim.bash

    # soft
    . setup__packages.bash

    # configs
    . setup__configure-ssh.bash
    . setup__configure-dns.bash
popd > /dev/null
