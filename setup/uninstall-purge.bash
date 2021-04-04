#!/bin/bash
pushd "$(dirname "$0")"

    . $(multiwerf use 1.1 stable --as-file)

    . setup_def.bash

    for environment in `ls $HOME/workspace`; do
        for appname in `ls $HOME/workspace/$environment`; do
            pushd $HOME/workspace/$environment/$appname
                export environment=$environment
                export appname=$appname
                werf stages purge --force --stages-storage=:local
            popd
        done
    done

    werf host cleanup
    werf host purge

popd
