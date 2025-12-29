# Operations Runbook

## Daily Operations

### Health Checks

**Cluster Health:**
```bash
# Check node status
kubectl get nodes

# Check system pods
kubectl get pods -n kube-system

# Check resource usage
kubectl top nodes
kubectl top pods --all-namespaces
```

**Application Health:**
```bash
# Backstage
kubectl get pods -n backstage
kubectl logs -n backstage deployment/backstage

# Argo CD
kubectl get applications -n argocd
kubectl get pods -n argocd

# SigNoz
kubectl get pods -n observability
```

### Monitoring Dashboards

**SigNoz Access:**
```bash
# Port forward to access SigNoz
kubectl port-forward -n observability svc/signoz-frontend 3301:3301
# Open http://localhost:3301
```

**Key Metrics to Monitor:**
- CPU/Memory usage per namespace
- Pod restart counts
- Application response times
- Database connection pool status
- Certificate expiration dates

## Incident Response

### Backstage Down

**Symptoms:**
- HTTP 502/503 errors
- Login failures
- Slow response times

**Diagnosis:**
```bash
# Check pod status
kubectl get pods -n backstage

# Check logs
kubectl logs -n backstage deployment/backstage -c backstage
kubectl logs -n backstage deployment/backstage -c cloud-sql-proxy

# Check ingress
kubectl describe ingress -n backstage backstage-ingress

# Check certificates
kubectl get certificates -n backstage
```

**Resolution:**
```bash
# Restart deployment
kubectl rollout restart deployment/backstage -n backstage

# Check database connectivity
kubectl exec -it -n backstage deployment/backstage -c cloud-sql-proxy -- /bin/sh
# Test connection: nc -zv 127.0.0.1 5432
```

### Database Issues

**Symptoms:**
- Connection timeouts
- Slow queries
- Authentication failures

**Diagnosis:**
```bash
# Check Cloud SQL instance
gcloud sql instances describe backstage-db --project=docker-1210

# Check proxy logs
kubectl logs -n backstage deployment/backstage -c cloud-sql-proxy

# Check secrets
kubectl get secret backstage-secrets -n backstage -o yaml
```

**Resolution:**
```bash
# Restart Cloud SQL proxy
kubectl rollout restart deployment/backstage -n backstage

# Check database performance
gcloud sql operations list --instance=backstage-db --project=docker-1210
```

### Certificate Issues

**Symptoms:**
- TLS/SSL errors
- Certificate warnings in browser
- cert-manager errors

**Diagnosis:**
```bash
# Check certificates
kubectl get certificates --all-namespaces
kubectl describe certificate backstage-tls -n backstage

# Check cert-manager logs
kubectl logs -n cert-manager deployment/cert-manager

# Check DNS challenge
kubectl get challenges --all-namespaces
```

**Resolution:**
```bash
# Delete and recreate certificate
kubectl delete certificate backstage-tls -n backstage
# Certificate will be automatically recreated

# Check DNS records
gcloud dns record-sets list --zone=YOUR_ZONE --project=docker-1210
```

### Argo CD Sync Issues

**Symptoms:**
- Applications stuck in "Progressing"
- Sync failures
- Resource conflicts

**Diagnosis:**
```bash
# Check application status
kubectl get applications -n argocd
kubectl describe application backstage -n argocd

# Check Argo CD logs
kubectl logs -n argocd deployment/argocd-application-controller
```

**Resolution:**
```bash
# Force sync
kubectl patch application backstage -n argocd --type merge -p '{"operation":{"sync":{"syncStrategy":{"force":true}}}}'

# Refresh application
kubectl patch application backstage -n argocd --type merge -p '{"operation":{"info":[{"name":"refresh","value":"hard"}]}}'
```

## Maintenance Procedures

### Cluster Upgrades

**Pre-upgrade Checklist:**
- [ ] Backup critical data
- [ ] Check application compatibility
- [ ] Schedule maintenance window
- [ ] Notify users

**Upgrade Process:**
```bash
# Check available versions
gcloud container get-server-config --region=europe-west2

# Upgrade control plane
gcloud container clusters upgrade backstage-prod --region=europe-west2 --master

# Upgrade node pool
gcloud container clusters upgrade backstage-prod --region=europe-west2 --node-pool=backstage-prod-nodes
```

### Application Updates

**Backstage Updates:**
```bash
# Update image tag in deployment
kubectl set image deployment/backstage backstage=NEW_IMAGE -n backstage

# Monitor rollout
kubectl rollout status deployment/backstage -n backstage

# Rollback if needed
kubectl rollout undo deployment/backstage -n backstage
```

### Secret Rotation

