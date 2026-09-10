#!/usr/bin/env bash
set -euo pipefail

sudo apt-get update
sudo apt-get install -y \
  ca-certificates \
  curl \
  git 

# install docker 
curl -fsSL https://get.docker.com | sudo sh

# add user to docker group
sudo usermod -aG docker "$USER"

# get KUBECTL_VERSION from kubernetes release
KUBECTL_VERSION="$(curl -L -s https://dl.k8s.io/release/stable.txt)"

# install kubectl
curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"

chmod +x kubectl 
sudo install -m 0755 kubectl /usr/local/bin/kubectl
rm -f kubectl

# install k3d 
curl -fsSL https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
