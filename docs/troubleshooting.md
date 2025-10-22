### 4.4 Troubleshooting Guide (docs/troubleshooting.md)
```markdown
# Troubleshooting Guide

## Common Issues and Solutions

### 1. Pods Not Starting

**Symptoms:**
- Pods stuck in `Pending` state
- Pods in `CrashLoopBackOff`

**Diagnosis:**
```bash
# Check pod status
kubectl get pods -n my-app

# Describe pod for events
kubectl describe pod <pod-name> -n my-app

# Check logs
kubectl logs <pod-name> -n my-app
