#!/bin/bash

sudo apt clean
sudo apt -y update
sudo apt -y upgrade

sudo apt -y install vim git openssh-server net-tools curl maim hdparm tree nfs-kernel-server ffmpeg unrar nodejs npm tmux vim htop atop smem fzf ripgrep ncdu
sudo apt -y install i3 i3status nemo ttf-mscorefonts-installer kate fbreader audacity growisofs peek screenkey cheese brightnessctl tcptrack pasystray samba

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
sudo apt -y install php-cli php-dom php-mbstring php-curl
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer
