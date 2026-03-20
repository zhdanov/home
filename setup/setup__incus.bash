#!/bin/bash

set -e

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://pkgs.zabbly.com/key.asc | \
  sudo gpg --dearmor --yes -o /etc/apt/keyrings/incus.gpg

DISTRO="noble"

echo "deb [signed-by=/etc/apt/keyrings/incus.gpg] https://pkgs.zabbly.com/incus/stable $DISTRO main" | \
  sudo tee /etc/apt/sources.list.d/incus.list

sudo apt update

sudo apt install -y incus incus-client

sudo usermod -aG incus $USER
sudo systemctl enable --now incus
