#!/usr/bin/env bash
set -euo pipefail
# creating argocd namespace


echo "creating the dev namespace"
#creating the dev namespace
kubectl create namespace dev --dry-run=client -o yaml |  kubectl apply -f -

echo "created the dev namespace"

kubectl apply -f /vagrant/manifests/app/app.yaml -n dev

echo "created the app"

kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -

echo "created the argocd NS"

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.9.3/manifests/install.yaml

echo "added argoCd in the cluster"

echo "Waiting for Argo CD pods to be ready..."
kubectl wait \
  --for=condition=Ready \
  pods \
  --all \
  -n argocd \
  --timeout=300s

kubectl apply -f /vagrant/manifests/argo-app.yaml

echo "=== Argo CD pods ==="
kubectl get pods -n argocd
echo "=== Dev pods ==="
kubectl get pods -n dev 
