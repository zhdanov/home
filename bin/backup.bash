#!/bin/bash
#
# 1. Make file workspace/%namespace%/backup-list.txt
# 2. Cron by root:
# 30 4 * * * /home/%user%/bin/backup.bash
#

cd "$(dirname "$0")"

NOW=$(date +"%Y-%m-%d")
NOW_D=$(date +"%d")
NOW_MD=$(date +"%m-%d")

for namespace in `ls ../data-store`; do
    if [[ -f "../data-store/$namespace/backup-list.txt" ]]; then
        if [[ ! -f "../Yandex.Disk/backup/daily/$NOW/$namespace" ]]; then
            mkdir -p ../Yandex.Disk/backup/daily/$NOW/$namespace
        fi

        cp ../data-store/$namespace/backup-list.txt ../Yandex.Disk/backup/daily/$NOW/$namespace/

        for item in `cat ../data-store/$namespace/backup-list.txt`; do
            pushd ../data-store/$namespace
                zip -r $item.zip $item
            popd

            if [[ $NOW_D -eq "02" ]]; then
                if [[ ! -f "../Yandex.Disk/backup/monthly/$NOW/$namespace" ]]; then
                    mkdir -p ../Yandex.Disk/backup/monthly/$NOW/$namespace
                fi
                cp ../data-store/$namespace/$item.zip ../Yandex.Disk/backup/monthly/$NOW/$namespace/
            fi

            if [[ $NOW_MD -eq "01-02" ]]; then
                if [[ ! -f "../Yandex.Disk/backup/yearly/$NOW/$namespace" ]]; then
                    mkdir -p ../Yandex.Disk/backup/yearly/$NOW/$namespace
                fi
                cp ../data-store/$namespace/$item.zip ../Yandex.Disk/backup/yearly/$NOW/$namespace/
            fi

            mv ../data-store/$namespace/$item.zip ../Yandex.Disk/backup/daily/$NOW/$namespace/
        done
    fi
done
