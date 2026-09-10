#!/usr/bin/env bash
set -euo pipefail

kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.9.3/manifests/install.yaml

echo "Waiting for Argo CD pods to be ready..."
kubectl wait \
  --for=condition=Ready \
  pods \
  --all \
  -n argocd \
  --timeout=300s

echo "=== Argo CD pods ==="
kubectl get pods -n argocd
