#!/bin/bash

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
sudo dpkg -i minikube_latest_amd64.deb
rm minikube_latest_amd64.deb

eval $(ssh-agent -s)
ssh-add

minikube start --addons registry --addons metrics-server --driver=docker --mount-string "$SSH_AUTH_SOCK:/ssh-agent" --cpus=$HOME_MINIKUBE_CPU --memory=$HOME_MINIKUBE_MEM
