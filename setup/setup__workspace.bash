#!/bin/bash

. setup_def.bash
. setup__shortenv-func.bash
. setup__packages.bash

. setup__configure-ssh.bash
. setup__configure-laptop.bash
. setup__configure-vim.bash

. setup__kubernetes.bash
. setup__helm.bash
. setup__minikube.bash
. setup__werf.bash
. setup__backup.bash

./setup__workspace-deploy.bash
