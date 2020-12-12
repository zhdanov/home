#!/bin/bash

sudo apt install apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt update
sudo apt install -y docker.io kubectl docker-compose parallel
sudo apt-mark hold docker.io kubectl docker-compose

sudo usermod -aG docker $USER

sudo systemctl daemon-reload