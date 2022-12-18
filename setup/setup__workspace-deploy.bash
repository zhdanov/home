#!/bin/bash

if [[ "$#" < 2 ]]; then
    echo "usage:"
    echo "~/setup/setup__workspace-deploy.bash env project"
    echo "or"
    echo "~/setup/setup__workspace-deploy.bash env project --purge"
    exit 0
fi

ENVIRONMENT=$1
APPNAME=$2
PURGE=0

while [[ "$#" -gt 2 ]]; do
    case $3 in
        -p|--purge) PURGE=1; shift ;;
        *) echo "Unknown parameter passed: $3"; exit 1 ;;
    esac
    shift
done

pushd "$(dirname "$0")"

    . setup_def.bash
    . setup__minikube-pv.bash
    ./setup__workspace-active-projects.bash

    kubectl config use-context $HOME_KUBECONTEXT

    TAG=`echo -n "$(date)" | md5sum | awk '{print $1}'`

    export environment=$ENVIRONMENT
    export appname=$APPNAME
    export HOME_USER_NAME=$HOME_USER_NAME

    pushd $HOME/workspace/$environment/$appname

        if [[ -d "./.git" ]]; then
            if [ $environment == "prod" ]; then
                if git show-ref -q --heads main; then
                    git checkout main
                fi
                if git show-ref -q --heads master; then
                    git checkout master
                fi
            fi

            if [ $environment == "dev" ]; then
                if git show-ref -q --heads develop; then
                    git checkout develop
                fi
            fi
        fi

        # hakunamatata builds
        for repo in `grep hakunamatata werf.yaml`; do \
            repo=${repo#*from:} && [[ "$repo" != "" ]] && res=`docker pull $repo > /dev/null && echo 0 || echo 1` && [[ $res == 1 ]] && \
            repo_dir=${repo%_latest} && repo_dir=${repo_dir#*:} && [[ "$repo_dir" != "" ]] && pushd $HOME/develop/hakunamatata/werf-builds/$repo_dir && \
            werf build --kube-config=$HOME_KUBECONFIG --env=$environment \
            --add-custom-tag=%image%_latest \
            --parallel=false \
            --insecure-registry=true \
            --skip-tls-verify-registry=true \
            --repo=$HOME_REGISTRY/hakunamatata \
            && popd \
        ; done

        if [[ -f "./.helm/predeploy.bash" ]]; then
            ./.helm/predeploy.bash
        fi

        if [[ $PURGE == 1 ]]; then
            werf cleanup --kube-config=$HOME_KUBECONFIG --env=$environment \
            --insecure-registry=true \
            --skip-tls-verify-registry=true \
            --repo=$HOME_REGISTRY/$appname || echo "local" > /dev/null

            werf purge --kube-config=$HOME_KUBECONFIG --env=$environment \
            --insecure-registry=true \
            --skip-tls-verify-registry=true \
            --repo=$HOME_REGISTRY/$appname || echo "local" > /dev/null
        fi

        werf converge --kube-config=$HOME_KUBECONFIG --env=$environment \
        --set HOME_USER_NAME=$HOME_USER_NAME \
        --parallel=false \
        --insecure-registry=true \
        --skip-tls-verify-registry=true \
        --repo=$HOME_REGISTRY/$appname || echo "local" > /dev/null

        sudo sed -i -e "/^.*$appname-$environment\.loc.*$/d" /etc/hosts
        echo `minikube ip`" $appname-$environment.loc" | sudo tee -a /etc/hosts

        if [[ -f "./.helm/postdeploy.bash" ]]; then
            ./.helm/postdeploy.bash
        fi
    popd

    echo "==== host ===="
    echo `minikube ip`" $appname-$environment.loc"

popd
