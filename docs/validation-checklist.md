# Validation Checklist

## Pre-Deployment Validation

### Infrastructure Readiness
- [ ] Terraform plan shows expected resources
- [ ] DNS zone exists and is accessible
- [ ] GCP APIs are enabled
- [ ] Service accounts have correct permissions
- [ ] GCS bucket for Terraform state exists

### Security Configuration
- [ ] Secrets created in Secret Manager
- [ ] GitHub OAuth app configured
- [ ] Workload Identity bindings verified
- [ ] Network policies applied
- [ ] Pod Security Admission labels set

## Post-Deployment Validation

### Cluster Health
```bash
# Verify cluster is running
kubectl cluster-info

# Check all nodes are ready
kubectl get nodes
# Expected: 3 nodes in Ready state

# Verify system pods
kubectl get pods -n kube-system
# Expected: All pods Running/Completed
```

### Platform Services
```bash
# Check Argo CD
kubectl get pods -n argocd
kubectl get applications -n argocd
# Expected: All applications Synced and Healthy

# Check cert-manager
kubectl get pods -n cert-manager
kubectl get clusterissuers
# Expected: letsencrypt-prod Ready=True

# Check External Secrets
kubectl get pods -n external-secrets
kubectl get clustersecretstore
# Expected: gcpsm-cluster-store Ready=True
```

### Observability Stack
```bash
# Check SigNoz components
kubectl get pods -n observability
# Expected: clickhouse, signoz-query-service, signoz-frontend, otel-collector Running

# Verify SigNoz accessibility
kubectl port-forward -n observability svc/signoz-frontend 3301:3301 &
curl -f http://localhost:3301
# Expected: HTTP 200 response
```

### Backstage Application
```bash
# Check Backstage deployment
kubectl get pods -n backstage
kubectl get secrets -n backstage
# Expected: backstage pods Running, secrets present

# Verify database connectivity
kubectl logs -n backstage deployment/backstage -c cloud-sql-proxy
# Expected: No connection errors

# Check ingress and certificates
kubectl get ingress -n backstage
kubectl get certificates -n backstage
# Expected: Ingress has IP, certificate Ready=True
```

## Functional Testing

### DNS Resolution
```bash
# Test DNS records
nslookup backstage.YOUR_DOMAIN
nslookup argocd.YOUR_DOMAIN
# Expected: Records resolve to ingress IP
```

### TLS Certificates
```bash
# Test certificate validity
echo | openssl s_client -servername backstage.YOUR_DOMAIN -connect backstage.YOUR_DOMAIN:443 2>/dev/null | openssl x509 -noout -dates
# Expected: Valid certificate with future expiration
```

### Application Access
```bash
# Test Backstage health endpoint
curl -f https://backstage.YOUR_DOMAIN/api/catalog/health
# Expected: {"status":"ok"}

# Test Argo CD API
curl -f https://argocd.YOUR_DOMAIN/api/version
# Expected: Version information returned
```

### GitHub OAuth Integration
**Manual Test:**
1. Navigate to `https://backstage.YOUR_DOMAIN`
2. Click "Sign In"
3. Authenticate with GitHub
4. Verify successful login and user profile

**Expected Results:**
- [ ] GitHub OAuth flow completes successfully
- [ ] User profile displays correctly
- [ ] Catalog shows sample entities

### Kubernetes Plugin Integration
**Manual Test:**
1. Navigate to sample component in catalog
2. Click on "Kubernetes" tab
3. Verify cluster information displays

**Expected Results:**
- [ ] Kubernetes tab shows cluster data
- [ ] Pods, services, deployments visible
- [ ] No permission errors

### Argo CD Integration
**Manual Test:**
1. Navigate to Backstage component with Argo CD annotation
2. Check deployment status section
3. Verify Argo CD application link works

**Expected Results:**
- [ ] Deployment status shows "Synced"
- [ ] Link to Argo CD application works
- [ ] Application details visible

### GitHub Actions Integration
**Manual Test:**
1. Navigate to component with GitHub repository
2. Check CI/CD tab or workflows section
3. Verify workflow runs display

**Expected Results:**
- [ ] GitHub Actions workflows visible
- [ ] Workflow status updates correctly
- [ ] Links to GitHub work

### SigNoz Integration
**Manual Test:**
1. Navigate to component with SigNoz annotations
2. Look for "View in SigNoz" button
3. Click button and verify redirect

**Expected Results:**
- [ ] SigNoz card displays on entity page
- [ ] "View in SigNoz" button works
- [ ] SigNoz dashboard loads correctly

### Scaffolder Templates
**Manual Test:**
1. Navigate to "Create Component" in Backstage
2. Select "New Microservice on GKE" template
3. Fill out form and create component
4. Verify GitOps deployment

