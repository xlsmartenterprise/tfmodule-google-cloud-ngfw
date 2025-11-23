#Reference: https://github.com/PaloAltoNetworks/terraform-google-swfw-modules/blob/v2.0.11/modules/cloud_ngfw/main.tf

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/network_security_firewall_endpoint
resource "google_network_security_firewall_endpoint" "this" {

  for_each = var.firewall_endpoints

  name               = "${var.name_prefix}${each.value.firewall_endpoint_name}"
  parent             = "organizations/${each.value.org_id}"
  location           = each.value.zone
  billing_project_id = each.value.billing_project_id
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/network_security_firewall_endpoint_association
resource "google_network_security_firewall_endpoint_association" "this" {

  for_each = var.firewall_endpoints

  name                  = "${var.name_prefix}${each.value.firewall_endpoint_association_name}"
  parent                = "projects/${each.value.project_id}"
  location              = each.value.zone
  network               = each.value.network_id
  firewall_endpoint     = google_network_security_firewall_endpoint.this[each.key].id
  tls_inspection_policy = each.value.tls_inspection_policy != null ? each.value.tls_inspection_policy : null
  labels                = each.value.labels
  disabled              = each.value.disabled
}

#https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/network_security_security_profile
resource "google_network_security_security_profile" "this" {

  for_each = var.network_security_profiles

  name        = "${var.name_prefix}${each.value.profile_name}"
  parent      = "organizations/${each.value.org_id}"
  description = each.value.profile_description
  labels      = each.value.labels
  location    = each.value.location
  type        = "THREAT_PREVENTION"

  threat_prevention_profile {
    dynamic "severity_overrides" {
      for_each = each.value.severity_overrides
      content {
        severity = severity_overrides.key
        action   = severity_overrides.value
      }
    }
    dynamic "threat_overrides" {
      for_each = each.value.threat_overrides
      content {
        action    = threat_overrides.value
        threat_id = threat_overrides.key
      }
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/network_security_security_profile_group
resource "google_network_security_security_profile_group" "this" {

  for_each = var.network_security_profiles

  name                      = "${var.name_prefix}${each.value.profile_group_name}"
  parent                    = "organizations/${each.value.org_id}"
  description               = each.value.profile_group_description
  labels                    = each.value.labels
  location                  = each.value.location
  threat_prevention_profile = google_network_security_security_profile.this[each.key].id
}