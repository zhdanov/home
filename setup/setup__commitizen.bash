#!/bin/bash
set -eux

pushd "$(dirname "$0")"
    . setup__nodejs.bash
    sudo npm install commitizen -g
popd