**Expected Results:**
- [ ] Template form loads correctly
- [ ] Repository created successfully
- [ ] Argo CD application created
- [ ] Component appears in catalog
- [ ] Kubernetes resources deployed

## Performance Validation

### Resource Usage
```bash
# Check cluster resource utilization
kubectl top nodes
kubectl top pods --all-namespaces

# Verify resource limits are respected
kubectl describe nodes | grep -A 5 "Allocated resources"
```

**Expected Results:**
- [ ] CPU usage < 80% per node
- [ ] Memory usage < 80% per node
- [ ] No pods in OOMKilled state

### Application Response Times
```bash
# Test Backstage API response time
time curl -s https://backstage.YOUR_DOMAIN/api/catalog/entities > /dev/null
# Expected: < 2 seconds

# Test SigNoz response time
time curl -s http://localhost:3301 > /dev/null
# Expected: < 3 seconds
```

### Database Performance
```bash
# Check database connections
kubectl exec -n backstage deployment/backstage -c backstage -- netstat -an | grep :5432
# Expected: Established connections, no excessive count
```

## Security Validation

### Network Policies
```bash
# Test network isolation
kubectl run test-pod --image=busybox --rm -it -- /bin/sh
# Try to access services from different namespaces
# Expected: Blocked by network policies where appropriate
```

### Pod Security
```bash
# Verify pod security contexts
kubectl get pods -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.spec.securityContext}{"\n"}{end}' --all-namespaces
# Expected: Non-root users, read-only filesystems where possible
```

### Secret Management
```bash
# Verify secrets are not in plain text
kubectl get secrets --all-namespaces -o yaml | grep -i password
# Expected: All values base64 encoded

# Check External Secrets sync
kubectl get externalsecrets --all-namespaces
# Expected: All secrets show "SecretSynced=True"
```

## Disaster Recovery Testing

### Backup Verification
```bash
# Check Cloud SQL backups
gcloud sql backups list --instance=backstage-db --project=docker-1210
# Expected: Recent automated backups present

# Verify Terraform state backup
gsutil ls gs://backstage-terraform-state-docker-1210/
# Expected: State files with recent timestamps
```

### Recovery Procedures
**Test Recovery (Non-Production):**
1. Delete a non-critical application
2. Verify Argo CD recreates it
3. Test database connection after pod restart

**Expected Results:**
- [ ] Applications self-heal via Argo CD
- [ ] Database connections restore automatically
- [ ] No data loss during pod restarts

## Monitoring and Alerting

### SigNoz Configuration
**Manual Verification:**
1. Access SigNoz dashboard
2. Check for incoming metrics and traces
3. Verify Backstage application appears in services

**Expected Results:**
- [ ] Metrics flowing from all components
- [ ] Traces visible for HTTP requests
- [ ] Logs aggregated correctly

### Health Checks
```bash
# Verify all health endpoints
curl -f https://backstage.YOUR_DOMAIN/api/catalog/health
kubectl get --raw="/healthz"
# Expected: All return healthy status
```

## Final Validation Checklist

### URLs Accessible
- [ ] `https://backstage.YOUR_DOMAIN` - Backstage UI loads
- [ ] `https://argocd.YOUR_DOMAIN` - Argo CD UI loads
- [ ] SigNoz dashboard accessible via port-forward

### Authentication Working
- [ ] GitHub OAuth login successful
- [ ] User permissions correct
- [ ] Session persistence works

### Integrations Functional
- [ ] Kubernetes plugin shows cluster data
- [ ] Argo CD status visible in Backstage
- [ ] GitHub Actions workflows display
- [ ] SigNoz links work correctly

### Golden Paths Working
- [ ] Microservice template creates working deployment
- [ ] Generated service appears in catalog
- [ ] GitOps deployment successful
- [ ] All integrations work for generated service

### Operations Ready
- [ ] Monitoring dashboards accessible
- [ ] Log aggregation working
- [ ] Backup procedures tested
- [ ] Documentation complete and accessible

## Troubleshooting Failed Validations

### Common Issues and Solutions

**DNS Not Resolving:**
- Check DNS zone configuration
- Verify ingress IP assignment
- Wait for DNS propagation (up to 24 hours)

**Certificate Issues:**
- Check cert-manager logs
- Verify DNS-01 challenge completion
- Ensure Cloud DNS permissions correct

**Backstage Login Fails:**
- Verify GitHub OAuth configuration
- Check callback URL matches exactly
- Confirm secrets are correctly synced

**Kubernetes Plugin Empty:**
- Verify service account permissions
- Check cluster connectivity
- Confirm annotations on entities

**Argo CD Not Syncing:**
- Check repository access permissions
- Verify application definitions
- Review Argo CD controller logs

**Performance Issues:**
- Check resource quotas and limits
- Monitor node resource usage
- Review application logs for bottlenecks
