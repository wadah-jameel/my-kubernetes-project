### 4.3 Deployment Guide (docs/deployment-guide.md)
```markdown
# Detailed Deployment Guide

## Pre-Deployment Checklist
- [ ] Kubernetes cluster is accessible
- [ ] kubectl is configured and working
- [ ] Sufficient cluster resources available
- [ ] Required images are accessible

## Step-by-Step Deployment

### 1. Prepare Environment
```bash
# Set context (if using multiple clusters)
kubectl config current-context

# Create namespace first (optional - will be created by manifest)
kubectl create namespace my-app
