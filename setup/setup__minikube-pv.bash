#!/bin/bash

sudo sed -i -e '/^.*data-store.*$/d' /etc/exports

for namespace in "${NAMESPACE_LIST[@]}"
do
    echo "$HOME/data-store/$namespace "`minikube ip`"(rw,sync,no_root_squash,no_subtree_check)" | sudo tee -a /etc/exports
done

sudo systemctl restart nfs-kernel-server

for namespace in "${NAMESPACE_LIST[@]}"
do
    cat <<EOF | kubectl --namespace $namespace apply -f -
apiVersion: v1
kind: PersistentVolume
metadata:
  name: nfs-pv-$namespace
spec:
  storageClassName: manual
  capacity:
    storage: $HOME_MINIKUBE_PV_SIZE
  accessModes:
    - ReadWriteMany
  persistentVolumeReclaimPolicy: Retain
  nfs:
    server: host.minikube.internal
    path: $HOME/data-store/$namespace
EOF

    cat <<EOF | kubectl --namespace $namespace apply -f -
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: nfs-pvc-$namespace
spec:
  storageClassName: manual
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: $HOME_MINIKUBE_PV_SIZE
  volumeName: "nfs-pv-$namespace"
EOF

done

# mount example
#minikube ssh "sudo mkdir /data-store"
#minikube ssh "sudo mount host.minikube.internal:$HOME/data-store /data-store"
