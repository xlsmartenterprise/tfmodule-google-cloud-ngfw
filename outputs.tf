# Output for Firewall Endpoints
output "firewall_endpoint_ids" {
  description = "Map of created firewall endpoint IDs."
  value       = { for k, v in google_network_security_firewall_endpoint.this : k => v.id }
}

output "firewall_endpoint_self_links" {
  description = "Map of created firewall endpoint self-links."
  value       = { for k, v in google_network_security_firewall_endpoint.this : k => v.self_link }
}

output "firewall_endpoint_names" {
  description = "Map of created firewall endpoint names."
  value       = { for k, v in google_network_security_firewall_endpoint.this : k => v.name }
}

# Output for Firewall Endpoint Associations
output "firewall_endpoint_association_ids" {
  description = "Map of created firewall endpoint association IDs."
  value       = { for k, v in google_network_security_firewall_endpoint_association.this : k => v.id }
}

output "firewall_endpoint_association_self_links" {
  description = "Map of created firewall endpoint association self-links."
  value       = { for k, v in google_network_security_firewall_endpoint_association.this : k => v.self_link }
}

output "firewall_endpoint_association_names" {
  description = "Map of created firewall endpoint association names."
  value       = { for k, v in google_network_security_firewall_endpoint_association.this : k => v.name }
}

# Output for Security Profiles
output "security_profile_ids" {
  description = "Map of created security profile IDs."
  value       = { for k, v in google_network_security_security_profile.this : k => v.id }
}

output "security_profile_self_links" {
  description = "Map of created security profile self-links."
  value       = { for k, v in google_network_security_security_profile.this : k => v.self_link }
}

output "security_profile_names" {
  description = "Map of created security profile names."
  value       = { for k, v in google_network_security_security_profile.this : k => v.name }
}

# Output for Security Profile Groups
output "security_profile_group_ids" {
  description = "Map of created security profile group IDs."
  value       = { for k, v in google_network_security_security_profile_group.this : k => v.id }
}

output "security_profile_group_names" {
  description = "Map of created security profile group names."
  value       = { for k, v in google_network_security_security_profile_group.this : k => v.name }
}