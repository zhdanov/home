#!/bin/bash
cd "$(dirname "$0")"

. ./setup_def.bash

echo "Get command for ssh tunnel:"
echo "./setup/setup__dashboard-show-ssh-tunnel-command.bash %port%"
echo ""

minikube dashboard --url
