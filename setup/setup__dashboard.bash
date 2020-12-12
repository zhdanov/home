#!/bin/bash
cd "$(dirname "$0")"

. ./setup_def.bash

kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep "$HOME_USER_NAME" | awk '{print $1}')
echo ""
echo "http://127.0.0.1:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/"
echo ""
echo "ssh -p 8006 -L 8001:127.0.0.1:8001 \$HOME_SSH_HOST (setup/setup_def.bash)"
echo ""

kubectl proxy
