#!/bin/bash

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

popd
