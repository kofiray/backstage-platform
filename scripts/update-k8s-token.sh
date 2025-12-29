#!/bin/bash
set -e

PROJECT_ID="docker-1210"
REGION="europe-west2"
CLUSTER_NAME="backstage-prod"

echo "🔄 Updating Kubernetes service account token..."

# Get cluster credentials
gcloud container clusters get-credentials $CLUSTER_NAME --region $REGION --project $PROJECT_ID

# Wait for backstage namespace and service account
echo "⏳ Waiting for backstage namespace and service account..."
kubectl wait --for=condition=Ready namespace/backstage --timeout=300s || true
kubectl wait --for=jsonpath='{.metadata.name}' serviceaccount/backstage -n backstage --timeout=300s || true

# Create service account token
echo "🎫 Creating service account token..."
TOKEN=$(kubectl create token backstage -n backstage --duration=8760h)

# Update secret in Secret Manager
echo "$TOKEN" | gcloud secrets versions add backstage-k8s-token --data-file=-

echo "✅ Kubernetes service account token updated successfully!"
