#!/bin/bash
cd "$(dirname "$0")"

. $(multiwerf use 1.1 stable --as-file)

. setup_def.bash

for namespace in `ls $HOME/workspace`; do
    for appname in `ls $HOME/workspace/$namespace`; do
        pushd $HOME/workspace/$namespace/$appname
            werf stages purge --force --stages-storage=:local
        popd
    done
done
