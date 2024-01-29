Role Name
=========

Deploy Lighthouse to selected hosts.

Requirements
------------

Ansible >= 2.10 version installed.

Role Variables
--------------

| Name                       | Default Value                           | Description     |
|----------------------------|-----------------------------------------|-----------------|
| lighthouse_vcs             | https://github.com/VKCOM/lighthouse.git | Download source |
| lighthouse_location_dir    | /var/www/lighthouse                     | Install path    |
| lighthouse_access_log_name | lighthouse                              | Access log name |
| nginx_user_name            | nginx                                   | Nginx user name |

Dependencies
------------

Role installation requires GIT installation

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - name: Install Lighthouse
      hosts: lighthouse
      roles:
        - lighthouse-role
      tags: lighthouse

License
-------

Free

Author Information
------------------

Ivan M