#!/bin/bash

sudo apt clean
sudo apt -y update
sudo apt -y upgrade

sudo apt -y install vim vifm git openssh-server net-tools curl maim hdparm tree nfs-kernel-server ffmpeg unrar nodejs npm tmux vim htop atop smem fzf ripgrep ncdu
sudo apt -y install i3 i3status nemo ttf-mscorefonts-installer kate fbreader audacity growisofs peek screenkey cheese brightnessctl tcptrack pasystray samba

# alacritty
sudo add-apt-repository -y ppa:mmstick76/alacritty
sudo apt install -y alacritty

# browsers
sudo apt -y install chromium-browser
. setup__google-chrome.bash
. setup__opera.bash
. setup__yandex-browser.bash

sudo snap install standard-notes
sudo snap install dbeaver-ce
sudo snap install zoom-client
sudo snap set system refresh.timer=3:00-5:00

# php
sudo apt -y install php-cli php-dom php-mbstring php-curl php-yaml
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'e21205b207c3ff031906575712edab6f13eb0b361f2085f1f1237b7126d785e826a450292b6cfd1d64d92e6563bbde02') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer

# neovim
sudo mkdir -p /opt/neovim && rm -f /opt/neovim/* && sudo chown $HOME_USER_NAME:$HOME_USER_NAME /opt/neovim
wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage -O /opt/neovim/nvim.appimage
chmod +x /opt/neovim/nvim.appimage
sudo ln -sf /opt/neovim/nvim.appimage /usr/local/bin/v
