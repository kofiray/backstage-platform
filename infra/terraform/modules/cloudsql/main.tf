variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "vpc_name" {
  description = "VPC name for private IP"
  type        = string
}

variable "instance_name" {
  description = "Cloud SQL instance name"
  type        = string
  default     = "backstage-db"
}

variable "database_name" {
  description = "Database name"
  type        = string
  default     = "backstage"
}

variable "database_user" {
  description = "Database user"
  type        = string
  default     = "backstage"
}

# Enable Cloud SQL API
resource "google_project_service" "sqladmin" {
  project = var.project_id
  service = "sqladmin.googleapis.com"
}

# Random password for database
resource "random_password" "db_password" {
  length  = 32
  special = true
}

# Store password in Secret Manager
resource "google_secret_manager_secret" "db_password" {
  project   = var.project_id
  secret_id = "backstage-db-password"

  replication {
    auto {}
  }

  depends_on = [google_project_service.secretmanager]
}

resource "google_secret_manager_secret_version" "db_password" {
  secret      = google_secret_manager_secret.db_password.id
  secret_data = random_password.db_password.result
}

# Enable Secret Manager API
resource "google_project_service" "secretmanager" {
  project = var.project_id
  service = "secretmanager.googleapis.com"
}

# Private IP range for Cloud SQL
resource "google_compute_global_address" "private_ip_range" {
  project       = var.project_id
  name          = "backstage-db-private-ip"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = "projects/${var.project_id}/global/networks/${var.vpc_name}"
}

# Private connection for Cloud SQL
resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = "projects/${var.project_id}/global/networks/${var.vpc_name}"
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_range.name]

  depends_on = [google_project_service.servicenetworking]
}

# Enable Service Networking API
resource "google_project_service" "servicenetworking" {
  project = var.project_id
  service = "servicenetworking.googleapis.com"
}

# Cloud SQL instance
resource "google_sql_database_instance" "instance" {
  project          = var.project_id
  name             = var.instance_name
  database_version = "POSTGRES_15"
  region           = var.region

  settings {
    tier              = "db-f1-micro" # Cheapest tier for 3-node constraint
    availability_type = "ZONAL"       # Single zone for cost optimization
    disk_type         = "PD_SSD"
    disk_size         = 20

    backup_configuration {
      enabled                        = true
      start_time                     = "02:00"
      point_in_time_recovery_enabled = true
      backup_retention_settings {
        retained_backups = 7
      }
    }

    ip_configuration {
      ipv4_enabled                                  = false
      private_network                               = "projects/${var.project_id}/global/networks/${var.vpc_name}"
      enable_private_path_for_google_cloud_services = true
    }

    database_flags {
      name  = "log_checkpoints"
      value = "on"
    }

    database_flags {
      name  = "log_connections"
      value = "on"
    }

    database_flags {
      name  = "log_disconnections"
      value = "on"
    }

    maintenance_window {
      day          = 7
      hour         = 2
      update_track = "stable"
    }
  }

  deletion_protection = false # Set to true in production

  depends_on = [
    google_service_networking_connection.private_vpc_connection,
    google_project_service.sqladmin
  ]
}

# Database
resource "google_sql_database" "database" {
  project  = var.project_id
  name     = var.database_name
  instance = google_sql_database_instance.instance.name
}

# Database user
resource "google_sql_user" "user" {
  project  = var.project_id
  name     = var.database_user
  instance = google_sql_database_instance.instance.name
  password = random_password.db_password.result
}

# Service account for Backstage to connect to Cloud SQL
resource "google_service_account" "backstage_cloudsql" {
  project      = var.project_id
  account_id   = "backstage-cloudsql"
  display_name = "Backstage Cloud SQL Service Account"
}

# IAM binding for Cloud SQL client
resource "google_project_iam_member" "backstage_cloudsql_client" {
  project = var.project_id
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${google_service_account.backstage_cloudsql.email}"
}

output "instance_name" {
  description = "Cloud SQL instance name"
  value       = google_sql_database_instance.instance.name
}

output "instance_connection_name" {
  description = "Cloud SQL instance connection name"
  value       = google_sql_database_instance.instance.connection_name
}

output "database_name" {
  description = "Database name"
  value       = google_sql_database.database.name
}

output "database_user" {
  description = "Database user"
  value       = google_sql_user.user.name
}

output "private_ip_address" {
  description = "Private IP address of the instance"
  value       = google_sql_database_instance.instance.private_ip_address
}

output "backstage_service_account" {
  description = "Backstage Cloud SQL service account email"
  value       = google_service_account.backstage_cloudsql.email
}

output "db_password_secret_name" {
  description = "Secret Manager secret name for database password"
  value       = google_secret_manager_secret.db_password.secret_id
}
