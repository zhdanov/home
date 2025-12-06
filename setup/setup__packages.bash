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

# clang
sudo apt -y install clang-format cppcheck valgrind
