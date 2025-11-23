# tfmodule-google-cloud-ngfw

Terraform module for deploying and managing Google Cloud Next Generation Firewall (Cloud NGFW) resources, including firewall endpoints, endpoint associations, network security profiles, and security profile groups. This module enables advanced threat prevention and network security at the organization level with flexible configuration options.

## Features

- **Firewall Endpoint Management**: Create and manage Cloud NGFW endpoints at the organization level with zonal deployment
- **Network Association**: Associate firewall endpoints with VPC networks in specific projects
- **Threat Prevention Profiles**: Configure network security profiles with customizable threat prevention settings
- **Security Profile Groups**: Organize and manage security profiles through profile groups
- **TLS Inspection**: Optional TLS inspection policy integration for encrypted traffic analysis
- **Flexible Overrides**: Customize threat prevention behavior with severity and threat-specific overrides
- **Resource Labeling**: Apply labels to all resources for organization and cost tracking
- **Enable/Disable Control**: Support for enabling or disabling firewall endpoint associations
- **Multi-Zone Support**: Deploy firewall endpoints across different zones for regional coverage

## Usage

### Basic Example

```hcl
module "cloud_ngfw" {
  source = "github.com/your-org/tfmodule-google-cloud-ngfw?ref=v1.0.0"

  name_prefix = "prod-"

  firewall_endpoints = {
    primary = {
      firewall_endpoint_name             = "ngfw-endpoint-001"
      org_id                             = "123456789012"
      zone                               = "us-central1-a"
      billing_project_id                 = "billing-project-id"
      firewall_endpoint_association_name = "ngfw-assoc-001"
      project_id                         = "my-project-id"
      network_id                         = "projects/my-project-id/global/networks/my-vpc"
      labels = {
        environment = "production"
        managed_by  = "terraform"
      }
    }
  }

  network_security_profiles = {
    threat_prevention = {
      profile_name              = "threat-prevention-profile"
      profile_group_name        = "threat-prevention-group"
      org_id                    = "123456789012"
      profile_description       = "Standard threat prevention profile"
      profile_group_description = "Standard threat prevention group"
      location                  = "global"
      labels = {
        environment = "production"
        type        = "threat-prevention"
      }
    }
  }
}
```

### Multi-Zone Deployment with TLS Inspection

```hcl
module "cloud_ngfw_multi_zone" {
  source = "github.com/your-org/tfmodule-google-cloud-ngfw?ref=v1.0.0"

  name_prefix = "enterprise-"

  firewall_endpoints = {
    zone_a = {
      firewall_endpoint_name             = "ngfw-us-central1-a"
      org_id                             = "123456789012"
      zone                               = "us-central1-a"
      billing_project_id                 = "billing-project-id"
      firewall_endpoint_association_name = "ngfw-assoc-us-central1-a"
      project_id                         = "network-project-id"
      network_id                         = "projects/network-project-id/global/networks/shared-vpc"
      tls_inspection_policy              = "projects/security-project-id/locations/us-central1/tlsInspectionPolicies/tls-policy"
      labels = {
        environment = "production"
        zone        = "us-central1-a"
        purpose     = "web-traffic"
      }
      disabled = false
    }
    zone_b = {
      firewall_endpoint_name             = "ngfw-us-central1-b"
      org_id                             = "123456789012"
      zone                               = "us-central1-b"
      billing_project_id                 = "billing-project-id"
      firewall_endpoint_association_name = "ngfw-assoc-us-central1-b"
      project_id                         = "network-project-id"
      network_id                         = "projects/network-project-id/global/networks/shared-vpc"
      tls_inspection_policy              = "projects/security-project-id/locations/us-central1/tlsInspectionPolicies/tls-policy"
      labels = {
        environment = "production"
        zone        = "us-central1-b"
        purpose     = "web-traffic"
      }
      disabled = false
    }
  }

  network_security_profiles = {
    strict_prevention = {
      profile_name              = "strict-threat-prevention"
      profile_group_name        = "strict-prevention-group"
      org_id                    = "123456789012"
      profile_description       = "Strict threat prevention with custom overrides"
      profile_group_description = "Strict threat prevention profile group"
      location                  = "global"
      labels = {
        environment = "production"
        severity    = "strict"
      }
    }
  }
}
```

