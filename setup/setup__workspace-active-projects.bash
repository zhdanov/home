#!/bin/bash

if [[ ! -d "$HOME/develop" ]]; then
    mkdir $HOME/develop
fi

ACTIVE_PROJECT_LIST_PATH=$HOME/Yandex.Disk/active-project-list

if [[ -d "$ACTIVE_PROJECT_LIST_PATH" ]]; then
    for repo in `ls $ACTIVE_PROJECT_LIST_PATH`; do
        if [[ -f "$ACTIVE_PROJECT_LIST_PATH/$repo/namespace-list.txt" ]]; then
            for namespace in `cat $ACTIVE_PROJECT_LIST_PATH/$repo/namespace-list.txt`; do
                if [ ! -h "$HOME/workspace/$namespace/$repo" ] && [ -f $ACTIVE_PROJECT_LIST_PATH/$repo/werf.yaml ]; then
                    ln -s $ACTIVE_PROJECT_LIST_PATH/$repo $HOME/workspace/$namespace/$repo
                fi

                if [[ ! -h "$HOME/develop/$repo" ]]; then
                    ln -s $ACTIVE_PROJECT_LIST_PATH/$repo $HOME/develop/$repo
                fi
            done
        fi
    done
fi
