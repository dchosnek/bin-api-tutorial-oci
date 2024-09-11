# Configure NGINX

This role will install, configure, and enable the NGINX proxy service. The configuration is controlled by [this file](./files/nginx.conf) that will be copied to the host. This allows us to reconfigure the service without having to change any Ansible code.

## Intended configuration

The current configuration file is intended to route traffic to two locations:
1. Traffic to `/api/v1` goes to the flask application
1. Traffic to `/` goes to the static directory `/var/www/html`. This directory actually contains a React.js single-page app that makes API calls to `/api/v1`.

## Variables

This role uses no variables.
