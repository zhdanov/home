#!/bin/bash
. $(multiwerf use 1.1 stable --as-file)

. setup_def.bash

# begin to automate
ENV=prod
TAG=0.3
pushd $HOME/workspace/production/skeleton
APPNAME=skeleton
# end to automate

kubectl config use-context $HOME_KUBECONTEXT

werf build-and-publish --kube-config=$HOME_KUBECONFIG --stages-storage :local \
--images-repo-implementation='harbor' \
--insecure-registry=true \
--skip-tls-verify-registry=true \
-i=$HOME_REGISTRY/$APPNAME \
--tag-custom $TAG || echo "local" > /dev/null

werf deploy --kube-config=$HOME_KUBECONFIG --env=$ENV --stages-storage :local \
--images-repo-implementation='harbor' --insecure-registry=true \
--skip-tls-verify-registry=true -i=$HOME_REGISTRY/$APPNAME \
--tag-custom $TAG || echo "local" > /dev/null

# begin to automate
popd
# end to automate