**Database Password:**
```bash
# Generate new password
NEW_PASSWORD=$(openssl rand -base64 32)

# Update in Secret Manager
echo "$NEW_PASSWORD" | gcloud secrets versions add backstage-db-password --data-file=-

# Update database user
gcloud sql users set-password backstage --instance=backstage-db --password="$NEW_PASSWORD"

# Restart Backstage to pick up new secret
kubectl rollout restart deployment/backstage -n backstage
```

**GitHub Tokens:**
```bash
# Update token in Secret Manager
echo "NEW_TOKEN" | gcloud secrets versions add github-token --data-file=-

# Restart Backstage
kubectl rollout restart deployment/backstage -n backstage
```

## Backup and Recovery

### Database Backups

**Manual Backup:**
```bash
# Create on-demand backup
gcloud sql backups create --instance=backstage-db --project=docker-1210
```

**Restore from Backup:**
```bash
# List available backups
gcloud sql backups list --instance=backstage-db --project=docker-1210

# Restore (creates new instance)
gcloud sql backups restore BACKUP_ID --restore-instance=backstage-db-restored --project=docker-1210
```

### Configuration Backups

**GitOps Repository:**
- All Kubernetes manifests are version controlled
- Terraform state is stored in GCS with versioning
- Regular repository backups via GitHub

**Disaster Recovery:**
```bash
# Recreate infrastructure
cd infra/terraform/envs/prod
terraform apply

# Restore applications via Argo CD
kubectl apply -f platform/argocd/root-app.yaml
```

## Performance Tuning

### Resource Optimization

**Monitor Resource Usage:**
```bash
# Check resource requests vs usage
kubectl describe nodes
kubectl top pods --all-namespaces --sort-by=cpu
kubectl top pods --all-namespaces --sort-by=memory
```

**Adjust Resource Limits:**
```bash
# Update deployment resources
kubectl patch deployment backstage -n backstage -p '{"spec":{"template":{"spec":{"containers":[{"name":"backstage","resources":{"requests":{"cpu":"600m","memory":"1.5Gi"}}}]}}}}'
```

### Database Performance

**Monitor Queries:**
```bash
# Connect to database
kubectl exec -it -n backstage deployment/backstage -c cloud-sql-proxy -- psql -h 127.0.0.1 -U backstage -d backstage

# Check slow queries
SELECT query, mean_time, calls FROM pg_stat_statements ORDER BY mean_time DESC LIMIT 10;
```

## Security Operations

### Access Reviews

**Monthly Tasks:**
- Review GitHub OAuth app permissions
- Audit Kubernetes RBAC bindings
- Check certificate expiration dates
- Review Secret Manager access logs

**Commands:**
```bash
# Check RBAC
kubectl get rolebindings,clusterrolebindings --all-namespaces

# Check service accounts
kubectl get serviceaccounts --all-namespaces

# Check network policies
kubectl get networkpolicies --all-namespaces
```

### Vulnerability Management

**Container Scanning:**
```bash
# Scan images with Trivy
trivy image europe-west2-docker.pkg.dev/docker-1210/platform-images/backstage:latest
```

**Cluster Scanning:**
```bash
# Use kube-bench for CIS benchmarks
kubectl apply -f https://raw.githubusercontent.com/aquasecurity/kube-bench/main/job.yaml
kubectl logs job/kube-bench
```

## Troubleshooting Guide

### Common Issues

**Pod Stuck in Pending:**
```bash
kubectl describe pod POD_NAME -n NAMESPACE
# Check: resource constraints, node selectors, taints/tolerations
```

**ImagePullBackOff:**
```bash
kubectl describe pod POD_NAME -n NAMESPACE
# Check: image name, registry permissions, network connectivity
```

**DNS Resolution Issues:**
```bash
# Test DNS from pod
kubectl exec -it POD_NAME -n NAMESPACE -- nslookup kubernetes.default.svc.cluster.local
```

**Network Connectivity:**
```bash
# Test service connectivity
kubectl exec -it POD_NAME -n NAMESPACE -- nc -zv SERVICE_NAME PORT
```

### Log Analysis

**Centralized Logging:**
```bash
# View logs across all containers
kubectl logs -l app=backstage -n backstage --all-containers=true

# Follow logs in real-time
kubectl logs -f deployment/backstage -n backstage -c backstage
```

**SigNoz Integration:**
- All application logs are automatically collected
- Use SigNoz UI for advanced log analysis
- Set up alerts for error patterns

## Contact Information

**Escalation Path:**
1. Platform Team (primary)
2. Infrastructure Team (secondary)
3. On-call Engineer (emergency)

**Emergency Procedures:**
- Critical issues: Page on-call engineer
- Security incidents: Follow incident response plan
- Data loss: Immediate backup restoration
