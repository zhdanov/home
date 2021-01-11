#!/bin/bash

set +eux
. setup_def.bash
set -eux
. setup__bashrc.bash
. setup__configure-gitconfig.bash
. setup__configure-i3.bash

source $HOME/.bashrc
