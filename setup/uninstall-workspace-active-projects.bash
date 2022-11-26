#!/bin/bash

ACTIVE_PROJECT_LIST_PATH=$HOME/Yandex.Disk/deploy

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
