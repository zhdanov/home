#!/bin/bash
pushd "$(dirname "$0")"

    if [[ $# -ne 2 ]]; then
        echo "./setup/setup__werf-build.bash environment project"
        exit 0
    fi

    . $(multiwerf use 1.1 stable --as-file)

    ENVIRONMENT=$1
    APP=$2

    pushd $HOME/workspace/$ENVIRONMENT/$APP
        werf build --stages-storage :local --introspect-error=true --log-debug=true --log-verbose=true
    popd

popd
