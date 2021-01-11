#!/bin/bash
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

        cat <<EOF | sudo tee /etc/init.d/yandex-disk
#!/bin/sh -e
### BEGIN INIT INFO
# Provides:          yandex-disk
# Required-Start:    \$local_fs
# Required-Stop:     \$local_fs
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Manage Yandex.Disk deamon
### END INIT INFO

# Various constants
user=$HOME_USER_NAME

execute() {
    su -c "\$1" "\$user"
}

start() {
    echo "Starting Yandex.Disk daemon..."
    execute "yandex-disk start"
}

stop() {
    echo "Stopping Yandex.Disk daemon..."
    execute "yandex-disk stop"
}

status() {
    execute "yandex-disk status"
}

# Carry out specific functions when asked to by the system
case "\$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  status)
    status
    ;;
  restart)
    stop
    start
    ;;
  *)
    echo "Usage: \$0 {start|stop|status|restart}"
    exit 1
    ;;
esac

exit 0
EOF
        sudo chmod +x /etc/init.d/yandex-disk
        update-rc.d yandex-disk defaults

    fi

    if [[ ! -d "/opt/dropbox" ]]; then
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

        sudo systemctl enable dropbox
        sudo systemctl start dropbox

        # another way
        #/opt/dropbox/dropboxd
    fi

popd