### Advanced Configuration with Custom Threat Overrides

```hcl
module "cloud_ngfw_advanced" {
  source = "github.com/your-org/tfmodule-google-cloud-ngfw?ref=v1.0.0"

  name_prefix = "sec-"

  firewall_endpoints = {
    dmz = {
      firewall_endpoint_name             = "ngfw-dmz-endpoint"
      org_id                             = "123456789012"
      zone                               = "us-east1-b"
      billing_project_id                 = "security-billing-project"
      firewall_endpoint_association_name = "ngfw-dmz-association"
      project_id                         = "dmz-project-id"
      network_id                         = "projects/dmz-project-id/global/networks/dmz-vpc"
      tls_inspection_policy              = "projects/security-project/locations/us-east1/tlsInspectionPolicies/dmz-tls"
      labels = {
        environment = "production"
        zone_type   = "dmz"
        compliance  = "pci-dss"
      }
      disabled = false
    }
  }

  network_security_profiles = {
    custom_prevention = {
      profile_name              = "custom-threat-profile"
      profile_group_name        = "custom-threat-group"
      org_id                    = "123456789012"
      profile_description       = "Custom threat prevention with severity and threat overrides"
      profile_group_description = "Custom threat prevention profile group"
      location                  = "us-east1"
      
      # Severity-based overrides
      severity_overrides = {
        CRITICAL = "ALLOW"
        HIGH     = "DENY"
        MEDIUM   = "ALLOW"
        LOW      = "ALLOW"
      }
      
      # Specific threat ID overrides
      threat_overrides = {
        "280001" = "ALLOW"
        "280002" = "DENY"
        "280003" = "ALLOW"
      }
      
      labels = {
        environment     = "production"
        profile_type    = "custom"
        override_config = "enabled"
      }
    }
  }
}
```

### Multi-Profile Configuration

