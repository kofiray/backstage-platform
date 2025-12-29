#!/bin/bash
set -e

PROJECT_ID="docker-1210"
REGION="europe-west2"

echo "🐳 Building Backstage image manually..."

# Ensure we're in the right directory
cd "$(dirname "$0")/.."

# Submit build to Cloud Build
gcloud builds submit \
  --config=ci/cloudbuild.yaml \
  --project=$PROJECT_ID \
  --region=$REGION \
  .

echo "✅ Build submitted to Cloud Build!"
echo "📊 Check status: gcloud builds list --project=$PROJECT_ID --limit=5"
