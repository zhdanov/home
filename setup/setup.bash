#!/bin/bash
cd "$(dirname "$0")"

set -e

./setup__dotfiles.bash
./setup__workspace.bash
./setup__development.bash
