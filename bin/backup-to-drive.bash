#!/bin/bash

DEV_CDROM=/dev/sr0


pushd "$(dirname "$0")"

    . ../setup/setup_def.bash
    if [[ -f "../setup/setup_def_custom.bash" ]]; then
        . ../setup/setup_def_custom.bash
    fi

    BACKUP_DIR_PATH=$HOME_CLOUD_DIR/backup
    ARCHIVE_DIR_PATH=$HOME_CLOUD_DIR/archive

    for media in `ls /media/$HOME_USER_NAME/`; do
        if [ -d /media/$HOME_USER_NAME/$media/backup ]
        then
            [[ -d $BACKUP_DIR_PATH/monthly ]] && rsync --ignore-existing -raz --progress $BACKUP_DIR_PATH/monthly /media/$HOME_USER_NAME/$media/backup/
            [[ -d $BACKUP_DIR_PATH/yearly ]] && rsync --ignore-existing -raz --progress $BACKUP_DIR_PATH/yearly /media/$HOME_USER_NAME/$media/backup/
            [[ -d $BACKUP_DIR_PATH/flow-unit-store ]] && rsync --ignore-existing -raz --progress $BACKUP_DIR_PATH/flow-unit-store /media/$HOME_USER_NAME/$media/backup/
            [[ -f $BACKUP_DIR_PATH/git-store.zip ]] && rsync --ignore-existing -raz --progress $BACKUP_DIR_PATH/git-store.zip /media/$HOME_USER_NAME/$media/backup/

            for file in `find /media/$HOME_USER_NAME/$media/backup -name *.zip`; do
                res=`unzip -t $file  > /dev/null 2>&1; es=$? && echo $es`;
                [[ "$res" != "0" ]] && echo "----------- BROKEN ZIP FILE: -----------" && echo $file && exit
            done;
            for file in `find /media/$HOME_USER_NAME/$media/backup -name *.tar`; do
                res=`tar tf $file > /dev/null 2>&1; ex=$? && echo $ex`;
                [[ "$res" != "0" ]] && echo "----------- BROKEN TAR FILE: -----------" && echo $file && exit
            done;
        fi
        if [ -d /media/$HOME_USER_NAME/$media/archive ]
        then
            [[ -d $ARCHIVE_DIR_PATH ]] && rsync --ignore-existing -raz --progress $ARCHIVE_DIR_PATH /media/$HOME_USER_NAME/$media/

            for file in `find /media/$HOME_USER_NAME/$media/archive -name *.zip`; do
                res=`unzip -t $file  > /dev/null 2>&1; es=$? && echo $es`;
                [[ "$res" != "0" ]] && echo "----------- BROKEN ZIP FILE: -----------" && echo $file && exit
            done;
            for file in `find /media/$HOME_USER_NAME/$media/archive -name *.tar`; do
                res=`tar tf $file > /dev/null 2>&1; ex=$? && echo $ex`;
                [[ "$res" != "0" ]] && echo "----------- BROKEN TAR FILE: -----------" && echo $file && exit
            done;
        fi
    done;

    if [ -e $DEV_CDROM ]
    then
        pushd $BACKUP_DIR_PATH
            mkdir isodir

            zip -r git-store.zip git-store
            mv git-store.zip isodir/

            cp -R monthly/$(ls -t monthly/ | head -1) isodir/

            mkisofs -R -o backup.iso ./isodir/
            sudo growisofs -Z $DEV_CDROM=./backup.iso

            rm backup.iso
            rm -rf isodir
        popd
    fi

popd
