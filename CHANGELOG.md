# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-11-23

### Added

- Initial release of Cloud NGFW (Next Generation Firewall) Terraform module
- Support for creating and managing Google Cloud Firewall Endpoints at organization level
- Support for creating Firewall Endpoint Associations to attach endpoints to VPC networks
- Support for Network Security Profiles with threat prevention capabilities
- Support for Network Security Profile Groups for organizing security profiles
- Configurable name prefix for all resources
- Support for TLS inspection policy integration
- Flexible severity overrides configuration for threat prevention profiles
- Flexible threat overrides configuration for specific threat IDs
- Support for resource labeling across all components
- Support for enabling/disabling firewall endpoint associations
- Zonal firewall endpoint deployment

### Outputs

- `firewall_endpoint_ids` - Map of created firewall endpoint IDs
- `firewall_endpoint_self_links` - Map of created firewall endpoint self-links
- `firewall_endpoint_names` - Map of created firewall endpoint names
- `firewall_endpoint_association_ids` - Map of created firewall endpoint association IDs
- `firewall_endpoint_association_self_links` - Map of created firewall endpoint association self-links
- `firewall_endpoint_association_names` - Map of created firewall endpoint association names
- `security_profile_ids` - Map of created security profile IDs
- `security_profile_self_links` - Map of created security profile self-links
- `security_profile_names` - Map of created security profile names
- `security_profile_group_ids` - Map of created security profile group IDs
- `security_profile_group_names` - Map of created security profile group names

### Requirements

- Terraform >= 1.5.0
- Google Provider >= 7.0.0, < 8.0.0
- Google Beta Provider >= 7.0.0, < 8.0.0