Role Name
=========

Deploy Vector to selected hosts.

Requirements
------------

Ansible >= 2.10.4 version installed.

Role Variables
--------------


| Name              | Default Value                                                       | Description                    |
|-------------------|---------------------------------------------------------------------|--------------------------------|
| vector_url        | https://packages.timber.io/vector/0.33.1/vector-0.33.1-1.x86_64.rpm | Download source                |
| vector_config_dir | /etc/vector                                                         | Install path                   |
| data_dir          | /var/lib/vector                                                     | Vector data directory          |
| sources           |                                                                     | For Vector configuration       |
| sinks             |                                                                     | Connect to clickhouse settings |

Dependencies
------------

No dependencies

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - name: Install Vector
      hosts: vector
      roles:
        - vector-role
      tags: vector

License
-------

Free

Author Information
------------------

Ivan M