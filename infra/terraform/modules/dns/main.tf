variable "project_id" {
  description = "GCP project ID"
  type        = string
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

data "google_dns_managed_zones" "available" {
  project = var.project_id
}

locals {
  # Filter to public zones only
  public_zones = [
    for zone in data.google_dns_managed_zones.available.managed_zones :
    zone if zone.visibility == "public"
  ]

  # If domain_name is provided, find the zone with the longest suffix match
  domain_matched_zones = var.domain_name != "" ? [
    for zone in local.public_zones :
    zone if endswith(var.domain_name, trimsuffix(zone.dns_name, "."))
  ] : []

  # Sort by DNS name length (longest first for most specific match)
  sorted_domain_zones = length(local.domain_matched_zones) > 0 ? [
    for zone in local.domain_matched_zones :
    zone
  ] : []

  # Auto-select logic
  selected_zone = var.domain_name != "" && length(local.sorted_domain_zones) > 0 ? local.sorted_domain_zones[0] : (
    length(local.public_zones) == 1 ? local.public_zones[0] : (
      length(local.public_zones) > 1 && var.force_zone_selection != "" ? [
        for zone in local.public_zones :
        zone if zone.name == var.force_zone_selection
      ][0] : null
    )
  )

  # Generate the domain to use
  base_domain = local.selected_zone != null ? trimsuffix(local.selected_zone.dns_name, ".") : ""
}

# Validation: Fail if multiple zones exist and no explicit selection
resource "null_resource" "zone_validation" {
  count = length(local.public_zones) > 1 && var.domain_name == "" && var.force_zone_selection == "" ? 1 : 0

  provisioner "local-exec" {
    command = <<-EOT
      echo "ERROR: Multiple public DNS zones found in project ${var.project_id}:"
      echo "Available zones: ${join(", ", [for z in local.public_zones : "${z.name} (${z.dns_name})"])}"
      echo ""
      echo "Please set one of:"
      echo "  - domain_name: Specify the domain you want to use"
      echo "  - force_zone_selection: Specify the zone name to use"
      echo ""
      echo "Example: force_zone_selection = \"${local.public_zones[0].name}\""
      exit 1
    EOT
  }
}

# Create DNS records for Backstage and Argo CD
resource "google_dns_record_set" "backstage" {
  count = local.selected_zone != null ? 1 : 0

  name         = "backstage.${local.base_domain}."
  type         = "A"
  ttl          = 300
  managed_zone = local.selected_zone.name
  project      = var.project_id

  rrdatas = [var.ingress_ip]
}

resource "google_dns_record_set" "argocd" {
  count = local.selected_zone != null ? 1 : 0

  name         = "argocd.${local.base_domain}."
  type         = "A"
  ttl          = 300
  managed_zone = local.selected_zone.name
  project      = var.project_id

  rrdatas = [var.ingress_ip]
}

variable "ingress_ip" {
  description = "IP address for the ingress/gateway"
  type        = string
}

output "selected_zone" {
  description = "The selected DNS zone"
  value       = local.selected_zone
}

output "base_domain" {
  description = "The base domain to use"
  value       = local.base_domain
}

output "backstage_fqdn" {
  description = "Backstage FQDN"
  value       = local.selected_zone != null ? "backstage.${local.base_domain}" : ""
}

output "argocd_fqdn" {
  description = "Argo CD FQDN"
  value       = local.selected_zone != null ? "argocd.${local.base_domain}" : ""
}

output "available_zones" {
  description = "All available public DNS zones"
  value = [
    for zone in local.public_zones : {
      name     = zone.name
      dns_name = zone.dns_name
    }
  ]
}
