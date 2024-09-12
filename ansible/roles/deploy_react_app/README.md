# Deploy React.js app

This role will deploy a React app that has already been built. It will
1. Copy the static build files to `/var/www/html/`
1. Update `config.json` to contain the public IP address of the web server

## Intended configuration

The app is placed in the `/var/www/html` folder to be served by a web server service. The template file `config_json.j2` sets the IP address for the API calls performed by the app to be the target machine's IP address. In other words, the backend API should be on the same machine as the frontend UI.

## Variables

This role uses one variable:
* `inventory_hostname` is a built-in Ansible variable for the hostname (or IP) in inventory. Using Ansible `gather_facts` to get the IP of the host does not work as the host does not know its own *public* IP address.