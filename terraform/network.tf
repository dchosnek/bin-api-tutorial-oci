# =============================================================================
# Virtual Cloud Network (VCN)
resource "oci_core_vcn" "vcn1" {

  display_name   = "${var.basename}-vcn"
  cidr_blocks    = ["10.0.0.0/16"]
  is_ipv6enabled = false
  compartment_id = var.parent_compartment
}

# =============================================================================
# Subnets (public and private)
resource "oci_core_subnet" "public" {

  display_name      = "${var.basename}-public"
  cidr_block        = "10.0.0.0/24"
  route_table_id    = oci_core_route_table.outbound.id
  security_list_ids = [oci_core_security_list.primary.id]

  compartment_id = var.parent_compartment
  vcn_id         = oci_core_vcn.vcn1.id
}

resource "oci_core_subnet" "private" {

  display_name = "${var.basename}-private"
  cidr_block   = "10.0.1.0/24"

  # this is what makes it private
  prohibit_public_ip_on_vnic = true
  prohibit_internet_ingress  = true


  compartment_id = var.parent_compartment
  vcn_id         = oci_core_vcn.vcn1.id
}

# =============================================================================
# Route table
resource "oci_core_route_table" "outbound" {

  display_name = "${var.basename}-outbound-routes"
  route_rules {
    description       = "outbound internet access"
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.public_igw.id
  }

  compartment_id = var.parent_compartment
  vcn_id         = oci_core_vcn.vcn1.id
}

# =============================================================================
# Internet gateway
resource "oci_core_internet_gateway" "public_igw" {
  enabled        = true
  display_name   = "${var.basename}-igw"
  compartment_id = var.parent_compartment
  vcn_id         = oci_core_vcn.vcn1.id
}

# =============================================================================
# NAT gateway -- free accounts can't create these!!!
# resource "oci_core_nat_gateway" "nat_gateway1" {
#   display_name   = "${var.basename}-nat1"
#   route_table_id = oci_core_route_table.outbound.id
#   compartment_id = var.parent_compartment
#   vcn_id         = oci_core_vcn.vcn1.id
# }

# =============================================================================
# Security list
resource "oci_core_security_list" "primary" {
  display_name = "${var.basename}-securitylist"

  egress_security_rules {
    description = "allow all outbound traffic"
    destination = "0.0.0.0/0"
    protocol    = "all"
    stateless   = false
  }

  ingress_security_rules {
    description = "allow inbound SSH"
    source      = "0.0.0.0/0"
    protocol    = "6" # TCP
    stateless   = false
    tcp_options {
      min = 22
      max = 22
    }
  }

  ingress_security_rules {
    protocol = "1" # ICMP
    source   = "0.0.0.0/0"

    icmp_options {
      type = 8 # echo request
      code = 0
    }
  }

  ingress_security_rules {
    protocol = "1" # ICMP
    source   = "0.0.0.0/0"

    icmp_options {
      type = 0 # echo reply
      code = 0
    }
  }

  compartment_id = var.parent_compartment
  vcn_id         = oci_core_vcn.vcn1.id
}

# =============================================================================
# Network Security Groups (NSG)
resource "oci_core_network_security_group" "database1" {
  #Required
  compartment_id = var.parent_compartment
  vcn_id         = oci_core_vcn.vcn1.id
  display_name   = "${var.basename}-database"
}

resource "oci_core_network_security_group" "web1" {
  #Required
  compartment_id = var.parent_compartment
  vcn_id         = oci_core_vcn.vcn1.id
  display_name   = "${var.basename}-web"
}

resource "oci_core_network_security_group_security_rule" "rule1" {
  #Required
  network_security_group_id = oci_core_network_security_group.database1.id
  direction                 = "INGRESS"
  protocol                  = 6   # TCP

  #Optional
  description = "allow mongodb ingress"
  destination = oci_core_network_security_group.database1.id
  source      = oci_core_network_security_group.web1.id
  source_type = "NETWORK_SECURITY_GROUP"
  stateless   = false

  tcp_options {
    destination_port_range {
      min = var.database_port
      max = var.database_port
    }
  }
}

resource "oci_core_network_security_group_security_rule" "rule2" {
  #Required
  network_security_group_id = oci_core_network_security_group.web1.id
  direction                 = "INGRESS"
  protocol                  = 6   # TCP

  #Optional
  description = "allow HTTP ingress"
  destination = oci_core_network_security_group.web1.id
  source      = "0.0.0.0/0"
  source_type = "CIDR_BLOCK"
  stateless   = false

  tcp_options {
    destination_port_range {
      min = 80
      max = 80
    }
  }
}
