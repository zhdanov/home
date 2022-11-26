#!/bin/bash

pushd "$(dirname "$0")"

    . ../setup/setup_def.bash
    if [[ -f "../setup/setup_def_custom.bash" ]]; then
        . ../setup/setup_def_custom.bash
    fi

    ACTIVE_PROJECT_LIST_PATH=$HOME_CLOUD_DIR/deploy

    if [[ -d "$ACTIVE_PROJECT_LIST_PATH" ]]; then
        for repo in `ls $ACTIVE_PROJECT_LIST_PATH`; do
            if [[ -f "$ACTIVE_PROJECT_LIST_PATH/$repo/namespace-list.txt" ]]; then
                for namespace in `cat $ACTIVE_PROJECT_LIST_PATH/$repo/namespace-list.txt`; do
                    if [[ -h "$HOME/workspace/$namespace/$repo" ]]; then
                        rm $HOME/workspace/$namespace/$repo
                    fi

                    if [[ -h "$HOME/develop/$repo" ]]; then
                        rm $HOME/develop/$repo
                    fi
                done
            fi
        done
    fi

popd
