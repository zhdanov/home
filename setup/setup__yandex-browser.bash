#!/bin/bash

if [[ ! -f "/etc/apt/sources.list.d/yandex-browser.list" ]]; then
    curl -s https://repo.yandex.ru/yandex-browser/YANDEX-BROWSER-KEY.GPG | sudo apt-key add -

    cat <<EOF | sudo tee /etc/apt/sources.list.d/yandex-browser.list
deb [arch=amd64] http://repo.yandex.ru/yandex-browser/deb beta main
EOF
    sudo apt update

    sudo apt install -y yandex-browser-beta
fi
