#!/bin/bash
cd "$(dirname "$0")"

if [[ $# -ne 2 ]]; then
    echo "./setup/setup__werf-lint.bash environment project"
    exit 0
fi

. $(multiwerf use 1.1 stable --as-file)

ENVIRONMENT=$1
APP=$2
TAG=0.1

pushd $HOME/workspace/$ENVIRONMENT/$APP
    werf helm lint --env $ENVIRONMENT
    werf helm render --tag-custom $TAG --env $ENVIRONMENT
popd
