#!/bin/bash
# cleanup.sh - Clean up Kubernetes resources

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

NAMESPACE="my-app"

echo -e "${YELLOW}🧹 Starting cleanup...${NC}"

# Check if namespace exists
if kubectl get namespace ${NAMESPACE} &> /dev/null; then
    echo -e "${YELLOW}📦 Deleting all resources in namespace ${NAMESPACE}...${NC}"
    
    # Delete all resources in namespace
    kubectl delete all --all -n ${NAMESPACE}
    
    # Delete configmaps and secrets
    kubectl delete configmap --all -n ${NAMESPACE}
    kubectl delete secret --all -n ${NAMESPACE}
    
    # Delete the namespace
    kubectl delete namespace ${NAMESPACE}
    
    echo -e "${GREEN}✅ Cleanup completed successfully!${NC}"
else
    echo -e "${YELLOW}⚠️  Namespace ${NAMESPACE} not found${NC}"
fi
