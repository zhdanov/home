#!/bin/bash
#
# run it:
# curl -sSL https://raw.githubusercontent.com/zhdanov/home/selectel/setup/setup__hosting-debian-11.bash | bash
#

# apt update
sudo apt update
sudo apt upgrade -y

# disable ssh root login
sudo sed -i 's/^PermitRootLogin.*/PermitRootLogin no/g' /etc/ssh/sshd_config
sudo systemctl restart sshd

# packages
sudo apt install nginx php-fpm certbot python3-certbot-nginx unzip zip htop tree ncdu tmux apache2-utils -y

# start and autostart
sudo systemctl start nginx php7.4-fpm
sudo systemctl enable nginx php7.4-fpm

mkdir -p /var/www/domains/
