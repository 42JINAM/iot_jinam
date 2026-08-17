#!/bin/bash

curl -sfL https://get.k3s.io | sh -

sudo k3s kubectl wait \
  --for=condition==Ready \
  node \
  --all \
  --timeout=120s

KUBE_USER="vagrant"
KUBE_HOME="/home/$KUBE_USER"

sudo mkdir -p $KUBE_HOME/.kube
sudo cp /etc/rancher/k3s/k3s.yaml "$KUBE_HOME/.kube/config"
sudo chown -R "$KUBE_USER:$KUBE_USER" "$KUBE_HOME/.kube"

sudo mkdir -p /opt/p2/manifests
sudo cp -r /vagrant/manifests/. /opt/p2/manifests/

sudo k3s kubectl apply -f /opt/p2/manifests

sudo k3s kubectl get nodes
sudo k3s kubectl get deployments
sudo k3s kubectl get pods -o wide
sudo k3s kubectl get services 
sudo k3s kubectl get ingress
