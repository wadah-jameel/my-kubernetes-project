### 4.2 Architecture Documentation (docs/architecture.md)
```markdown
# Architecture Overview

## System Components

### 1. Frontend (Nginx)
- **Purpose**: Serves static web content
- **Image**: nginx:1.21-alpine
- **Replicas**: 3 for high availability
- **Port**: 80
- **Service Type**: LoadBalancer (external access)

### 2. Backend API (Node.js)
- **Purpose**: Provides REST API endpoints
- **Image**: node:16-alpine
- **Replicas**: 2
- **Port**: 3000
- **Service Type**: ClusterIP (internal only)

### 3. Configuration Management
- **ConfigMaps**: Store application configuration
- **Environment Variables**: Injected into containers
- **Secrets**: For sensitive data (passwords, tokens)

## Resource Specifications

### Pod Resources
```yaml
resources:
  requests:
    memory: "64Mi"    # Minimum memory
    cpu: "50m"        # Minimum CPU (0.05 cores)
  limits:
    memory: "128Mi"   # Maximum memory
    cpu: "100m"       # Maximum CPU (0.1 cores)
