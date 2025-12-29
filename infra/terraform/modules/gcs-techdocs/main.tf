variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "bucket_name" {
  description = "GCS bucket name for TechDocs"
  type        = string
}

# Enable Storage API
resource "google_project_service" "storage" {
  project = var.project_id
  service = "storage.googleapis.com"
}

# GCS bucket for TechDocs
resource "google_storage_bucket" "techdocs" {
  project  = var.project_id
  name     = var.bucket_name
  location = var.region

  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  lifecycle_rule {
    condition {
      age = 30
    }
    action {
      type = "Delete"
    }
  }

  lifecycle_rule {
    condition {
      age                = 7
      with_state         = "NONCURRENT_VERSION"
    }
    action {
      type = "Delete"
    }
  }

  cors {
    origin          = ["*"]
    method          = ["GET", "HEAD", "PUT", "POST", "DELETE"]
    response_header = ["*"]
    max_age_seconds = 3600
  }

  depends_on = [google_project_service.storage]
}

# Service account for Backstage to access TechDocs bucket
resource "google_service_account" "backstage_techdocs" {
  project      = var.project_id
  account_id   = "backstage-techdocs"
  display_name = "Backstage TechDocs Service Account"
}

# IAM binding for TechDocs bucket access
resource "google_storage_bucket_iam_member" "backstage_techdocs_admin" {
  bucket = google_storage_bucket.techdocs.name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_service_account.backstage_techdocs.email}"
}

output "bucket_name" {
  description = "TechDocs bucket name"
  value       = google_storage_bucket.techdocs.name
}

output "bucket_url" {
  description = "TechDocs bucket URL"
  value       = google_storage_bucket.techdocs.url
}

output "backstage_service_account" {
  description = "Backstage TechDocs service account email"
  value       = google_service_account.backstage_techdocs.email
}