```hcl
module "cloud_ngfw_multi_profile" {
  source = "github.com/your-org/tfmodule-google-cloud-ngfw?ref=v1.0.0"

  name_prefix = "org-"

  firewall_endpoints = {
    web_tier = {
      firewall_endpoint_name             = "ngfw-web-tier"
      org_id                             = "123456789012"
      zone                               = "us-west1-a"
      billing_project_id                 = "org-billing-project"
      firewall_endpoint_association_name = "ngfw-web-assoc"
      project_id                         = "web-tier-project"
      network_id                         = "projects/web-tier-project/global/networks/web-vpc"
      labels = {
        tier        = "web"
        environment = "production"
      }
    }
    app_tier = {
      firewall_endpoint_name             = "ngfw-app-tier"
      org_id                             = "123456789012"
      zone                               = "us-west1-b"
      billing_project_id                 = "org-billing-project"
      firewall_endpoint_association_name = "ngfw-app-assoc"
      project_id                         = "app-tier-project"
      network_id                         = "projects/app-tier-project/global/networks/app-vpc"
      labels = {
        tier        = "application"
        environment = "production"
      }
    }
  }

  network_security_profiles = {
    web_profile = {
      profile_name              = "web-threat-prevention"
      profile_group_name        = "web-security-group"
      org_id                    = "123456789012"
      profile_description       = "Threat prevention for web tier"
      profile_group_description = "Web tier security group"
      location                  = "global"
      severity_overrides = {
        CRITICAL = "DENY"
        HIGH     = "DENY"
      }
      labels = {
        tier = "web"
      }
    }
    app_profile = {
      profile_name              = "app-threat-prevention"
      profile_group_name        = "app-security-group"
      org_id                    = "123456789012"
      profile_description       = "Threat prevention for application tier"
      profile_group_description = "Application tier security group"
      location                  = "global"
      severity_overrides = {
        CRITICAL = "DENY"
        HIGH     = "DENY"
        MEDIUM   = "ALLOW"
      }
      labels = {
        tier = "application"
      }
    }
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name_prefix | A name prefix that will prepend all resources created | `string` | `""` | no |
| firewall_endpoints | A map containing each firewall endpoint and association to create. See details below. | `map(object)` | n/a | yes |
| network_security_profiles | A map of each network security profile and group to create. See details below. | `map(object)` | n/a | yes |
| firewall_policy_name | Firewall Policy Name | `string` | `""` | no |

### firewall_endpoints Object Structure

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| firewall_endpoint_name | The name of the firewall endpoint | `string` | n/a | yes |
| org_id | The Google Cloud organization ID | `string` | n/a | yes |
| zone | The zone where the firewall endpoint will be deployed | `string` | n/a | yes |
| billing_project_id | The billing project ID for the Google Cloud organization | `string` | n/a | yes |
| firewall_endpoint_association_name | The name of the firewall endpoint association | `string` | n/a | yes |
| project_id | The project ID where network to be associated with the firewall endpoint resides | `string` | n/a | yes |
| network_id | The VPC network ID to associate with the firewall endpoint | `string` | n/a | yes |
| tls_inspection_policy | The name of the TLS inspection policy to be applied to the firewall endpoint | `string` | `null` | no |
| labels | A map of labels to apply to the firewall endpoint and association | `map(string)` | `null` | no |
| disabled | Whether the firewall endpoint should be disabled. **NOTE**: This value MUST be `false` at creation time | `bool` | `false` | no |

### network_security_profiles Object Structure

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| profile_name | The name of the network security profile | `string` | n/a | yes |
| profile_group_name | The name of the network security profile group | `string` | n/a | yes |
| org_id | The Google Cloud organization ID | `string` | n/a | yes |
| profile_description | The description of the network security profile | `string` | `null` | no |
| profile_group_description | The description of the network security profile group | `string` | `null` | no |
| labels | A map of labels to apply to the network security profile and group | `map(string)` | `null` | no |
| location | The location where the network security profile and group will be created | `string` | `"global"` | no |
| severity_overrides | A map of severity overrides for the network security profile (CRITICAL, HIGH, MEDIUM, LOW -> ALLOW/DENY) | `map(string)` | `{}` | no |
| threat_overrides | A map of threat overrides for the network security profile (threat_id -> ALLOW/DENY) | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| firewall_endpoint_ids | Map of created firewall endpoint IDs |
| firewall_endpoint_self_links | Map of created firewall endpoint self-links |
| firewall_endpoint_names | Map of created firewall endpoint names |
| firewall_endpoint_association_ids | Map of created firewall endpoint association IDs |
| firewall_endpoint_association_self_links | Map of created firewall endpoint association self-links |
| firewall_endpoint_association_names | Map of created firewall endpoint association names |
| security_profile_ids | Map of created security profile IDs |
| security_profile_self_links | Map of created security profile self-links |
| security_profile_names | Map of created security profile names |
| security_profile_group_ids | Map of created security profile group IDs |
| security_profile_group_names | Map of created security profile group names |

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5.0 |
| google | >= 7.0.0, < 8.0.0 |
| google-beta | >= 7.0.0, < 8.0.0 |

## Important Notes

### Firewall Endpoint Disabled Property

The `disabled` property in firewall endpoint associations **MUST** be set to `false` at resource creation time. This is a requirement from the Google Cloud API. You can set this to `true` later to disable the firewall endpoint association after it has been created.

### Organization-Level Resources

Firewall endpoints and network security profiles are created at the organization level and require appropriate IAM permissions at the organization scope.

### Network Association

When associating a firewall endpoint with a VPC network, ensure that:
- The network exists in the specified project
- The project has the necessary APIs enabled
- Proper IAM permissions are granted for the association

### TLS Inspection Policy

If using TLS inspection, the TLS inspection policy must be created separately and specified using its full resource path:
```
projects/{project}/locations/{location}/tlsInspectionPolicies/{policy-name}
```

## Reference

This module is based on the Palo Alto Networks Cloud NGFW Terraform modules:
- [Palo Alto Networks SWFW Modules](https://github.com/PaloAltoNetworks/terraform-google-swfw-modules/blob/v2.0.11/modules/cloud_ngfw/main.tf)

## Changelog

See [CHANGELOG.md](./CHANGELOG.md) for version history and changes.