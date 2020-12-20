#!/bin/bash

. $(multiwerf use 1.1 stable --as-file)

pushd $HOME/workspace/production/skeleton/
    werf stages purge --force --stages-storage=:local
popd

minikube delete
pkill -f minikube
