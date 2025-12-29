variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "gke_cluster_name" {
  description = "GKE cluster name"
  type        = string
}

variable "backstage_cloudsql_sa" {
  description = "Backstage Cloud SQL service account email"
  type        = string
}

variable "backstage_techdocs_sa" {
  description = "Backstage TechDocs service account email"
  type        = string
}

# Kubernetes service account for Backstage
resource "google_service_account" "backstage_k8s" {
  project      = var.project_id
  account_id   = "backstage-k8s"
  display_name = "Backstage Kubernetes Service Account"
}

# Workload Identity binding for Backstage
resource "google_service_account_iam_member" "backstage_workload_identity" {
  service_account_id = google_service_account.backstage_k8s.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project_id}.svc.id.goog[backstage/backstage]"
}

# GKE cluster viewer role for Backstage
resource "google_project_iam_member" "backstage_gke_viewer" {
  project = var.project_id
  role    = "roles/container.clusterViewer"
  member  = "serviceAccount:${google_service_account.backstage_k8s.email}"
}

resource "google_project_iam_member" "backstage_gke_developer" {
  project = var.project_id
  role    = "roles/container.developer"
  member  = "serviceAccount:${google_service_account.backstage_k8s.email}"
}

# Secret Manager access for Backstage
resource "google_project_iam_member" "backstage_secret_accessor" {
  project = var.project_id
  role    = "roles/secretmanager.secretAccessor"
  member  = "serviceAccount:${google_service_account.backstage_k8s.email}"
}

# Bind Cloud SQL service account to Backstage K8s SA
resource "google_service_account_iam_member" "backstage_cloudsql_binding" {
  service_account_id = "projects/${var.project_id}/serviceAccounts/${var.backstage_cloudsql_sa}"
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project_id}.svc.id.goog[backstage/backstage]"
}

# Bind TechDocs service account to Backstage K8s SA
resource "google_service_account_iam_member" "backstage_techdocs_binding" {
  service_account_id = "projects/${var.project_id}/serviceAccounts/${var.backstage_techdocs_sa}"
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project_id}.svc.id.goog[backstage/backstage]"
}

# Service account for External Secrets Operator
resource "google_service_account" "external_secrets" {
  project      = var.project_id
  account_id   = "external-secrets"
  display_name = "External Secrets Operator Service Account"
}

# Workload Identity binding for External Secrets
resource "google_service_account_iam_member" "external_secrets_workload_identity" {
  service_account_id = google_service_account.external_secrets.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project_id}.svc.id.goog[external-secrets/external-secrets]"
}

# Secret Manager access for External Secrets
resource "google_project_iam_member" "external_secrets_secret_accessor" {
  project = var.project_id
  role    = "roles/secretmanager.secretAccessor"
  member  = "serviceAccount:${google_service_account.external_secrets.email}"
}

# Service account for cert-manager
resource "google_service_account" "cert_manager" {
  project      = var.project_id
  account_id   = "cert-manager"
  display_name = "cert-manager Service Account"
}

# Workload Identity binding for cert-manager
resource "google_service_account_iam_member" "cert_manager_workload_identity" {
  service_account_id = google_service_account.cert_manager.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project_id}.svc.id.goog[cert-manager/cert-manager]"
}

# DNS admin role for cert-manager (DNS-01 challenge)
resource "google_project_iam_member" "cert_manager_dns_admin" {
  project = var.project_id
  role    = "roles/dns.admin"
  member  = "serviceAccount:${google_service_account.cert_manager.email}"
}

output "backstage_service_account" {
  description = "Backstage Kubernetes service account email"
  value       = google_service_account.backstage_k8s.email
}

output "external_secrets_service_account" {
  description = "External Secrets service account email"
  value       = google_service_account.external_secrets.email
}

output "cert_manager_service_account" {
  description = "cert-manager service account email"
  value       = google_service_account.cert_manager.email
}
