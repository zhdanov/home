#!/bin/bash
cd "$(dirname "$0")"

if [[ $# -ne 2 ]]; then
    echo "./setup/setup__werf-lint.bash namespace project"
    exit 0
fi

. $(multiwerf use 1.1 stable --as-file)

NAMESPACE=$1
APP=$2
TAG=0.1

pushd $HOME/workspace/$1/$2
    werf helm lint --env $NAMESPACE --set ci_url=$CI_URL
    werf helm render --tag-custom $TAG --env $NAMESPACE
popd
