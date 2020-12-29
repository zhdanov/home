#!/bin/bash
cd "$(dirname "$0")"

if [[ $# -ne 2 ]]; then
    echo "./setup/setup__werf-build.bash namespace project"
    exit 0
fi

. $(multiwerf use 1.1 stable --as-file)

NAMESPACE=$1
APP=$2

pushd $HOME/workspace/$1/$2
    werf build --stages-storage :local --introspect-error=true --log-debug=true --log-verbose=true
popd
