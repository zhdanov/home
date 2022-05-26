#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "usage:"
    echo "$0 username"
    exit 0
fi

HOME_USER_NAME=$1

pushd "$(dirname "$0")"

    . setup_def.bash

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

        if [ ! -f '/etc/rc.local' ]; then
            sudo touch /etc/rc.local
            sudo chmod +x /etc/rc.local
            cat <<EOF | sudo tee -a /etc/rc.local
#!/bin/bash
EOF
        fi

        if ! grep -q "yandex-disk" /etc/rc.local; then
            cat <<EOF | sudo tee -a /etc/rc.local
sudo -u $HOME_USER_NAME -s yandex-disk start
EOF

    fi

    fi

    # Run /opt/dropbox/dropboxd for connect dropbox to computer
    if [ ! -d "/opt/dropbox" ]; then
        wget https://www.dropbox.com/download?plat=lnx.x86_64 -O dropbox-linux.tar.gz

        sudo mkdir /opt/dropbox/
        sudo tar xvf dropbox-linux.tar.gz --strip 1 -C /opt/dropbox
        sudo apt -y install libc6 libglapi-mesa libxdamage1 libxfixes3 libxcb-glx0 libxcb-dri2-0 libxcb-dri3-0 libxcb-present0 libxcb-sync1 libxshmfence1 libxxf86vm1

        rm dropbox-linux.tar.gz

        cat <<EOF | sudo tee /etc/systemd/system/dropbox.service
[Unit]
Description=Dropbox Daemon
After=network.target

[Service]
Type=simple
User=$HOME_USER_NAME
ExecStart=/opt/dropbox/dropboxd
ExecStop=/bin/kill -HUP \$MAINPID
Restart=always

[Install]
WantedBy=multi-user.target
EOF

        # update dropbox
        sudo sed -i -e '/^.*setup\_\_update\-dropbox\.bash$/d' /etc/crontab
        echo "30 4 * * * root /home/$HOME_USER_NAME/setup/setup__update-dropbox.bash" | sudo tee -a /etc/crontab

        # dropbox does not deserve to work at other times
        sudo sed -i -e '/^.*systemctl start dropbox$/d' /etc/crontab
        echo "30 5 * * * root systemctl start dropbox" | sudo tee -a /etc/crontab
        sudo sed -i -e '/^.*systemctl stop dropbox$/d' /etc/crontab
        echo "30 8 * * * root systemctl stop dropbox" | sudo tee -a /etc/crontab

        sudo systemctl restart cron

        # another way
        #/opt/dropbox/dropboxd
    fi

popd
