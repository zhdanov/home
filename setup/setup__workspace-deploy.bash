#!/bin/bash
set -eux
cd "$(dirname "$0")"

. $(multiwerf use 1.1 stable --as-file)

. setup_def.bash

kubectl config use-context $HOME_KUBECONTEXT

TAG=`echo -n "$(date)" | md5sum | awk '{print $1}'`


function deploy()
{
    namespace=$1
    appname=$2

    pushd $HOME/workspace/$namespace/$appname
        if [[ -f "./.helm/predeploy.bash" ]]; then
            ./.helm/predeploy.bash
        fi

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

        if [[ -f "./.helm/postdeploy.bash" ]]; then
            ./.helm/postdeploy.bash
        fi
    popd
}


if [[ $# -eq 2 ]]; then
    deploy $1 $2
else
    for namespace in `ls $HOME/workspace`; do
        for appname in `ls $HOME/workspace/$namespace`; do
            deploy $namespace $appname
        done
    done
fi
