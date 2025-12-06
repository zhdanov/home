#!/bin/bash

sudo apt clean
sudo apt -y update
sudo apt -y upgrade

# common
sudo apt -y install \
vim \
git \
openssh-server \
curl \
tree \
nfs-kernel-server \
ffmpeg \
unrar \
tmux \
fzf \
ripgrep \
httpie \
gcal \
cryptsetup \
apache2-utils \
rename \
sshfs \
sqlite3

# sys analysis
sudo apt -y install hdparm htop atop smem ncdu

# net analysis
sudo apt -y install net-tools tcptrack whois

# php
sudo apt -y install composer php-cli php-dom php-xml php-mbstring php-curl php-yaml php-sqlite3 php-zip php-gd php-redis php-mysql

# clang
sudo apt -y install clang-format cppcheck valgrind
