#!/bin/bash

set +eux
. setup_def.bash
set -eux
. setup__packages.bash

. setup__configure-ssh.bash
. setup__configure-resolved.bash
. setup__configure-laptop.bash
. setup__configure-vim.bash
. setup__configure-visudo.bash
. setup__kubernetes.bash
. setup__helm.bash
. setup__minikube.bash
. setup__werf.bash
. setup__hakunamatata.bash

if [[ $SETUP_TYPE == "master" ]]; then

    . setup__minikube-start.bash
    ./setup__workspace-deploy.bash prod gitlab

fi
