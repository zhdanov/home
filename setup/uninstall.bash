#!/bin/bash
pushd "$(dirname "$0")"

    ./uninstall-purge.bash
    ./uninstall-workspace-active-projects.bash

    minikube stop
    minikube delete
    pkill -f minikube

popd
