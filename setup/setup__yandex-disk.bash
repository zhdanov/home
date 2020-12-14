#!/bin/bash

if [[ ! -f "/etc/apt/sources.list.d/yandex-disk.list" ]]; then
    echo "deb http://repo.yandex.ru/yandex-disk/deb/ stable main" | sudo tee -a /etc/apt/sources.list.d/yandex-disk.list > /dev/null && wget http://repo.yandex.ru/yandex-disk/YANDEX-DISK-KEY.GPG -O- | sudo apt-key add - && sudo apt-get update && sudo apt-get install -y yandex-disk

    cat << EOF
    ==== Yandex Disk ====
    == optional ==
vim $HOME/.config/yandex-disk/config.cfg
exclude-dirs=home,tmp
read-only="true"
overwrite="true"
    == /optional ==
EOF

    yandex-disk setup
fi
