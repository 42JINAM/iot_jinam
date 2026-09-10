#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="jinam"

# create cluster
if ! k3d cluster list | grep -q "^${CLUSTER_NAME} "; then
    k3d cluster create "${CLUSTER_NAME}" \
        --agents 1 \
        --servers 1 \
        -p "8888:80@loadbalancer"
fi

# kubectl config
kubectl config use-context "k3d-${CLUSTER_NAME}"

echo "=== Nodes ==="
kubectl get nodes

echo "=== Namespaces ==="
kubectl get namespaces
