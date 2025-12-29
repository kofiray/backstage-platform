variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "cluster_name" {
  description = "GKE cluster name"
  type        = string
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
}

variable "subnet_name" {
  description = "Subnet name"
  type        = string
}

variable "pods_range_name" {
  description = "Pods secondary range name"
  type        = string
}

variable "services_range_name" {
  description = "Services secondary range name"
  type        = string
}

variable "node_count" {
  description = "Number of nodes per zone"
  type        = number
  default     = 1
}

variable "machine_type" {
  description = "Machine type for nodes"
  type        = string
  default     = "e2-standard-4" # 4 vCPU, 16GB RAM - cheapest viable for our workloads
}

variable "zones" {
  description = "Zones for the cluster"
  type        = list(string)
  default     = ["europe-west2-a", "europe-west2-b", "europe-west2-c"]
}

# GKE cluster
resource "google_container_cluster" "cluster" {
  name     = var.cluster_name
  project  = var.project_id
  location = var.region

  # Regional cluster with 3 nodes total (1 per zone)
  node_locations = var.zones

  # Remove default node pool
  remove_default_node_pool = true
  initial_node_count       = 1

  # Network configuration
  network    = var.vpc_name
  subnetwork = var.subnet_name

  # Disable default CNI - we'll use Cilium
  networking_mode = "VPC_NATIVE"
  
  # Private cluster configuration
  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  # IP allocation for pods and services
  ip_allocation_policy {
    cluster_secondary_range_name  = var.pods_range_name
    services_secondary_range_name = var.services_range_name
  }

  # Master authorized networks - restrict to home IP only
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "86.177.222.87/32"
      display_name = "Home IP"
    }
  }

  # Workload Identity
  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  # Disable default addons - Cilium will handle networking
  addons_config {
    http_load_balancing {
      disabled = true  # Cilium ingress controller
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
    network_policy_config {
      disabled = true  # Cilium handles network policies
    }
    gce_persistent_disk_csi_driver_config {
      enabled = true
    }
  }

  # Maintenance policy - more flexible window
  maintenance_policy {
    daily_maintenance_window {
      start_time = "02:00"
    }
  }

  # Logging and monitoring
  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"

  # Security
  enable_shielded_nodes = true
  
  # Binary authorization
  binary_authorization {
    evaluation_mode = "PROJECT_SINGLETON_POLICY_ENFORCE"
  }

  depends_on = [
    google_project_service.container,
    google_project_service.compute,
  ]
}

# Node pool
resource "google_container_node_pool" "nodes" {
  name       = "${var.cluster_name}-nodes"
  project    = var.project_id
  location   = var.region
  cluster    = google_container_cluster.cluster.name
  node_count = var.node_count

  # Node configuration
  node_config {
    machine_type = var.machine_type
    disk_size_gb = 50
    disk_type    = "pd-ssd"
    image_type   = "COS_CONTAINERD"

    # Service account with minimal permissions
    service_account = google_service_account.gke_nodes.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    # Workload Identity
    workload_metadata_config {
      mode = "GKE_METADATA"
    }

    # Shielded nodes
    shielded_instance_config {
      enable_secure_boot          = true
      enable_integrity_monitoring = true
    }

    # Labels
    labels = {
      environment = "production"
      cluster     = var.cluster_name
    }

    # Taints for system workloads if needed
    # taint {
    #   key    = "system"
    #   value  = "true"
    #   effect = "NO_SCHEDULE"
    # }

    metadata = {
      disable-legacy-endpoints = "true"
    }
  }

  # Autoscaling disabled (fixed 3 nodes)
  autoscaling {
    min_node_count = var.node_count
    max_node_count = var.node_count
  }

  # Node management
  management {
    auto_repair  = true
    auto_upgrade = true
  }

  # Upgrade settings
  upgrade_settings {
    max_surge       = 1
    max_unavailable = 0
  }
}

# Service account for GKE nodes
resource "google_service_account" "gke_nodes" {
  account_id   = "${var.cluster_name}-nodes"
  project      = var.project_id
  display_name = "GKE Nodes Service Account"
}

# IAM bindings for node service account
resource "google_project_iam_member" "gke_nodes_registry" {
  project = var.project_id
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_service_account.gke_nodes.email}"
}

resource "google_project_iam_member" "gke_nodes_logging" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.gke_nodes.email}"
}

resource "google_project_iam_member" "gke_nodes_monitoring" {
  project = var.project_id
  role    = "roles/monitoring.metricWriter"
  member  = "serviceAccount:${google_service_account.gke_nodes.email}"
}

resource "google_project_iam_member" "gke_nodes_monitoring_viewer" {
  project = var.project_id
  role    = "roles/monitoring.viewer"
  member  = "serviceAccount:${google_service_account.gke_nodes.email}"
}

# Enable required APIs
resource "google_project_service" "container" {
  project = var.project_id
  service = "container.googleapis.com"
}

resource "google_project_service" "compute" {
  project = var.project_id
  service = "compute.googleapis.com"
}

output "cluster_name" {
  description = "GKE cluster name"
  value       = google_container_cluster.cluster.name
}

output "cluster_endpoint" {
  description = "GKE cluster endpoint"
  value       = google_container_cluster.cluster.endpoint
  sensitive   = true
}

output "cluster_ca_certificate" {
  description = "GKE cluster CA certificate"
  value       = google_container_cluster.cluster.master_auth[0].cluster_ca_certificate
  sensitive   = true
}

output "node_service_account" {
  description = "Node service account email"
  value       = google_service_account.gke_nodes.email
}
