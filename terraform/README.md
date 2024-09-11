## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_oci"></a> [oci](#requirement\_oci) | 6.9.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci"></a> [oci](#provider\_oci) | 6.9.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [oci_core_instance.db1](https://registry.terraform.io/providers/oracle/oci/6.9.0/docs/resources/core_instance) | resource |
| [oci_core_instance.web1](https://registry.terraform.io/providers/oracle/oci/6.9.0/docs/resources/core_instance) | resource |
| [oci_core_internet_gateway.public_igw](https://registry.terraform.io/providers/oracle/oci/6.9.0/docs/resources/core_internet_gateway) | resource |
| [oci_core_network_security_group.database1](https://registry.terraform.io/providers/oracle/oci/6.9.0/docs/resources/core_network_security_group) | resource |
| [oci_core_network_security_group.web1](https://registry.terraform.io/providers/oracle/oci/6.9.0/docs/resources/core_network_security_group) | resource |
| [oci_core_network_security_group_security_rule.rule1](https://registry.terraform.io/providers/oracle/oci/6.9.0/docs/resources/core_network_security_group_security_rule) | resource |
| [oci_core_network_security_group_security_rule.rule2](https://registry.terraform.io/providers/oracle/oci/6.9.0/docs/resources/core_network_security_group_security_rule) | resource |
| [oci_core_route_table.outbound](https://registry.terraform.io/providers/oracle/oci/6.9.0/docs/resources/core_route_table) | resource |
| [oci_core_security_list.primary](https://registry.terraform.io/providers/oracle/oci/6.9.0/docs/resources/core_security_list) | resource |
| [oci_core_subnet.private](https://registry.terraform.io/providers/oracle/oci/6.9.0/docs/resources/core_subnet) | resource |
| [oci_core_subnet.public](https://registry.terraform.io/providers/oracle/oci/6.9.0/docs/resources/core_subnet) | resource |
| [oci_core_vcn.vcn1](https://registry.terraform.io/providers/oracle/oci/6.9.0/docs/resources/core_vcn) | resource |
| [oci_core_images.ubuntu](https://registry.terraform.io/providers/oracle/oci/6.9.0/docs/data-sources/core_images) | data source |
| [oci_identity_availability_domains.ads](https://registry.terraform.io/providers/oracle/oci/6.9.0/docs/data-sources/identity_availability_domains) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_basename"></a> [basename](#input\_basename) | string to be used at start of resource name created | `string` | n/a | yes |
| <a name="input_database_port"></a> [database\_port](#input\_database\_port) | TCP port number for database comms | `number` | `27017` | no |
| <a name="input_parent_compartment"></a> [parent\_compartment](#input\_parent\_compartment) | ID of compartment to use for this project | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database_ip"></a> [database\_ip](#output\_database\_ip) | public IP for database server |
| <a name="output_web_ip"></a> [web\_ip](#output\_web\_ip) | public IP for web server |
