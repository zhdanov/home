#!/bin/bash

sudo apt clean
sudo apt -y update
sudo apt -y upgrade

sudo apt -y install vim git openssh-server net-tools curl hdparm tree nfs-kernel-server ffmpeg unrar nodejs npm tmux vim htop smem fzf ripgrep ncdu
sudo apt -y install i3 i3status nemo ttf-mscorefonts-installer kate fbreader audacity growisofs peek

. setup__google-chrome.bash
. setup__opera.bash
. setup__yandex-browser.bash

sudo snap install dbeaver-ce

# java
sudo apt -y install openjdk-17-jre-headless
sudo snap install intellij-idea-community --classic
