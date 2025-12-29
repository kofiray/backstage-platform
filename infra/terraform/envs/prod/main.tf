terraform {
  required_version = ">= 1.5"
  
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.4"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
  }

  backend "gcs" {
    bucket = "backstage-terraform-state-docker-1210"
    prefix = "prod"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# Variables
variable "project_id" {
  description = "GCP project ID"
  type        = string
  default     = "docker-1210"
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "europe-west2"
}

variable "cluster_name" {
  description = "GKE cluster name"
  type        = string
  default     = "backstage-prod"
}

variable "domain_name" {
  description = "Optional domain name to use. If not provided, will auto-discover from Cloud DNS zones"
  type        = string
  default     = ""
}

variable "force_zone_selection" {
  description = "Required when multiple public zones exist and domain_name is not provided"
  type        = string
  default     = ""
}

variable "github_repo_owner" {
  description = "GitHub repository owner"
  type        = string
  default     = "kofiray"
}

variable "github_repo_name" {
  description = "GitHub repository name"
  type        = string
  default     = "backstage-platform"
}

# Local values
locals {
  techdocs_bucket_name = "${var.project_id}-backstage-techdocs"
}

# VPC
module "vpc" {
  source = "../../modules/vpc"

  project_id = var.project_id
  region     = var.region
}

# GKE Cluster
module "gke" {
  source = "../../modules/gke"

  project_id           = var.project_id
  region               = var.region
  cluster_name         = var.cluster_name
  vpc_name             = module.vpc.vpc_name
  subnet_name          = module.vpc.subnet_name
  pods_range_name      = module.vpc.pods_range_name
  services_range_name  = module.vpc.services_range_name
  node_count           = 1 # 1 per zone = 3 total nodes
  machine_type         = "e2-standard-4" # 4 vCPU, 16GB RAM
}

# Artifact Registry
module "artifact_registry" {
  source = "../../modules/artifact-registry"

  project_id                = var.project_id
  region                    = var.region
  gke_node_service_account  = module.gke.node_service_account
}

# Cloud SQL
module "cloudsql" {
  source = "../../modules/cloudsql"

  project_id = var.project_id
  region     = var.region
  vpc_name   = module.vpc.vpc_name
}

# GCS for TechDocs
module "gcs_techdocs" {
  source = "../../modules/gcs-techdocs"

  project_id  = var.project_id
  region      = var.region
  bucket_name = local.techdocs_bucket_name
}

# Cloud Build
module "cloudbuild" {
  source = "../../modules/cloudbuild"

  project_id                 = var.project_id
  region                     = var.region
  github_repo_owner          = var.github_repo_owner
  github_repo_name           = var.github_repo_name
  artifact_registry_url      = module.artifact_registry.repository_url
  cloudbuild_service_account = module.artifact_registry.cloudbuild_service_account
}

# IAM
module "iam" {
  source = "../../modules/iam"

  project_id              = var.project_id
  gke_cluster_name        = var.cluster_name
  backstage_cloudsql_sa   = module.cloudsql.backstage_service_account
  backstage_techdocs_sa   = module.gcs_techdocs.backstage_service_account
}

# Reserve static IP for ingress
resource "google_compute_global_address" "ingress_ip" {
  project = var.project_id
  name    = "backstage-ingress-ip"
}

# DNS
module "dns" {
  source = "../../modules/dns"

  project_id            = var.project_id
  domain_name           = var.domain_name
  force_zone_selection  = var.force_zone_selection
  ingress_ip            = google_compute_global_address.ingress_ip.address
}

# Outputs
output "cluster_name" {
  description = "GKE cluster name"
  value       = module.gke.cluster_name
}

output "cluster_endpoint" {
  description = "GKE cluster endpoint"
  value       = module.gke.cluster_endpoint
  sensitive   = true
}

output "artifact_registry_url" {
  description = "Artifact Registry URL"
  value       = module.artifact_registry.repository_url
}

output "cloudsql_connection_name" {
  description = "Cloud SQL connection name"
  value       = module.cloudsql.instance_connection_name
}

output "techdocs_bucket" {
  description = "TechDocs bucket name"
  value       = module.gcs_techdocs.bucket_name
}

output "backstage_fqdn" {
  description = "Backstage FQDN"
  value       = module.dns.backstage_fqdn
}

output "argocd_fqdn" {
  description = "Argo CD FQDN"
  value       = module.dns.argocd_fqdn
}

output "ingress_ip" {
  description = "Ingress IP address"
  value       = google_compute_global_address.ingress_ip.address
}

output "selected_dns_zone" {
  description = "Selected DNS zone information"
  value       = module.dns.selected_zone
}

output "available_dns_zones" {
  description = "Available DNS zones"
  value       = module.dns.available_zones
}

# Service accounts for Kubernetes
output "backstage_service_account" {
  description = "Backstage service account email"
  value       = module.iam.backstage_service_account
}

output "external_secrets_service_account" {
  description = "External Secrets service account email"
  value       = module.iam.external_secrets_service_account
}

output "cert_manager_service_account" {
  description = "cert-manager service account email"
  value       = module.iam.cert_manager_service_account
}
