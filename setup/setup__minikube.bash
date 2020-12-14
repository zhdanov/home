#!/bin/bash

if [[ ! -f "/usr/bin/minikube" ]]; then
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
    sudo dpkg -i minikube_latest_amd64.deb
    rm minikube_latest_amd64.deb
fi

unset KUBECONFIG
if [ $(minikube status | grep Running | wc -l) -gt 0 ]; then
    echo "minikube is already started"
else
    eval $(ssh-agent -s)
    ssh-add

    minikube config set cpus $HOME_MINIKUBE_CPU
    minikube config set memory $HOME_MINIKUBE_MEM
    minikube start --addons registry --addons metrics-server --driver=docker --mount-string "$SSH_AUTH_SOCK:/ssh-agent"
fi
