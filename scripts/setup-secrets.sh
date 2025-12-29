#!/bin/bash
set -e

PROJECT_ID="docker-1210"
REGION="europe-west2"

echo "🔐 Setting up secrets for Backstage platform..."

# Check if gcloud is authenticated
if ! gcloud auth list --filter=status:ACTIVE --format="value(account)" | grep -q .; then
    echo "❌ Please authenticate with gcloud first: gcloud auth login"
    exit 1
fi

# Set project
gcloud config set project $PROJECT_ID

# Use provided GitHub OAuth credentials (TEST ENVIRONMENT)
GITHUB_CLIENT_ID="Ov23liUZbbZAF6bx51Rc"
GITHUB_CLIENT_SECRET="7a686d349177c50ab01d13afc2b441f57b154922"

echo "📝 Please provide the following information:"

# GitHub Personal Access Token
read -s -p "GitHub Personal Access Token (with repo, read:org, read:user, user:email scopes): " GITHUB_TOKEN
echo

# Azure DevOps (optional)
read -p "Azure DevOps Organization (optional, press enter to skip): " AZURE_ORG
if [ ! -z "$AZURE_ORG" ]; then
    read -s -p "Azure DevOps Personal Access Token: " AZURE_TOKEN
    echo
fi

# Argo CD credentials
ARGOCD_PASSWORD=$(openssl rand -base64 32)
echo "Generated Argo CD admin password: $ARGOCD_PASSWORD"

echo "🔒 Creating secrets in Google Secret Manager..."

# Create GitHub secrets
echo "$GITHUB_CLIENT_ID" | gcloud secrets create github-oauth-client-id --data-file=- --replication-policy=automatic || \
    echo "$GITHUB_CLIENT_ID" | gcloud secrets versions add github-oauth-client-id --data-file=-

echo "$GITHUB_CLIENT_SECRET" | gcloud secrets create github-oauth-client-secret --data-file=- --replication-policy=automatic || \
    echo "$GITHUB_CLIENT_SECRET" | gcloud secrets versions add github-oauth-client-secret --data-file=-

echo "$GITHUB_TOKEN" | gcloud secrets create github-token --data-file=- --replication-policy=automatic || \
    echo "$GITHUB_TOKEN" | gcloud secrets versions add github-token --data-file=-

# Create Argo CD secrets
echo "admin" | gcloud secrets create argocd-username --data-file=- --replication-policy=automatic || \
    echo "admin" | gcloud secrets versions add argocd-username --data-file=-

echo "$ARGOCD_PASSWORD" | gcloud secrets create argocd-password --data-file=- --replication-policy=automatic || \
    echo "$ARGOCD_PASSWORD" | gcloud secrets versions add argocd-password --data-file=-

# Create placeholder auth token (will be updated after Argo CD deployment)
echo "placeholder" | gcloud secrets create argocd-auth-token --data-file=- --replication-policy=automatic || \
    echo "placeholder" | gcloud secrets versions add argocd-auth-token --data-file=-

# Create Azure DevOps secrets (if provided)
if [ ! -z "$AZURE_TOKEN" ]; then
    echo "$AZURE_TOKEN" | gcloud secrets create azure-devops-token --data-file=- --replication-policy=automatic || \
        echo "$AZURE_TOKEN" | gcloud secrets versions add azure-devops-token --data-file=-
else
    echo "placeholder" | gcloud secrets create azure-devops-token --data-file=- --replication-policy=automatic || \
        echo "placeholder" | gcloud secrets versions add azure-devops-token --data-file=-
fi

# Create placeholder for Kubernetes service account token (will be created after cluster deployment)
echo "placeholder" | gcloud secrets create backstage-k8s-token --data-file=- --replication-policy=automatic || \
    echo "placeholder" | gcloud secrets versions add backstage-k8s-token --data-file=-

echo "✅ Secrets created successfully!"
echo ""
echo "🔑 GitHub OAuth configured:"
echo "   Client ID: $GITHUB_CLIENT_ID"
echo "   Callback URL: https://backstage.kofiray.net/api/auth/github/handler/frame"
echo ""
echo "📋 Next steps:"
echo "1. Deploy infrastructure: cd infra/terraform/envs/prod && terraform apply"
echo "2. Set up Cloud Build: ./scripts/setup-cloudbuild.sh"
echo "3. Update Kubernetes service account token after cluster deployment"
echo "4. Update Argo CD auth token after Argo CD deployment"
echo ""
echo "🔑 Save this Argo CD admin password: $ARGOCD_PASSWORD"
