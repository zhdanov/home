#!/bin/bash
#
# 1. Execute ./setup/setup__cloud-drive.bash
# 2. Make files workspace/%namespace%/backup-list.txt
#    with list dirs for backup
# 3. Cron by root:
#    30 4 * * * /home/%user%/bin/backup.bash
#

cd "$(dirname "$0")"

ROTATE_DAILY=10
ROTATE_MONTHLY=5
ROTATE_YEARLY=5

CLOUD_DIR_LIST=(
Yandex.Disk
Dropbox
)

NOW=$(date +"%Y-%m-%d")
NOW_D=$(date +"%d")
NOW_MD=$(date +"%m-%d")


# make backups
for namespace in `ls ../data-store`; do
    if [[ -f "../data-store/$namespace/backup-list.txt" ]]; then

        for clouddir in "${CLOUD_DIR_LIST[@]}"
        do
            if [[ ! -d "../$clouddir/backup/daily/$NOW/$namespace" ]]; then
                mkdir -p ../$clouddir/backup/daily/$NOW/$namespace
            fi

            cp ../data-store/$namespace/backup-list.txt ../$clouddir/backup/daily/$NOW/$namespace/

            for item in `cat ../data-store/$namespace/backup-list.txt`; do
                pushd ../data-store/$namespace
                    zip -r $item.zip $item
                popd

                if [[ $NOW_D -eq "02" ]]; then
                    if [[ ! -f "../$clouddir/backup/monthly/$NOW/$namespace" ]]; then
                        mkdir -p ../$clouddir/backup/monthly/$NOW/$namespace
                    fi
                    cp ../data-store/$namespace/$item.zip ../$clouddir/backup/monthly/$NOW/$namespace/
                fi

                if [[ $NOW_MD -eq "01-02" ]]; then
                    if [[ ! -f "../$clouddir/backup/yearly/$NOW/$namespace" ]]; then
                        mkdir -p ../$clouddir/backup/yearly/$NOW/$namespace
                    fi
                    cp ../data-store/$namespace/$item.zip ../$clouddir/backup/yearly/$NOW/$namespace/
                fi

                mv ../data-store/$namespace/$item.zip ../$clouddir/backup/daily/$NOW/$namespace/
            done
        done

    fi
done


# rotate backups
for clouddir in "${CLOUD_DIR_LIST[@]}"
do
    if [[ -d "../$clouddir/backup/daily" ]]; then
        pushd ../$clouddir/backup/daily
            if (( $(ls | grep -P "^\d{4}-\d{2}-\d{2}$" | wc -l) > $ROTATE_DAILY )); then
                rm -rf $(ls | grep -P "^\d{4}-\d{2}-\d{2}$" | head -1)
            fi
        popd
    fi
    if [[ -d "../$clouddir/backup/monthly" ]]; then
        pushd ../$clouddir/backup/monthly
            if (( $(ls | grep -P "^\d{4}-\d{2}-\d{2}$" | wc -l) > $ROTATE_MONTHLY )); then
                rm -rf $(ls | grep -P "^\d{4}-\d{2}-\d{2}$" | head -1)
            fi
        popd
    fi
    if [[ -d "../$clouddir/backup/yearly" ]]; then
        pushd ../$clouddir/backup/yearly
            if (( $(ls | grep -P "^\d{4}-\d{2}-\d{2}$" | wc -l) > $ROTATE_YEARLY )); then
                rm -rf $(ls | grep -P "^\d{4}-\d{2}-\d{2}$" | head -1)
            fi
        popd
    fi
done
