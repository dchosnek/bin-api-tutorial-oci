# Bins API for OCI

Deploy and configure the Bins Tutorial API in OCI. This is deployed as an app on two instances (database is its own instance) because the OCI free tier provides two instances for free.

Choosing where Terraform "stops" and Ansible "starts" is a bit subjective. The cloud-init scripts created by Terraform for OCI install packages, but that could be done entirely by Ansible. It did make sense to me to configure the host firewall in cloud-init so that the firewall is properly configured as early as possible in the process.

## Terraform

The `terraform` folder contains the hardware configuration to create subnets, routes, security groups and instances. It also populates a cloud-init script on each instance that will configure the local firewall and install the required packages.

Both instances are placed on the public subnet. The OCI free tier does not allow for NAT gateways. The database server should be placed on a private subnet, but without a NAT gateway, it would be impossible to download the needed packages from the internet. 

## Ansible

The `ansible` folder contains the software configuration to configure the appropriate configuration files on the server and copy the required web and application files.

A few high-level tasks performed by Ansible:
* copy the Flask app to the instance
* configure Gunicorn to host the Flask app
* copy the built React.js site
* configure NGINX to route traffic to both Gunicorn and the React.js files appropriately
* configure the database to accept traffic from other hosts

## How to use this repository

### Step 1: Create a providers file

Create a file in the Terraform directory that specifies the provider and your credentials. It should look like the following.

```terraform
terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
      version = "6.9.0"
    }
  }
}

provider "oci" {
  tenancy_ocid     = "ocid1.tenancy.oc1.."
  user_ocid        = "ocid1.user.oc1.."
  fingerprint      = "11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff:00"
  private_key_path = "~/.oci/my_key.pem"
  region           = "us-ashburn-1"
}
```

### Step 2: Initialize the project

Execute `terraform init` to download the provider.

### Step 3: Execute the plan

Execute `terraform apply` to build the infrastructure and deploy the two instances. The public IP addresses of both instances and the private IP of the database instance are shown as outputs like the following example.

```ini
database_ip = "129.213.177.15"
database_local_ip = "10.0.0.89"
web_ip = "129.80.110.116"
```

### Step 4: Update the Ansible inventory file

Use the IP addresses from the previous step to update the `inventory/inventory` file in the Ansible directory. The `ansible.cfg` file points to this directory for inventory to avoid having to specify inventory when running the playbook.

```ini
[database]
129.213.177.15

[web]
129.80.110.116

[all:vars]
ansible_user=ubuntu 
database_local_ip=10.0.0.89
```

### Step 5: Execute the Ansible playbook

Execute `ansible-playbook configure_bins_app.yml` to udpate both OCI instances appropriately.

### Step 6: Access the application

This is an HTTP server, not an HTTPS server. The final task in the Ansible playbook is to display a message with the link to access the application.

`Access the application at http://129.80.110.116/`
