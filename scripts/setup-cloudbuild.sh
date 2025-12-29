#!/bin/bash
set -e

PROJECT_ID="docker-1210"
REGION="europe-west2"
REPO_OWNER="kofiray"
REPO_NAME="backstage-platform"

echo "🔧 Setting up Cloud Build trigger for Backstage..."

# Enable required APIs
echo "📡 Enabling required APIs..."
gcloud services enable cloudbuild.googleapis.com --project=$PROJECT_ID
gcloud services enable artifactregistry.googleapis.com --project=$PROJECT_ID

# Connect GitHub repository to Cloud Build
echo "🔗 Connecting GitHub repository..."
gcloud builds connections create github "github-connection" \
  --region=$REGION \
  --project=$PROJECT_ID || echo "Connection may already exist"

# Create Cloud Build trigger
echo "🚀 Creating Cloud Build trigger..."
gcloud builds triggers create github \
  --project=$PROJECT_ID \
  --region=$REGION \
  --repo-name=$REPO_NAME \
  --repo-owner=$REPO_OWNER \
  --branch-pattern="^main$" \
  --build-config=ci/cloudbuild.yaml \
  --name="backstage-build" \
  --description="Build and deploy Backstage application" \
  --included-files="backstage/**" || echo "Trigger may already exist"

echo "✅ Cloud Build trigger created!"
echo ""
echo "📋 Next steps:"
echo "1. Go to Cloud Build console to authorize GitHub connection"
echo "2. Push changes to trigger the first build"
echo "3. Images will be built and pushed to: europe-west2-docker.pkg.dev/$PROJECT_ID/platform-images/backstage"
