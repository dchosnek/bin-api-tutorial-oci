data "oci_core_images" "ubuntu" {
  compartment_id           = var.parent_compartment
  operating_system         = "Canonical Ubuntu"
  operating_system_version = "22.04"
  shape                    = "VM.Standard.E2.1.Micro"
}

# used to determine the full AD (availability domain) name
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.parent_compartment
}

output "web_ip" {
  value       = oci_core_instance.web1.public_ip
  description = "public IP for web server"
}

output "database_ip" {
  value       = oci_core_instance.db1.public_ip
  description = "public IP for database server"
}

output "database_local_ip" {
  value       = oci_core_instance.db1.private_ip
  description = "private IP for database server"
}
