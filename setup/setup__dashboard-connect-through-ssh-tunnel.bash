#!/bin/bash
cd "$(dirname "$0")"

. ./setup_def.bash

if ! ps ax | grep ssh | grep -q "$HOME_MINIKUBE_DASHBOARD_PORT:"; then
    ssh -p $HOME_SSH_PORT -L $HOME_MINIKUBE_DASHBOARD_PORT:127.0.0.1:$HOME_MINIKUBE_DASHBOARD_PORT -f -C -q -N $HOME_USER_NAME@$HOME_SSH_HOST
fi

xdg-open http://127.0.0.1:$HOME_MINIKUBE_DASHBOARD_PORT/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/
