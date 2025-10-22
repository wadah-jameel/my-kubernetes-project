## Step 5: Create Automation Scripts

### 5.1 Deployment Script (scripts/deploy.sh)
```bash
#!/bin/bash
# deploy.sh - Deploy Kubernetes application

set -e

echo "🚀 Starting deployment..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
NAMESPACE="my-app"
MANIFESTS_DIR="k8s-manifests"

# Check if kubectl is available
if ! command -v kubectl &> /dev/null; then
    echo -e "${RED}❌ kubectl is not installed or not in PATH${NC}"
    exit 1
fi

# Check if cluster is accessible
if ! kubectl cluster-info &> /dev/null; then
    echo -e "${RED}❌ Cannot connect to Kubernetes cluster${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Kubernetes cluster is accessible${NC}"

# Apply manifests
echo -e "${YELLOW}📦 Applying Kubernetes manifests...${NC}"

for manifest in ${MANIFESTS_DIR}/*.yaml; do
    echo "Applying $manifest"
    kubectl apply -f "$manifest"
done

# Wait for deployments to be ready
echo -e "${YELLOW}⏳ Waiting for deployments to be ready...${NC}"
kubectl wait --for=condition=available --timeout=300s deployment/web-app -n ${NAMESPACE}
kubectl wait --for=condition=available --timeout=300s deployment/api-app -n ${NAMESPACE}

# Get service information
echo -e "${GREEN}🎉 Deployment completed successfully!${NC}"
echo ""
echo "📋 Deployment Summary:"
kubectl get pods -n ${NAMESPACE}
echo ""
kubectl get services -n ${NAMESPACE}

# Get access information
EXTERNAL_IP=$(kubectl get service web-service -n ${NAMESPACE} -o jsonpath='{.status.loadBalancer.ingress[0].ip}' 2>/dev/null || echo "pending")
if [ "$EXTERNAL_IP" != "pending" ] && [ "$EXTERNAL_IP" != "" ]; then
    echo ""
    echo -e "${GREEN}🌐 Application is accessible at: http://${EXTERNAL_IP}${NC}"
else
    echo ""
    echo -e "${YELLOW}📝 To access the application locally, run:${NC}"
    echo "kubectl port-forward service/web-service 8080:80 -n ${NAMESPACE}"
    echo "Then visit http://localhost:8080"
fi
