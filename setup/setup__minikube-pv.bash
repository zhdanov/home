#!/bin/bash

sudo sed -i -e '/^.*data-store.*$/d' /etc/exports

for environment in `ls $HOME/workspace`; do
    for appname in `ls $HOME/workspace/$environment`; do

        if [[ ! -d "$HOME/data-store/$appname-$environment" ]]; then
            mkdir -p "$HOME/data-store/$appname-$environment"
        fi
        echo "$HOME/data-store/$appname-$environment "`minikube ip`"(rw,sync,no_root_squash,no_subtree_check)" | sudo tee -a /etc/exports

    done
done

sudo systemctl restart nfs-kernel-server

for environment in `ls $HOME/workspace`; do
    for appname in `ls $HOME/workspace/$environment`; do

        if ! kubectl get namespaces | grep -q "$appname-$environment"
        then
            kubectl create namespace "$appname-$environment"
        fi

        if ! kubectl --namespace $appname-$environment get pv | grep -q "$appname-$environment"
        then
            cat <<EOF | kubectl --namespace $appname-$environment apply -f -
apiVersion: v1
kind: PersistentVolume
metadata:
  name: nfs-pv-$appname-$environment
spec:
  storageClassName: manual
  capacity:
    storage: $HOME_MINIKUBE_PV_SIZE
  accessModes:
    - ReadWriteMany
  persistentVolumeReclaimPolicy: Retain
  nfs:
    server: host.minikube.internal
    path: $HOME/data-store/$appname-$environment
EOF
        fi

        until kubectl -n "$appname-$environment" get pv | grep -q $appname-$environment; do sleep 1; done

        if ! kubectl --namespace $appname-$environment get pvc | grep -q "$appname-$environment"
        then
            cat <<EOF | kubectl --namespace $appname-$environment apply -f -
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: nfs-pvc-$appname-$environment
spec:
  storageClassName: manual
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: $HOME_MINIKUBE_PV_SIZE
  volumeName: "nfs-pv-$appname-$environment"
EOF
        fi

        until kubectl -n "$appname-$environment" get pvc | grep -q $appname-$environment; do sleep 1; done

    done
done


# mount example
#minikube ssh "sudo mkdir /data-store"
#minikube ssh "sudo mount host.minikube.internal:$HOME/data-store /data-store"
