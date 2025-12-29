variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "repository_name" {
  description = "Artifact Registry repository name"
  type        = string
  default     = "platform-images"
}

# Enable Artifact Registry API
resource "google_project_service" "artifactregistry" {
  project = var.project_id
  service = "artifactregistry.googleapis.com"
}

# Artifact Registry repository
resource "google_artifact_registry_repository" "repo" {
  project       = var.project_id
  location      = var.region
  repository_id = var.repository_name
  description   = "Docker repository for platform images"
  format        = "DOCKER"

  depends_on = [google_project_service.artifactregistry]
}

# Service account for Cloud Build
resource "google_service_account" "cloudbuild" {
  project      = var.project_id
  account_id   = "cloudbuild-sa"
  display_name = "Cloud Build Service Account"
}

# IAM binding for Cloud Build to push to Artifact Registry
resource "google_artifact_registry_repository_iam_member" "cloudbuild_writer" {
  project    = var.project_id
  location   = google_artifact_registry_repository.repo.location
  repository = google_artifact_registry_repository.repo.name
  role       = "roles/artifactregistry.writer"
  member     = "serviceAccount:${google_service_account.cloudbuild.email}"
}

# IAM binding for GKE nodes to pull from Artifact Registry
resource "google_artifact_registry_repository_iam_member" "gke_reader" {
  project    = var.project_id
  location   = google_artifact_registry_repository.repo.location
  repository = google_artifact_registry_repository.repo.name
  role       = "roles/artifactregistry.reader"
  member     = "serviceAccount:${var.gke_node_service_account}"
}

variable "gke_node_service_account" {
  description = "GKE node service account email"
  type        = string
}

output "repository_url" {
  description = "Artifact Registry repository URL"
  value       = "${google_artifact_registry_repository.repo.location}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.repo.name}"
}

output "cloudbuild_service_account" {
  description = "Cloud Build service account email"
  value       = google_service_account.cloudbuild.email
}
