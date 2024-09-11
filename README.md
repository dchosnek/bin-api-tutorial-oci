# Bins API for OCI

Deploy and configure the Bins Tutorial API in OCI. This is deployed as an app on two instances (database is its own instance) because the OCI free tier provides two instances for free.

## Terraform

The `terraform` folder contains the hardware configuration to create subnets, routes, security groups and instances. It also populates a cloud-init script on each instance that will configure the local firewall and install the required packages.

## Ansible

*COMING SOON* The `ansible` folder contains the software configuration to configure the appropriate configuration files on the server and copy the required web and application files.