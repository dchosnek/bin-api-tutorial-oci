resource "oci_core_instance" "web1" {
  display_name         = "${var.basename}-web"
  compartment_id       = var.parent_compartment
  availability_domain  = data.oci_identity_availability_domains.ads.availability_domains[1].name
  shape                = "VM.Standard.E2.1.Micro"
  preserve_boot_volume = false

  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.ubuntu.images[0].id
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.public.id
    assign_public_ip = true
    nsg_ids          = [oci_core_network_security_group.web1.id]
  }

  # define the SSH public key for access
  metadata = {
    ssh_authorized_keys = file("~/.ssh/id_ed25519.pub")
    user_data           = base64encode(file("${path.module}/cloud-init-web.sh"))
  }
}

resource "oci_core_instance" "db1" {
  display_name         = "${var.basename}-db"
  compartment_id       = var.parent_compartment
  availability_domain  = data.oci_identity_availability_domains.ads.availability_domains[1].name
  shape                = "VM.Standard.E2.1.Micro"
  preserve_boot_volume = false

  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.ubuntu.images[0].id
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.public.id
    assign_public_ip = true
    nsg_ids          = [oci_core_network_security_group.database1.id]
  }

  # define the SSH public key for access
  metadata = {
    ssh_authorized_keys = file("~/.ssh/id_ed25519.pub")
    user_data           = base64encode(file("${path.module}/cloud-init-db.sh"))
  }
}
