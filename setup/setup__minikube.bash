#!/bin/bash

if [[ ! -f "/usr/bin/minikube" ]]; then
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
    sudo dpkg -i minikube_latest_amd64.deb
    rm minikube_latest_amd64.deb
fi

unset KUBECONFIG
if [ $(minikube status | grep Running | wc -l) -gt 0 ]; then
    echo "minikube is already started"
elif docker ps -a | grep -q minikube; then
    echo "starting existing minikube"

    minikube start

    export REGISTRY_IP=$(kubectl -n kube-system get service registry -o=template={{.spec.clusterIP}})
    minikube ssh "cat /etc/hosts | grep -v werf-registry | sudo tee /etc/hosts"
    minikube ssh "echo '$REGISTRY_IP $HOME_REGISTRY' | sudo tee -a /etc/hosts"

    kubectl wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=120s
else

    [ $(ps aux | grep ssh-agent | wc -l) -eq 0 ] &&
    eval `ssh-agent -s` &&
    ssh-add

    CHECK_AUTH_SOCK=SSH_AUTH_SOCK
    [ ! -z ${CHECK_AUTH_SOCK} ] &&
    eval `ssh-agent -s` &&
    ssh-add

    minikube config set cpus $HOME_MINIKUBE_CPU
    minikube config set memory $HOME_MINIKUBE_MEM
    minikube start --addons registry --addons metrics-server --addons ingress --addons dashboard --driver=docker --mount-string "$SSH_AUTH_SOCK:/ssh-agent" --mount

    kubectl config use-context minikube

    kubectl wait --for=condition=available --timeout=120s --all deployments -A
    kubectl -n kube-system wait --for=condition=ready --timeout=120s pods -l actual-registry=true
    kubectl -n kube-system wait --for=condition=ready --timeout=120s pods -l registry-proxy=true
    kubectl wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=120s

    . setup__minikube-ingress.bash

    for environment in `ls $HOME/workspace`; do
        for appname in `ls $HOME/workspace/$environment`; do

            if ! kubectl get namespaces | grep -q "$appname-$environment"
            then
                kubectl create namespace "$appname-$environment"
            fi
        done
    done

    export REGISTRY_IP=$(kubectl -n kube-system get service registry -o=template={{.spec.clusterIP}})

    minikube ssh "cat /etc/hosts | grep -v werf-registry | sudo tee /etc/hosts"
    minikube ssh "echo '$REGISTRY_IP $HOME_REGISTRY' | sudo tee -a /etc/hosts"

    sudo sed -i -e '/^.*werf-registry.*$/d' /etc/hosts
    echo `minikube ip`" $HOME_REGISTRY" | sudo tee -a /etc/hosts

    . setup__minikube-pv.bash

    kubectl wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=120s
fi
