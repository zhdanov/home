#!/bin/bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

pushd "$SCRIPT_DIR" > /dev/null

    . setup.bash

echo "$(dirname "$0")"
echo "PWD = $PWD"
echo "Trying to source: $PWD/setup__configure-laptop.bash"
ls -l setup__configure-laptop.bash

    . setup__configure-laptop.bash
    . setup__configure-visudo.bash

    . setup__i3-gui.bash
    . setup__configure-i3.bash

    . setup__packages_slave.bash
    . setup__incus.bash
    . setup__k8s-docker.bash

popd > /dev/null
