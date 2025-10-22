# Getting Started with My Kubernetes Project

## Prerequisites

### 1. Kubernetes Cluster
You need access to a Kubernetes cluster. Options include:
- **Minikube** (local development)
- **Docker Desktop** with Kubernetes enabled
- **Cloud providers** (AWS EKS, Google GKE, Azure AKS)

### 2. Required Tools
```bash
# Install kubectl (if not already installed)
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

# Verify installation
kubectl version --client
