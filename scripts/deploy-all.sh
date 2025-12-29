#!/bin/bash
set -e

PROJECT_ID="docker-1210"

echo "🚀 Quick deployment script for test environment"
echo "⚠️  WARNING: This uses hardcoded credentials for testing only!"

# Set up secrets
echo "🔐 Setting up secrets..."
./scripts/setup-secrets.sh

# Deploy infrastructure
echo "🏗️  Deploying infrastructure..."
cd infra/terraform/envs/prod

# Create state bucket if it doesn't exist
gsutil mb -p $PROJECT_ID -l europe-west2 gs://backstage-terraform-state-$PROJECT_ID 2>/dev/null || echo "Bucket already exists"

terraform init
terraform apply -auto-approve

cd ../../../..

# Set up Cloud Build
echo "🔧 Setting up Cloud Build..."
./scripts/setup-cloudbuild.sh

# Bootstrap Argo CD
echo "🎯 Bootstrapping Argo CD..."
gcloud container clusters get-credentials backstage-prod --region europe-west2 --project $PROJECT_ID

kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "⏳ Waiting for Argo CD to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/argocd-server -n argocd

kubectl apply -f platform/argocd/root-app.yaml

# Update K8s token
echo "🎫 Updating Kubernetes service account token..."
sleep 30  # Wait for backstage namespace to be created
./scripts/update-k8s-token.sh

# Trigger first build
echo "🐳 Triggering first Backstage build..."
git add .
git commit -m "Deploy: Complete platform deployment" || echo "No changes to commit"
git push origin main

echo ""
echo "🎉 Deployment complete!"
echo ""
echo "📊 Check status:"
echo "   Argo CD Apps: kubectl get applications -n argocd"
echo "   Backstage: kubectl get pods -n backstage"
echo ""
echo "🌐 Access URLs (after DNS propagation):"
echo "   Backstage: https://backstage.kofiray.net"
echo "   Argo CD: https://argocd.kofiray.net"
echo ""
echo "🔑 Get Argo CD admin password:"
echo "   kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d"
