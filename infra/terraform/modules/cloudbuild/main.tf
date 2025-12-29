variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "github_repo_owner" {
  description = "GitHub repository owner"
  type        = string
}

variable "github_repo_name" {
  description = "GitHub repository name"
  type        = string
}

variable "artifact_registry_url" {
  description = "Artifact Registry URL"
  type        = string
}

variable "cloudbuild_service_account" {
  description = "Cloud Build service account email"
  type        = string
}

# Enable Cloud Build API
resource "google_project_service" "cloudbuild" {
  project = var.project_id
  service = "cloudbuild.googleapis.com"
}

# Cloud Build trigger for Backstage - disabled for initial deployment
/*
resource "google_cloudbuild_trigger" "backstage_build" {
  project  = var.project_id
  name     = "backstage-build"
  location = var.region

  github {
    owner = var.github_repo_owner
    name  = var.github_repo_name
    push {
      branch = "^main$"
    }
  }

  included_files = ["backstage/**"]

  build {
    step {
      name = "gcr.io/cloud-builders/docker"
      args = [
        "build",
        "-t", "${var.artifact_registry_url}/backstage:$COMMIT_SHA",
        "-t", "${var.artifact_registry_url}/backstage:latest",
        "-f", "backstage/Dockerfile",
        "backstage/"
      ]
    }

    step {
      name = "gcr.io/cloud-builders/docker"
      args = [
        "push", "${var.artifact_registry_url}/backstage:$COMMIT_SHA"
      ]
    }

    step {
      name = "gcr.io/cloud-builders/docker"
      args = [
        "push", "${var.artifact_registry_url}/backstage:latest"
      ]
    }

    # Update GitOps repo with new image tag
    step {
      name = "gcr.io/cloud-builders/git"
      args = [
        "clone", "https://github.com/${var.github_repo_owner}/${var.github_repo_name}.git", "/workspace/repo"
      ]
    }

    step {
      name = "gcr.io/cloud-builders/gcloud"
      script = <<-EOT
        #!/bin/bash
        cd /workspace/repo
        
        # Update image tag in Backstage deployment
        sed -i "s|image: ${var.artifact_registry_url}/backstage:.*|image: ${var.artifact_registry_url}/backstage:$COMMIT_SHA|g" platform/manifests/backstage/deployment.yaml
        
        # Commit and push changes
        git config user.email "cloudbuild@${var.project_id}.iam.gserviceaccount.com"
        git config user.name "Cloud Build"
        git add platform/manifests/backstage/deployment.yaml
        git commit -m "Update Backstage image to $COMMIT_SHA" || exit 0
        git push origin main
      EOT
    }

    options {
      logging = "CLOUD_LOGGING_ONLY"
    }
  }

  service_account = var.cloudbuild_service_account

  depends_on = [google_project_service.cloudbuild]
}

# Cloud Build trigger for infrastructure validation - disabled for initial deployment
/*
resource "google_cloudbuild_trigger" "infra_validation" {
  project  = var.project_id
  name     = "infra-validation"
  location = var.region

  github {
    owner = var.github_repo_owner
    name  = var.github_repo_name
    pull_request {
      branch = ".*"
    }
  }

  included_files = ["infra/**", "platform/**"]

  build {
    step {
      name = "hashicorp/terraform:1.6"
      dir  = "infra/terraform/envs/prod"
      args = ["fmt", "-check"]
    }

    step {
      name = "hashicorp/terraform:1.6"
      dir  = "infra/terraform/envs/prod"
      args = ["init"]
    }

    step {
      name = "hashicorp/terraform:1.6"
      dir  = "infra/terraform/envs/prod"
      args = ["validate"]
    }

    step {
      name = "hashicorp/terraform:1.6"
      dir  = "infra/terraform/envs/prod"
      args = ["plan"]
    }

    # Helm lint
    step {
      name = "alpine/helm:3.13.0"
      dir  = "platform/manifests"
      script = <<-EOT
        #!/bin/sh
        find . -name "Chart.yaml" -exec dirname {} \; | while read chart_dir; do
          echo "Linting $chart_dir"
          helm lint "$chart_dir"
        done
      EOT
    }

    # Kubeconform validation
    step {
      name = "ghcr.io/yannh/kubeconform:latest"
      dir  = "platform/manifests"
      script = <<-EOT
        #!/bin/sh
        find . -name "*.yaml" -o -name "*.yml" | grep -v Chart.yaml | while read file; do
          echo "Validating $file"
          kubeconform -summary -output json "$file"
        done
      EOT
    }

    options {
      logging = "CLOUD_LOGGING_ONLY"
    }
  }

  service_account = var.cloudbuild_service_account

  depends_on = [google_project_service.cloudbuild]
}
*/

# IAM bindings for Cloud Build service account
resource "google_project_iam_member" "cloudbuild_editor" {
  project = var.project_id
  role    = "roles/editor"
  member  = "serviceAccount:${var.cloudbuild_service_account}"
}

resource "google_project_iam_member" "cloudbuild_source_admin" {
  project = var.project_id
  role    = "roles/source.admin"
  member  = "serviceAccount:${var.cloudbuild_service_account}"
}

# Outputs disabled while triggers are commented out
/*
output "backstage_trigger_id" {
  description = "Backstage build trigger ID"
  value       = google_cloudbuild_trigger.backstage_build.trigger_id
}

output "infra_trigger_id" {
  description = "Infrastructure validation trigger ID"
  value       = google_cloudbuild_trigger.infra_validation.trigger_id
}
*/
