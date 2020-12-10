#!/bin/bash
cd "$(dirname "$0")"

./setup__dotfiles.bash
. setup__workstation.bash
. setup__kubernetes.bash
. setup__minikube.bash
. setup__werf.bash
