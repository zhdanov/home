#!/bin/bash

sudo sed -i -e '/^.*data-store.*$/d' /etc/exports

for environment in `ls $HOME/workspace`; do
    for appname in `ls $HOME/workspace/$environment`; do

        shortenv $environment

        if [[ ! -d "$HOME/data-store/$appname-$shortenv" ]]; then
            mkdir -p "$HOME/data-store/$appname-$shortenv"
        fi
        echo "$HOME/data-store/$appname-$shortenv "`minikube ip`"(rw,sync,no_root_squash,no_subtree_check)" | sudo tee -a /etc/exports

    done
done

sudo systemctl restart nfs-kernel-server

for environment in `ls $HOME/workspace`; do
    for appname in `ls $HOME/workspace/$environment`; do

        shortenv $environment

        if ! kubectl --namespace $appname-$shortenv get pv | grep -q "$appname-$shortenv"
        then
            cat <<EOF | kubectl --namespace $appname-$shortenv apply -f -
apiVersion: v1
kind: PersistentVolume
metadata:
  name: nfs-pv-$appname-$shortenv
spec:
  storageClassName: manual
  capacity:
    storage: $HOME_MINIKUBE_PV_SIZE
  accessModes:
    - ReadWriteMany
  persistentVolumeReclaimPolicy: Retain
  nfs:
    server: host.minikube.internal
    path: $HOME/data-store/$appname-$shortenv
EOF
        fi

        if ! kubectl --namespace $appname-$shortenv get pvc | grep -q "$appname-$shortenv"
        then
            cat <<EOF | kubectl --namespace $appname-$shortenv apply -f -
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: nfs-pvc-$appname-$shortenv
spec:
  storageClassName: manual
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: $HOME_MINIKUBE_PV_SIZE
  volumeName: "nfs-pv-$appname-$shortenv"
EOF
        fi
    done
done


# mount example
#minikube ssh "sudo mkdir /data-store"
#minikube ssh "sudo mount host.minikube.internal:$HOME/data-store /data-store"
