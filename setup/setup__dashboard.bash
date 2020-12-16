#!/bin/bash
cd "$(dirname "$0")"

. ./setup_def.bash

echo "Connect to dashboard throught ssh tunnel:"
echo "./setup/setup__dashboard-connect-through-ssh-tunnel.bash"
echo ""
echo "Url:"
echo "http://127.0.0.1:$HOME_MINIKUBE_DASHBOARD_PORT/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/"
echo ""

kubectl proxy -p $HOME_MINIKUBE_DASHBOARD_PORT
