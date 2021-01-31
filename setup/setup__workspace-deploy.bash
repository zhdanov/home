#!/bin/bash
pushd "$(dirname "$0")"

    . $(multiwerf use 1.1 stable --as-file)

    . setup_def.bash
    . setup__shortenv-func.bash
    . setup__minikube-pv.bash

    kubectl config use-context $HOME_KUBECONTEXT

    TAG=`echo -n "$(date)" | md5sum | awk '{print $1}'`


    function deploy()
    {
        shortenv $1

        export environment=$shortenv
        export appname=$2
        export shortenv=$shortenv
        export HOME_USER_NAME=$HOME_USER_NAME

        pushd $HOME/workspace/$1/$appname
            if [[ -f "./.helm/predeploy.bash" ]]; then
                ./.helm/predeploy.bash
            fi

            werf build-and-publish --kube-config=$HOME_KUBECONFIG --stages-storage :local \
            --images-repo-implementation='harbor' \
            --insecure-registry=true \
            --skip-tls-verify-registry=true \
            -i=$HOME_REGISTRY/$appname \
            --tag-custom $TAG || echo "local" > /dev/null

            werf deploy --kube-config=$HOME_KUBECONFIG --env=$environment --stages-storage :local \
            --images-repo-implementation='harbor' --insecure-registry=true \
            --skip-tls-verify-registry=true -i=$HOME_REGISTRY/$appname \
            --tag-custom $TAG || echo "local" > /dev/null

            sudo sed -i -e "/^.*$appname-$shortenv\.loc.*$/d" /etc/hosts
            echo `minikube ip`" $appname-$shortenv.loc" | sudo tee -a /etc/hosts

            if [[ -f "./.helm/postdeploy.bash" ]]; then
                ./.helm/postdeploy.bash
            fi
        popd
    }


    if [[ $# -eq 2 ]]; then
        deploy $1 $2
        echo "==== /etc/hosts ===="
        shortenv $1
        echo `minikube ip`" $appname-$shortenv.loc"
    else
        deploy production gitlab
        for fullenv in `ls $HOME/workspace`; do
            for appname in `ls $HOME/workspace/$fullenv`; do
                if [ $appname != "gitlab" ]
                then
                    deploy $fullenv $appname
                fi
            done
        done

        echo "==== full /etc/hosts ===="
        for fullenv in `ls $HOME/workspace`; do
            for appname in `ls $HOME/workspace/$fullenv`; do
                shortenv $fullenv
                echo `minikube ip`" $appname-$shortenv.loc"
            done
        done
    fi

popd
