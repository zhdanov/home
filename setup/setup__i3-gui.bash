#!/bin/bash

sudo apt -y install \
i3 i3status \
thunar xarchiver ttf-mscorefonts-installer kate pasystray samba gitk maim mpv pulseaudio pavucontrol

# alacritty
UBUNTU_VERSION=$(lsb_release -r -s)
if [ "$UBUNTU_VERSION" != "24.04" ]; then
    sudo apt -y install exfat-fuse exfat-utils
    sudo add-apt-repository ppa:aslatter/ppa -y
    sudo apt install -y alacritty trojita
else
    sudo apt -y install alacritty ntfs-3g exfatprogs
fi
