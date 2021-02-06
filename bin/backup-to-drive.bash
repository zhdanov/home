#!/bin/bash

DEV_CDROM=/dev/sr0

pushd "$(dirname "$0")"

    . ../setup/setup_def.bash
    if [[ -f "../setup/setup_def_custom.bash" ]]; then
        . ../setup/setup_def_custom.bash
    fi

    for media in `ls /media/$HOME_USER_NAME/`; do
        if [ -d /media/$HOME_USER_NAME/$media/backup ]
        then
            cp -Rnv /home/$HOME_USER_NAME/Yandex.Disk/backup/monthly /media/$HOME_USER_NAME/$media/backup/
            cp -Rnv /home/$HOME_USER_NAME/Yandex.Disk/backup/yearly /media/$HOME_USER_NAME/$media/backup/

            pushd /home/$HOME_USER_NAME/Yandex.Disk/backup/
                zip -r git-store.zip git-store
                mv git-store.zip /media/$HOME_USER_NAME/$media/backup/
            popd
        fi
    done;

    if [ -e $DEV_CDROM ]
    then
        pushd /home/$HOME_USER_NAME/Yandex.Disk/backup/
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
