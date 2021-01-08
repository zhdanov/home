#!/bin/bash
#
# 1. Execute ./setup/setup__cloud-drive.bash
# 2. Make files workspace/%environment%/backup-list.txt
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


. ../setup/setup_def.bash
if [[ -f "../setup/setup_def_custom.bash" ]]; then
    . ../setup/setup_def_custom.bash
fi


# make backups
for environment in `ls ../data-store`; do
    if [[ -f "../data-store/$environment/backup-list.txt" ]]; then

        for item in `cat ../data-store/$environment/backup-list.txt`; do

            pushd ../data-store/$environment
                if echo $item | grep -qoP '@.*:'; then
                    DOMAIN_NAME=`echo $item | grep -oP '@.*:' | cut -d '@' -f 2 | cut -d ':' -f 1`
                    scp $item/$NOW.zip $DOMAIN_NAME.zip

                    if [[ -f $DOMAIN_NAME.zip ]]; then
                        item=$DOMAIN_NAME
                    fi
                else
                    zip -r $item.zip $item
                fi
            popd

        done

    fi
done

# copy backups
for environment in `ls ../data-store`; do
    if [[ -f "../data-store/$environment/backup-list.txt" ]]; then

        for clouddir in "${CLOUD_DIR_LIST[@]}"
        do
            if [[ ! -d "../$clouddir/backup/daily/$NOW/$environment" ]]; then
                mkdir -p ../$clouddir/backup/daily/$NOW/$environment
            fi

            cp ../data-store/$environment/backup-list.txt ../$clouddir/backup/daily/$NOW/$environment/

            if [[ $NOW_MD -eq "01-02" ]]; then
                if [[ ! -f "../$clouddir/backup/yearly/$NOW/$environment" ]]; then
                    mkdir -p ../$clouddir/backup/yearly/$NOW/$environment
                fi
                cp ../data-store/$environment/*.zip ../$clouddir/backup/yearly/$NOW/$environment/
            fi

            if [[ $NOW_D -eq "02" ]]; then
                if [[ ! -f "../$clouddir/backup/monthly/$NOW/$environment" ]]; then
                    mkdir -p ../$clouddir/backup/monthly/$NOW/$environment
                fi
                cp ../data-store/$environment/*.zip ../$clouddir/backup/monthly/$NOW/$environment/
            fi

            cp ../data-store/$environment/*.zip ../$clouddir/backup/daily/$NOW/$environment/

            if [[ -d "../$clouddir/backup/yearly/$NOW" ]]; then
                chown -R $HOME_USER_NAME:$HOME_USER_NAME ../$clouddir/backup/yearly/$NOW
            fi

            if [[ -d "../$clouddir/backup/monthly/$NOW" ]]; then
                chown -R $HOME_USER_NAME:$HOME_USER_NAME ../$clouddir/backup/monthly/$NOW
            fi

            if [[ -d "../$clouddir/backup/daily/$NOW" ]]; then
                chown -R $HOME_USER_NAME:$HOME_USER_NAME ../$clouddir/backup/daily/$NOW
            fi
        done

    fi
done

# clean backups
for environment in `ls ../data-store`; do
    rm ../data-store/$environment/*.zip
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
