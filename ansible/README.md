# Ansible config for Bin API Tutorial in OCI

This folder contains a single Ansible playbook that configures both instances (web and database). The local config file points to the local inventory file. The local inventory file contains all variables needed for this playbook. So the playbook is easy to run:

```
ansible-playbook configure_bins_app.yml
```

Ansible does not need to install any Linux packages as that is done by the cloud-init scripts for each instance. This playbook only installs a few Python packages using `pip3`.

### Web

The **web** instance is configured by three roles. Each role has its own README in the role directory.
1. configure_flask
1. configure_nginx
1. deploy_react_app

### Database

The **database** instance is configured by individual tasks rather than roles.
1. Change the database configuration file to allow connections from other hosts
1. Restart the database service if the configuration file was changed

The database instance does not require any additional configuration because the application that accesses it will create the appropriate MongoDB database and collection.