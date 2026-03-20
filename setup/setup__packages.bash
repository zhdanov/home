#!/bin/bash

sudo apt-get clean
sudo apt-get -y update
sudo apt-get -y upgrade

# common
sudo apt-get -y install \
vim \
git \
less \
openssh-server \
curl \
wget \
tree \
ffmpeg \
tmux \
fzf \
ripgrep \
httpie \
gcal \
cryptsetup \
apache2-utils \
rename \
sshfs \
sqlite3 \
proxychains4 \
privoxy \
autossh \
jq

# sys analysis
sudo apt-get -y install hdparm htop atop smem ncdu neofetch

# net analysis
sudo apt-get -y install net-tools tcptrack whois iptraf-ng tcpdump iftop

# php
sudo apt-get -y install composer php-cli php-dom php-xml php-mbstring php-curl php-yaml php-sqlite3 php-zip php-gd php-redis php-mysql

# clang
sudo apt-get -y install clang-format cppcheck valgrind
