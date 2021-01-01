#!/bin/bash
set -eux
cd "$(dirname "$0")"

. $(multiwerf use 1.1 stable --as-file)

. setup_def.bash

kubectl config use-context $HOME_KUBECONTEXT

TAG=`echo -n "$(date)" | md5sum | awk '{print $1}'`

for namespace in `ls $HOME/workspace`; do
    for appname in `ls $HOME/workspace/$namespace`; do
        pushd $HOME/workspace/$namespace/$appname
            werf build-and-publish --kube-config=$HOME_KUBECONFIG --stages-storage :local \
            --images-repo-implementation='harbor' \
            --insecure-registry=true \
            --skip-tls-verify-registry=true \
            -i=$HOME_REGISTRY/$appname \
            --tag-custom $TAG || echo "local" > /dev/null

            werf deploy --kube-config=$HOME_KUBECONFIG --env=$namespace --stages-storage :local \
            --images-repo-implementation='harbor' --insecure-registry=true \
            --skip-tls-verify-registry=true -i=$HOME_REGISTRY/$appname \
            --tag-custom $TAG || echo "local" > /dev/null
        popd
    done
done
