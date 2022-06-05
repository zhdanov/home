#!/bin/bash
pushd "$(dirname "$0")"

    . setup_def.bash
    . setup__minikube-pv.bash

    kubectl config use-context $HOME_KUBECONTEXT

    TAG=`echo -n "$(date)" | md5sum | awk '{print $1}'`


    function deploy()
    {
        export environment=$1
        export appname=$2
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

            if [[ -f "./.helm/predeploy.bash" ]]; then
                ./.helm/predeploy.bash
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
    }


    if [[ $# -eq 2 ]]; then
        deploy $1 $2
        echo "==== /etc/hosts ===="
        echo `minikube ip`" $appname-$environment.loc"
    else
        deploy prod gitlab
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
                echo `minikube ip`" $appname-$fullenv.loc"
            done
        done
    fi

popd
