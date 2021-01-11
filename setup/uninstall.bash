#!/bin/bash
pushd "$(dirname "$0")"

    ./uninstall-purge.bash

    minikube delete
    pkill -f minikube

popd
