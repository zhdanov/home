#!/bin/bash

if [[ -d "$HOME/Yandex.Disk/git-store" ]]; then
    for repo in `ls $HOME/Yandex.Disk/git-store`; do
        if [[ -f "$HOME/Yandex.Disk/git-store/$repo/namespace-list.txt" ]]; then
            for namespace in `cat $HOME/Yandex.Disk/git-store/$repo/namespace-list.txt`; do
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