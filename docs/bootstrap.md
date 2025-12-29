# Bootstrap Guide

This guide walks you through deploying the complete Backstage.io platform on GKE.

## Prerequisites

- `gcloud` CLI authenticated to `docker-1210` project
- `terraform` >= 1.5
- `kubectl` configured
- GitHub repository created for this platform

## Step 1: Configure Variables

1. Copy the example tfvars:
```bash
cd infra/terraform/envs/prod
cp terraform.tfvars.example terraform.tfvars
```

2. Edit `terraform.tfvars`:
```hcl
project_id = "docker-1210"
region     = "europe-west2"
cluster_name = "backstage-prod"

# DNS Configuration (choose one)
# domain_name = "yourdomain.com"  # If you have a specific domain
# force_zone_selection = "your-zone-name"  # If multiple zones exist

# GitHub Configuration
github_repo_owner = "your-github-org"
github_repo_name  = "backstage-platform"
```

## Step 2: Create GCS Backend Bucket

```bash
gsutil mb -p docker-1210 -l europe-west2 gs://backstage-terraform-state-docker-1210
gsutil versioning set on gs://backstage-terraform-state-docker-1210
```

## Step 3: Deploy Infrastructure

```bash
cd infra/terraform/envs/prod
terraform init
terraform plan
terraform apply
```

**Note the outputs** - you'll need the DNS zone information and service account emails.

## Step 4: Create Required Secrets

Create secrets in Google Secret Manager:

```bash
# Database password (auto-created by Terraform)
# GitHub OAuth credentials
gcloud secrets create github-oauth-client-id --data-file=- <<< "your-github-client-id"
gcloud secrets create github-oauth-client-secret --data-file=- <<< "your-github-client-secret"

# GitHub token for API access
gcloud secrets create github-token --data-file=- <<< "your-github-token"

# Argo CD credentials
gcloud secrets create argocd-username --data-file=- <<< "admin"
gcloud secrets create argocd-password --data-file=- <<< "$(openssl rand -base64 32)"

# Azure DevOps (optional)
gcloud secrets create azure-devops-token --data-file=- <<< "your-azure-token"

# Kubernetes service account token
kubectl create token backstage -n backstage | gcloud secrets create backstage-k8s-token --data-file=-
```

## Step 5: Configure GitHub OAuth

1. Go to GitHub Settings > Developer settings > OAuth Apps
2. Create new OAuth App:
   - **Application name**: Backstage Platform
   - **Homepage URL**: `https://backstage.YOUR_DOMAIN`
   - **Authorization callback URL**: `https://backstage.YOUR_DOMAIN/api/auth/github/handler/frame`
3. Update the client ID and secret in Secret Manager

## Step 6: Bootstrap Argo CD

```bash
# Get cluster credentials
gcloud container clusters get-credentials backstage-prod --region europe-west2

# Install Argo CD
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Wait for Argo CD to be ready
kubectl wait --for=condition=available --timeout=300s deployment/argocd-server -n argocd

# Apply the root application
kubectl apply -f platform/argocd/root-app.yaml
```

## Step 7: Configure DNS Records

Update the ingress manifests with your actual domain:

```bash
# Replace example.com with your domain in:
# - platform/manifests/backstage/ingress.yaml
# - backstage/templates/microservice/skeleton/k8s/deployment.yaml
```

## Step 8: Verify Deployment

```bash
# Check Argo CD applications
kubectl get applications -n argocd

# Check Backstage deployment
kubectl get pods -n backstage

# Check SigNoz
kubectl get pods -n observability

# Get ingress IP
kubectl get ingress -n backstage
```

## Step 9: Access Applications

- **Backstage**: `https://backstage.YOUR_DOMAIN`
- **Argo CD**: `https://argocd.YOUR_DOMAIN`
- **SigNoz**: Port-forward: `kubectl port-forward -n observability svc/signoz-frontend 3301:3301`

## Step 10: Initial Argo CD Setup

```bash
# Get initial admin password
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

# Login to Argo CD UI and change password
# Update the password in Secret Manager
```

## Troubleshooting

### DNS Issues
- Verify your DNS zone exists: `gcloud dns managed-zones list`
- Check DNS propagation: `dig backstage.YOUR_DOMAIN`

### Certificate Issues
- Check cert-manager logs: `kubectl logs -n cert-manager deployment/cert-manager`
- Verify cluster issuer: `kubectl get clusterissuer`

### Backstage Issues
- Check logs: `kubectl logs -n backstage deployment/backstage`
- Verify secrets: `kubectl get secrets -n backstage`

### Database Connection
- Test Cloud SQL proxy: `kubectl exec -it -n backstage deployment/backstage -c cloud-sql-proxy -- /bin/sh`

## Next Steps

1. Configure team access in GitHub OAuth settings
2. Add your first service using the Scaffolder template
3. Set up monitoring alerts in SigNoz
4. Configure backup policies for persistent data
