variable "name_prefix" {
  description = "A name prefix that will prepend all resources created."
  type        = string
  default     = ""
}

variable "firewall_endpoints" {
  description = <<-EOF
  A map containing each firewall endpoint and association to create.

  Following properties are available:

  - `firewall_endpoint_name`             - (`string`, required) The name of the firewall endpoint.
  - `org_id`                             - (`string`, required) The Google Cloud organization ID.
  - `zone`                               - (`string`, required) The zone where the firewall endpoint will be deploye
  - `billing_project_id`                 - (`string`, required) The billing project ID for the Google Cloud organization.
  - `firewall_endpoint_association_name` - (`string`, required) The name of the firewall endpoint association.
  - `project_id`                         - (`string`, required) The project ID where network to be associated with the firewall endpoint resides.
  - `tls_inspection_policy`              - (`string`, optional) The name of the TLS inspection policy to be applied to the firewall endpoint.
  - `labels`                             - (`map(string)`, optional) A map of labels to apply to the firewall endpoint and association.
  - `disabled`                           - (`bool`, optional, default: `false`) Whether the firewall endpoint should be disabled. `NOTE`: This value MUST be `false` at creation time.

  **Important!** \
  `disabled` property MUST be `false` at resource creation time. This can be set to `true` later to disable the firewall endpoint.
  EOF
  type = map(object({
    firewall_endpoint_name             = string
    org_id                             = string
    zone                               = string
    billing_project_id                 = string
    firewall_endpoint_association_name = string
    project_id                         = string
    network_id                         = string
    tls_inspection_policy              = optional(string)
    labels                             = optional(map(string), null)
    disabled                           = optional(bool, false)
  }))
}

variable "network_security_profiles" {
  description = <<-EOF
  A map each network security profile and group to create.

  Following properties are available:

  - `profile_name`              - (`string`, required) The name of the network security profile.
  - `profile_group_name`        - (`string`, required) The name of the network security profile group.
  - `org_id`                    - (`string`, required) The Google Cloud organization ID.
  - `profile_description`       - (`string`, optional) The description of the network security profile.
  - `profile_group_description` - (`string`, optional) The description of the network security profile group.
  - `labels`                    - (`map(string)`, optional) A map of labels to apply to the network security profile and group.
  - `location`                  - (`string`, optional, defaults to`"global"`) The location where the network security profile and group will be created.
  - `severity_overrides`        - (`map(string)`, optional, defaults to empty map) A map of severity overrides for the network security profile.
  - `threat_overrides`          - (`map(string)`, optional, defaults to empty map) A map of threat overrides for the network security profile.

  EOF
  type = map(object({
    profile_name              = string
    profile_group_name        = string
    org_id                    = string
    profile_description       = optional(string, null)
    profile_group_description = optional(string, null)
    labels                    = optional(map(string), null)
    location                  = optional(string, "global")
    severity_overrides        = optional(map(string), {})
    threat_overrides          = optional(map(string), {})
  }))
}

variable "firewall_policy_name" {
  type          = string
  description   = "Firewall Policy Name"
  default     = ""
}