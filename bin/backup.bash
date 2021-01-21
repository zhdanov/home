#!/bin/bash
#
# 1. Make backup-list files. Example:
#    ~/data-store/gitlab-prod/backup-list.txt
#        gitlab-config                    # pvc-directory name example
#        /path/to/backup.bash             # execute this script with parameter $HOME_USER_NAME
#        user@host:/path/to/backup/daily  # scp $NOW.zip from the daily directory
#
# 2. Change HOME_BACKUP_CRON in:
#    setup/setup_def.bash
#    or setup/setup_def_custom.bash
#

ROTATE_DAILY=10
ROTATE_MONTHLY=5
ROTATE_YEARLY=5

CLOUD_DIR_LIST=(
Yandex.Disk
Dropbox
)

pushd "$(dirname "$0")"

    NOW=$(date +"%Y-%m-%d")
    NOW_D=$(date +"%d")
    NOW_MD=$(date +"%m-%d")

    ERROR_MESSAGE_LIST=""

    . ../setup/setup_def.bash
    if [[ -f "../setup/setup_def_custom.bash" ]]; then
        . ../setup/setup_def_custom.bash
    fi

    if [[ ! -d /root/.kube ]]; then
        mkdir /root/.kube
        cp /home/$HOME_USER_NAME/.kube/config /root/.kube/config
    fi

    # make backups
    for environment in `ls ../data-store`; do
        if [[ -f "../data-store/$environment/backup-list.txt" ]]; then

            for item in `cat ../data-store/$environment/backup-list.txt`; do

                pushd ../data-store/$environment
                    if echo $item | grep -qoP '@.*:'
                    then
                        DOMAIN_NAME=`echo $item | grep -oP '@.*:' | cut -d '@' -f 2 | cut -d ':' -f 1`
                        scp $item/$NOW.zip $DOMAIN_NAME.zip

                        if [[ -f $DOMAIN_NAME.zip ]]; then
                            item=$DOMAIN_NAME
                        else
                            ERROR_MESSAGE_LIST="$ERROR_MESSAGE_LIST
$DOMAIN_NAME.zip was not created"
                        fi
                    elif echo $item | grep -qoP '.*\/backup\.bash$'
                    then
                        if [[ -f $item ]]; then
                            /bin/bash $item $HOME_USER_NAME

                            if [[ $(dirname "$item") =~ (.*)/(.*)/(.*)$ ]]; then
                                BACKUP_FILE_NAME="${BASH_REMATCH[2]}-${BASH_REMATCH[3]}-backup.tar"
                                if [[ ! -f $BACKUP_FILE_NAME ]]; then
                                    ERROR_MESSAGE_LIST="$ERROR_MESSAGE_LIST
$BACKUP_FILE_NAME was not created"
                                fi
                            fi
                        fi
                    else
                        zip -r $item.zip $item

                        if [[ ! -f $item.zip ]]; then
                            ERROR_MESSAGE_LIST="$ERROR_MESSAGE_LIST
$item.zip was not created"
                        fi
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

                if [[ -f ../data-store/$environment/backup-list.txt ]]; then
                    cp ../data-store/$environment/backup-list.txt ../$clouddir/backup/daily/$NOW/$environment/
                fi

                if ls ../data-store/$environment/ | grep -qoP '\.zip|\.tar$'
                then
                    if [[ $NOW_MD -eq "01-02" ]]; then
                        if [[ ! -d "../$clouddir/backup/yearly/$NOW/$environment" ]]; then
                            mkdir -p ../$clouddir/backup/yearly/$NOW/$environment
                        fi
                        cp ../data-store/$environment/*.{zip,tar} ../$clouddir/backup/yearly/$NOW/$environment/
                    fi

                    if [[ $NOW_D -eq "02" ]]; then
                        if [[ ! -d "../$clouddir/backup/monthly/$NOW/$environment" ]]; then
                            mkdir -p ../$clouddir/backup/monthly/$NOW/$environment
                        fi
                        cp ../data-store/$environment/*.{zip,tar} ../$clouddir/backup/monthly/$NOW/$environment/
                    fi

                    cp ../data-store/$environment/*.{zip,tar} ../$clouddir/backup/daily/$NOW/$environment/
                fi

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
        if ls ../data-store/$environment/ | grep -qoP '\.zip|\.tar$'
        then
            rm -f ../data-store/$environment/*.{zip,tar}
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

    # pull git-store
    if [[ -d "$HOME/Yandex.Disk/git-store" ]]; then
        for repo in `ls $HOME/Yandex.Disk/git-store`; do
            pushd $HOME/Yandex.Disk/git-store/$repo
                git pull origin main
            popd
        done
    fi

    # send errors to kibana
    if [[ $ERROR_MESSAGE_LIST != "" ]]; then
        # @todo: push kibana api
        echo "$ERROR_MESSAGE_LIST"
    fi

popd
