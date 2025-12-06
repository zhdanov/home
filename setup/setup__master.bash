#!/bin/bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

pushd "$SCRIPT_DIR" > /dev/null

    . setup.bash

    . setup__configure-ssh_master.bash
    . setup__configure-laptop.bash

    . setup__i3-gui.bash
    . setup__configure-i3.bash

    . setup__incus.bash
    . setup__k8s-docker.bash

popd > /dev/null
