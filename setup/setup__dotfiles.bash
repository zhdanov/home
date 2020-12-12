#!/bin/bash
cd "$(dirname "$0")"

. setup_def.bash
. setup__bashrc.bash
. setup__configure-gitconfig.bash
. setup__configure-i3.bash

source $HOME/.bashrc
