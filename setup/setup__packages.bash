#!/bin/bash

sudo apt clean
sudo apt -y update
sudo apt -y upgrade

sudo apt -y install vim git openssh-server net-tools curl hdparm tree nfs-kernel-server ffmpeg unrar nodejs npm tmux vim htop smem fzf ripgrep ncdu
sudo apt -y install i3 i3status nemo ttf-mscorefonts-installer kate fbreader audacity growisofs peek screenkey cheese

. setup__google-chrome.bash
. setup__opera.bash
. setup__yandex-browser.bash

sudo snap install dbeaver-ce
sudo snap install zoom-client

# php
sudo apt -y install php-cli php-dom php-mbstring
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === '906a84df04cea2aa72f40b5f787e49f22d4c2f19492ac310e8cba5b96ac8b64115ac402c8cd292b8a03482574915d1a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer
