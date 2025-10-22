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
