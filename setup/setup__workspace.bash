#!/bin/bash

set +eux
. setup_def.bash
set -eux
. setup__shortenv-func.bash
. setup__packages.bash

. setup__configure-ssh.bash
. setup__configure-laptop.bash
. setup__configure-vim.bash
. setup__configure-visudo.bash

if [[ $SETUP_TYPE == "master" ]]; then
    . setup__master-pre-hook.bash

    . setup__kubernetes.bash
    . setup__helm.bash
    . setup__minikube.bash
    . setup__werf.bash
    . setup__hakunamatata.bash
    ./setup__cloud-drive.bash
    . setup__backup.bash

    ./setup__workspace-active-projects.bash
    ./setup__workspace-deploy.bash

    . setup__master-post-hook.bash
fi
