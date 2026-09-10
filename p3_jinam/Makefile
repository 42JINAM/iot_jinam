.PHONY: help install setup-k3d install-argocd apply-argocd status clean

help:
	@echo "Available targets:"
	@echo "  make install        - Install Docker, kubectl, k3d"
	@echo "  make setup-k3d      - Create k3d cluster and namespaces"
	@echo "  make install-argocd - Install Argo CD"
	@echo "  make apply-argocd   - Apply Argo CD Application"
	@echo "  make status         - Check cluster and application status"
	@echo "  make clean          - Delete k3d cluster"

install:
	bash scripts/install_docker_k3s_kubctl.sh

setup-k3d:
	bash scripts/setup_k3d.sh

install-argocd:
	bash scripts/install_argocd.sh

apply-argocd:
	kubectl apply -f manifests/argo-app.yaml

status:
	@echo "=== K3d Clusters ==="
	k3d cluster list
	@echo ""
	@echo "=== Nodes ==="
	kubectl get nodes
	@echo ""
	@echo "=== Namespaces ==="
	kubectl get namespaces | grep -E 'argocd|dev'
	@echo ""
	@echo "=== Argo CD Pods ==="
	kubectl get pods -n argocd
	@echo ""
	@echo "=== Argo CD Applications ==="
	kubectl get applications -n argocd
	@echo ""
	@echo "=== App Pods (dev) ==="
	kubectl get pods -n dev
	@echo ""
	@echo "=== App Service (dev) ==="
	kubectl get svc -n dev

port-forward:
	kubectl port-forward -n dev svc/wil-playground 8888:80

clean:
	k3d cluster delete jinam
	@echo "Cluster deleted."
