#!/bin/bash
set -eux

pushd "$(dirname "$0")"
    npm install commitizen -g
    npm install -g commitizen cz-conventional-changelog && echo '{ "path": "cz-conventional-changelog" }' > ~/.czrc
popd
