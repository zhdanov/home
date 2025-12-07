#!/bin/bash

UBUNTU_VERSION=$(lsb_release -r -s)

# Ubuntu < 24.04
if [[ ! -f "/etc/apt/sources.list.d/kubernetes.list" && "$UBUNTU_VERSION" != "24.04" ]]; then
    sudo apt install -y apt-transport-https
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
    deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

    sudo apt update

    sudo apt install -y docker.io kubectl docker-compose parallel
    sudo apt-mark hold docker.io kubectl docker-compose

    sudo usermod -aG docker $HOME_USER_NAME && newgrp docker

    echo "{
    \"registry-mirrors\": [ \"$HOME_REGISTRY_MIRROR\" ]
}" | sudo tee /etc/docker/daemon.json

    sudo systemctl daemon-reload
    sudo systemctl restart docker
fi

# Ubuntu 24.04
if [[ ! -f "/etc/apt/sources.list.d/kubernetes.list" && "$UBUNTU_VERSION" == "24.04" ]]; then
    sudo apt-get install -y apt-transport-https ca-certificates
    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
    echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

    sudo apt update

    sudo apt install -y docker.io kubectl docker-compose parallel
    sudo apt-mark hold docker.io kubectl docker-compose

    sudo usermod -aG docker $HOME_USER_NAME && newgrp docker

    echo "{
    \"registry-mirrors\": [ \"$HOME_REGISTRY_MIRROR\" ]
}" | sudo tee /etc/docker/daemon.json

    sudo systemctl daemon-reload
    sudo systemctl restart docker
fi

echo "# kubernetes" >> /home/$HOME_USER_NAME/.bashrc
echo "alias k=kubectl" >> /home/$HOME_USER_NAME/.bashrc
echo "source <(kubectl completion bash)" >> /home/$HOME_USER_NAME/.bashrc
echo "complete -F __start_kubectl k" >> /home/$HOME_USER_NAME/.bashrc
