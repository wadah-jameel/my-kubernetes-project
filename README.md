# Simple Kubernetes Web Application

[![Deploy Status](https://img.shields.io/badge/deploy-success-green)]()
[![Kubernetes](https://img.shields.io/badge/kubernetes-v1.25+-blue)]()

## 🚀 Overview
A simple web application deployed on Kubernetes demonstrating basic concepts including deployments, services, and configmaps.

## 📋 Table of Contents
- [Architecture](#architecture)
- [Quick Start](#quick-start)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Documentation](#documentation)
- [Contributing](#contributing)
- [License](#license)

## 🏗️ Architecture
This project demonstrates a simple 3-tier web application:
- **Frontend**: Nginx web server
- **Backend**: Simple Node.js API
- **Configuration**: ConfigMaps for environment settings

![Architecture Diagram](./images/architecture-diagram.png)

## ⚡ Quick Start
```bash
# Clone the repository
git clone https://github.com/yourusername/my-kubernetes-project.git
cd my-kubernetes-project

# Deploy to Kubernetes
kubectl apply -f k8s-manifests/

# Check deployment status
kubectl get pods -n my-app


## Step 1: Project Structure Setup

### 1.1 Create Repository Structure
```bash
my-kubernetes-project/
├── README.md
├── docs/
│   ├── getting-started.md
│   ├── deployment-guide.md
│   ├── architecture.md
│   └── troubleshooting.md
├── k8s-manifests/
│   ├── namespace.yaml
│   ├── deployment.yaml
│   ├── service.yaml
│   └── configmap.yaml
├── scripts/
│   ├── deploy.sh
│   └── cleanup.sh
├── images/
│   └── architecture-diagram.png
└── .github/
    └── workflows/
        └── deploy.yml
```

### 1.2 Initialize Your Repository
```bash
# Create new repository on GitHub first, then:
git clone https://github.com/yourusername/my-kubernetes-project.git
cd my-kubernetes-project

# Create directory structure
mkdir -p docs k8s-manifests scripts images .github/workflows

# Create initial files
touch README.md docs/getting-started.md docs/deployment-guide.md
touch k8s-manifests/namespace.yaml k8s-manifests/deployment.yaml
```

🛠️ Prerequisites

    Kubernetes cluster (v1.25+)
    kubectl configured
    Docker (for building custom images)


## Step 2: Create Kubernetes Manifests

### 2.1 Namespace Configuration (k8s-manifests/namespace.yaml)
```bash
```yaml
# namespace.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: my-app
  labels:
    name: my-app
    environment: development
```

### 2.2 ConfigMap (k8s-manifests/configmap.yaml)
```bash
# configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
  namespace: my-app
data:
  # Application configuration
  APP_NAME: "My Kubernetes App"
  APP_VERSION: "1.0.0"
  NODE_ENV: "production"
  # Database configuration
  DB_HOST: "localhost"
  DB_PORT: "5432"
  # API configuration
  API_URL: "http://api-service:3000"
  # Frontend configuration
  NGINX_PORT: "80"
```

### 2.3 Deployment (k8s-manifests/deployment.yaml)
```bash
# deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-app
  namespace: my-app
  labels:
    app: web-app
    version: v1.0.0
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web-app
  template:
    metadata:
      labels:
        app: web-app
    spec:
      containers:
      - name: web-container
        image: nginx:1.21-alpine
        ports:
        - containerPort: 80
          name: http
        env:
        - name: APP_NAME
          valueFrom:
            configMapKeyRef:
              name: app-config
              key: APP_NAME
        - name: APP_VERSION
          valueFrom:
            configMapKeyRef:
              name: app-config
              key: APP_VERSION
        resources:
          requests:
            memory: "64Mi"
            cpu: "50m"
          limits:
            memory: "128Mi"
            cpu: "100m"
        livenessProbe:
          httpGet:
            path: /
            port: 80
          initialDelaySeconds: 30
          periodSeconds: 10
        readinessProbe:
          httpGet:
            path: /
            port: 80
          initialDelaySeconds: 5
          periodSeconds: 5
        volumeMounts:
        - name: nginx-config
          mountPath: /etc/nginx/conf.d
      volumes:
      - name: nginx-config
        configMap:
          name: nginx-config
---
# API Deployment
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api-app
  namespace: my-app
  labels:
    app: api-app
spec:
  replicas: 2
  selector:
    matchLabels:
      app: api-app
  template:
    metadata:
      labels:
        app: api-app
    spec:
      containers:
      - name: api-container
        image: node:16-alpine
        ports:
        - containerPort: 3000
        env:
        - name: NODE_ENV
          valueFrom:
            configMapKeyRef:
              name: app-config
              key: NODE_ENV
        - name: PORT
          value: "3000"
        command: ["/bin/sh"]
        args: ["-c", "echo 'const express = require(\"express\"); const app = express(); app.get(\"/\", (req, res) => res.json({message: \"API is running\", version: process.env.APP_VERSION})); app.listen(3000, () => console.log(\"API running on port 3000\"));' > app.js && npm init -y && npm install express && node app.js"]
        resources:
          requests:
            memory: "128Mi"
            cpu: "100m"
          limits:
            memory: "256Mi"
            cpu: "200m"
```

### 2.4 Service (k8s-manifests/service.yaml)
```bash
# service.yaml
apiVersion: v1
kind: Service
metadata:
  name: web-service
  namespace: my-app
  labels:
    app: web-app
spec:
  type: LoadBalancer
  ports:
  - port: 80
    targetPort: 80
    protocol: TCP
    name: http
  selector:
    app: web-app
---
apiVersion: v1
kind: Service
metadata:
  name: api-service
  namespace: my-app
  labels:
    app: api-app
spec:
  type: ClusterIP
  ports:
  - port: 3000
    targetPort: 3000
    protocol: TCP
    name: api
  selector:
    app: api-app
```
3. Verify Cluster Access
```bash
# Check cluster connection
kubectl cluster-info

# List nodes
kubectl get nodes
```

# Quick Deployment

## Step 1: Clone Repository
```bash
git clone https://github.com/yourusername/my-kubernetes-project.git
cd my-kubernetes-project
```

## Step 2: Deploy Application
```bash
# Apply all manifests
kubectl apply -f k8s-manifests/

# Or use the deployment script
chmod +x scripts/deploy.sh
./scripts/deploy.sh
```

## Step 3: Verify Deployment
```bash
# Check namespace
kubectl get namespaces

# Check pods
kubectl get pods -n my-app

# Check services
kubectl get services -n my-app
```

## Step 4: Access Application
```bash
# Get service URL (for LoadBalancer)
kubectl get service web-service -n my-app

# Or port-forward for local access
kubectl port-forward service/web-service 8080:80 -n my-app
# Then visit http://localhost:8080
```



