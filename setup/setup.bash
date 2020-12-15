#!/bin/bash
set -eux
cd "$(dirname "$0")"

./setup__dotfiles.bash
./setup__workspace.bash
./setup__development.bash
