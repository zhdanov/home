#!/bin/bash

sudo apt clean
sudo apt -y update
sudo apt -y upgrade

sudo apt -y install vim vifm git openssh-server net-tools curl maim hdparm tree nfs-kernel-server ffmpeg unrar nodejs npm tmux vim htop atop smem fzf ripgrep ncdu httpie gcal goldendict shotwell exfat-fuse exfat-utils mpv
sudo apt -y install i3 i3status nemo ttf-mscorefonts-installer kate brightnessctl tcptrack pasystray samba sqlite3
sudo apt -y install clang-format cppcheck valgrind

if [[ $SETUP_TYPE == "slave" ]]; then
    sudo apt -y install fbreader audacity growisofs peek screenkey cheese
fi

# alacritty
UBUNTU_VERSION=$(lsb_release -r -s)
if [ "$UBUNTU_VERSION" != "24.04" ]; then
    sudo add-apt-repository ppa:aslatter/ppa -y
    sudo apt install -y alacritty
fi

# slave soft
sudo apt -y install chromium-browser

#if [[ $SETUP_TYPE == "slave" ]]; then
    #. setup__yandex-browser.bash

    # snap begin
    #sudo snap install standard-notes
    #sudo snap install dbeaver-ce
    #sudo snap install zoom-client

    #sudo snap refresh
    #sudo snap set system refresh.metered=hold
    # snap end

#fi

# php
sudo apt -y install php-cli php-dom php-mbstring php-curl php-yaml php-sqlite3
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'dac665fdc30fdd8ec78b38b9800061b4150413ff2e3b6f88543c636f7cd84f6db9189d43a81e5503cda447da73c7e5b6') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer

# neovim
sudo mkdir -p /opt/neovim && rm -f /opt/neovim/* && sudo chown $HOME_USER_NAME:$HOME_USER_NAME /opt/neovim
wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz -O /opt/neovim/nvim-linux64.tar.gz
pushd /opt/neovim
    tar xf nvim-linux64.tar.gz
popd
sudo ln -sf /opt/neovim/nvim-linux64/bin/nvim /usr/local/bin/v
