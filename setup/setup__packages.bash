#!/bin/bash

sudo apt clean
sudo apt -y update
sudo apt -y upgrade

sudo apt -y install vim vifm git openssh-server net-tools curl maim hdparm tree nfs-kernel-server ffmpeg unrar nodejs npm tmux vim htop atop smem fzf ripgrep ncdu
sudo apt -y install i3 i3status nemo ttf-mscorefonts-installer kate brightnessctl tcptrack pasystray samba sqlite3

if [[ $SETUP_TYPE == "slave" ]]; then
    sudo apt -y install fbreader audacity growisofs peek screenkey cheese
fi

# alacritty
UBUNTU_VERSION=$(lsb_release -r -s)
if [ "$UBUNTU_VERSION" = "22.04" ]; then
    sudo add-apt-repository ppa:aslatter/ppa -y
else
    sudo add-apt-repository -y ppa:mmstick76/alacritty
fi
sudo apt install -y alacritty

# slave soft
sudo apt -y install chromium-browser
if [[ $SETUP_TYPE == "slave" ]]; then
    . setup__google-chrome.bash
    . setup__opera.bash
    . setup__yandex-browser.bash

    sudo snap install standard-notes
    sudo snap install dbeaver-ce
    sudo snap install zoom-client

    sudo snap refresh
    sudo snap set system refresh.metered=hold

fi

# php
sudo apt -y install php-cli php-dom php-mbstring php-curl php-yaml php-sqlite3
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'e21205b207c3ff031906575712edab6f13eb0b361f2085f1f1237b7126d785e826a450292b6cfd1d64d92e6563bbde02') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
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
