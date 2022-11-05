#!/bin/bash

DEV_CDROM=/dev/sr0


pushd "$(dirname "$0")"

    . ../setup/setup_def.bash
    if [[ -f "../setup/setup_def_custom.bash" ]]; then
        . ../setup/setup_def_custom.bash
    fi

    BACKUP_DIR_PATH=/home/$HOME_USER_NAME/Yandex.Disk/backup

    for media in `ls /media/$HOME_USER_NAME/`; do
        if [ -d /media/$HOME_USER_NAME/$media/backup ]
        then
            [[ -d $BACKUP_DIR_PATH/monthly ]] && rsync -av $BACKUP_DIR_PATH/monthly /media/$HOME_USER_NAME/$media/backup/
            [[ -d $BACKUP_DIR_PATH/yearly ]] && rsync -av $BACKUP_DIR_PATH/yearly /media/$HOME_USER_NAME/$media/backup/
            [[ -d $BACKUP_DIR_PATH/Videos ]] && rsync -av $BACKUP_DIR_PATH/Videos /media/$HOME_USER_NAME/$media/backup/
            [[ -f $BACKUP_DIR_PATH/git-store.zip ]] && rsync -av $BACKUP_DIR_PATH/git-store.zip /media/$HOME_USER_NAME/$media/backup/
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
