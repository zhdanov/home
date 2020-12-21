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

    # registry
    export REGISTRY_IP=$(kubectl -n kube-system get service registry -o=template={{.spec.clusterIP}})
    minikube ssh "cat /etc/hosts | grep -v werf-registry | sudo tee /etc/hosts"
    minikube ssh "echo '$REGISTRY_IP $HOME_REGISTRY' | sudo tee -a /etc/hosts"

    kubectl -n kube-system wait --for=condition=ready --timeout=120s pods -l app.kubernetes.io/component=controller
else
    eval $(ssh-agent -s)
    ssh-add

    minikube config set cpus $HOME_MINIKUBE_CPU
    minikube config set memory $HOME_MINIKUBE_MEM
    minikube start --addons registry --addons metrics-server --addons ingress --addons dashboard --driver=docker --mount-string "$SSH_AUTH_SOCK:/ssh-agent"

    kubectl config use-context minikube

    kubectl wait --for=condition=available --timeout=120s --all deployments -A
    kubectl -n kube-system wait --for=condition=ready --timeout=120s pods -l actual-registry=true
    kubectl -n kube-system wait --for=condition=ready --timeout=120s pods -l registry-proxy=true
    kubectl -n kube-system wait --for=condition=ready --timeout=120s pods -l app.kubernetes.io/component=controller

    cat <<EOF | kubectl --namespace kube-system apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: registry-ingress
  annotations:
    kubernetes.io/ingress.class: "nginx"
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
    ingress.kubernetes.io/rewrite-target: /
    nginx.ingress.kubernetes.io/proxy-body-size: "4096m"
spec:
  rules:
  - host: "$HOME_REGISTRY"
    http:
      paths:
      - pathType: Prefix
        path: /
        backend:
          service:
            name: "registry"
            port:
              number: 80
EOF

    export REGISTRY_IP=$(kubectl -n kube-system get service registry -o=template={{.spec.clusterIP}})

    minikube ssh "cat /etc/hosts | grep -v werf-registry | sudo tee /etc/hosts"
    minikube ssh "echo '$REGISTRY_IP $HOME_REGISTRY' | sudo tee -a /etc/hosts"

    sudo sed -i -e '/^.*werf-registry.*$/d' /etc/hosts
    echo `minikube ip`" $HOME_REGISTRY" | sudo tee -a /etc/hosts

    # nfs host
    sudo sed -i -e '/^.*data-store.*$/d' /etc/exports
    echo "$HOME/data-store "`minikube ip`"(rw,sync,no_root_squash,no_subtree_check)" | sudo tee -a /etc/exports

    sudo systemctl restart nfs-kernel-server

    cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: PersistentVolume
metadata:
  name: nfs-pv-data-store
spec:
  storageClassName: manual
  capacity:
    storage: 200Gi
  accessModes:
    - ReadWriteMany
  persistentVolumeReclaimPolicy: Retain
  nfs:
    server: host.minikube.internal
    path: $HOME/data-store
EOF

    # nfs client (example)
    #minikube ssh "sudo mkdir /data-store"
    #minikube ssh "sudo mount host.minikube.internal:$HOME/data-store /data-store"
    #minikube ssh "cat /etc/fstab | grep -v data-store | sudo tee /etc/fstab"
    #minikube ssh "echo 'host.minikube.internal:$HOME/data-store    /nfs/home    nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0' | sudo tee -a /etc/fstab"

    kubectl -n kube-system wait --for=condition=ready --timeout=120s pods -l app.kubernetes.io/component=controller
fi
