#!/bin/bash
cd "$(dirname "$0")"

. setup_def.bash
. setup__packages.bash
. setup__nodejs.bash
. setup__commitizen.bash

. setup__configure-ssh.bash
. setup__configure-laptop.bash

. setup__kubernetes.bash
. setup__helm.bash
. setup__minikube.bash
. setup__werf.bash