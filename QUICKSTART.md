# Quick Start Guide

## Prerequisites Setup

Before deploying, you need to set up authentication keys and secrets.

### 1. GitHub OAuth Application

1. Go to GitHub Settings → Developer settings → OAuth Apps
2. Click "New OAuth App"
3. Fill in:
   - **Application name**: `Backstage Platform`
   - **Homepage URL**: `https://backstage.YOUR_DOMAIN` (replace with your domain)
   - **Authorization callback URL**: `https://backstage.YOUR_DOMAIN/api/auth/github/handler/frame`
4. Save the **Client ID** and **Client Secret**

### 2. GitHub Personal Access Token

1. Go to GitHub Settings → Developer settings → Personal access tokens → Tokens (classic)
2. Generate new token with scopes:
   - `repo` (Full control of private repositories)
   - `read:org` (Read org and team membership)
   - `read:user` (Read user profile data)
   - `user:email` (Access user email addresses)
3. Save the token

### 3. Azure DevOps (Optional)

If you want Azure DevOps integration:
1. Go to Azure DevOps → User settings → Personal access tokens
2. Create token with scopes: `Build (read)`, `Code (read)`, `Project and team (read)`
3. Save the token and organization name

## Deployment Steps

### Step 1: Set Up Secrets

Run the setup script to create all required secrets:

```bash
./scripts/setup-secrets.sh
```

This will prompt you for:
- GitHub OAuth Client ID and Secret
- GitHub Personal Access Token  
- Azure DevOps credentials (optional)

### Step 2: Configure DNS

Edit `infra/terraform/envs/prod/terraform.tfvars`:

```hcl
# If you have a specific domain
domain_name = "yourdomain.com"

# OR if you have multiple DNS zones, force selection
# force_zone_selection = "your-zone-name"

# GitHub repository
github_repo_owner = "your-github-org"
github_repo_name  = "backstage-platform"
```

### Step 3: Deploy Infrastructure

```bash
# Create Terraform state bucket
gsutil mb -p docker-1210 -l europe-west2 gs://backstage-terraform-state-docker-1210

# Deploy infrastructure
cd infra/terraform/envs/prod
terraform init
terraform apply
```

### Step 4: Bootstrap Argo CD

```bash
# Get cluster credentials
gcloud container clusters get-credentials backstage-prod --region europe-west2

# Install Argo CD
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Wait for Argo CD
kubectl wait --for=condition=available --timeout=300s deployment/argocd-server -n argocd

# Apply root application
kubectl apply -f platform/argocd/root-app.yaml
```

### Step 5: Update Service Account Token

After the cluster is deployed and Backstage namespace is created:

```bash
./scripts/update-k8s-token.sh
```

### Step 6: Set Up Cloud Build

Set up the Cloud Build trigger for automatic image building:

```bash
./scripts/setup-cloudbuild.sh
```

This will:
- Enable required APIs
- Connect your GitHub repository to Cloud Build
- Create a trigger that builds on pushes to main branch

**Manual Build (Optional):**
```bash
./scripts/build-backstage.sh
```

### Step 7: Build and Deploy Backstage

**Option A: Automatic (Recommended)**
Push any change to trigger the build:
```bash
git add .
git commit -m "Trigger initial build"
git push origin main
```

**Option B: Manual Build**
```bash
./scripts/build-backstage.sh
```

The build process:
1. ✅ Builds Backstage Docker image
2. ✅ Scans for security vulnerabilities with Trivy
3. ✅ Pushes to Artifact Registry: `europe-west2-docker.pkg.dev/docker-1210/platform-images/backstage`
4. ✅ Updates GitOps manifests with new image tag
5. ✅ Argo CD automatically deploys the new image

### Step 8: Access Applications

- **Backstage**: `https://backstage.YOUR_DOMAIN`
- **Argo CD**: `https://argocd.YOUR_DOMAIN`
- **SigNoz**: `kubectl port-forward -n observability svc/signoz-frontend 3301:3301`

## Initial Argo CD Setup

1. Get the initial admin password:
```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

2. Login to Argo CD UI and change the password

3. Update the new password in Secret Manager:
```bash
echo "NEW_PASSWORD" | gcloud secrets versions add argocd-password --data-file=-
```

## Verification

Check that everything is working:

```bash
# Check all applications are synced
kubectl get applications -n argocd

# Check Backstage is running
kubectl get pods -n backstage

# Test Backstage health
curl -f https://backstage.YOUR_DOMAIN/api/catalog/health
```

## Troubleshooting

### DNS Issues
- Verify DNS zone: `gcloud dns managed-zones list`
- Check propagation: `dig backstage.YOUR_DOMAIN`

### Certificate Issues  
- Check cert-manager: `kubectl logs -n cert-manager deployment/cert-manager`
- Verify certificates: `kubectl get certificates --all-namespaces`

### Backstage Issues
- Check logs: `kubectl logs -n backstage deployment/backstage`
- Verify secrets: `kubectl get secrets -n backstage`

## What You Get

After successful deployment:

✅ **Production GKE cluster** (3 nodes, europe-west2)  
✅ **Backstage.io** with GitHub OAuth and all integrations  
✅ **GitOps via Argo CD** with app-of-apps pattern  
✅ **SigNoz observability** with custom Backstage integration  
✅ **Golden path templates** for immediate productivity  
✅ **Complete CI/CD** with security scanning  

The platform is ready for teams to start creating services using the Scaffolder templates!
