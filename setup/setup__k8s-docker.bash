curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

BASHRC="/home/$HOME_USER_NAME/.bashrc"
if ! grep -q "^# kubernetes" "$BASHRC"; then
  {
    echo "# kubernetes"
    echo "alias k=kubectl"
    echo "source <(kubectl completion bash)"
    echo "complete -F __start_kubectl k"
  } >> "$BASHRC"
fi

# optional
# sudo apt-get install docker.io
