#!/usr/bin/env python
import yaml
from hosts import *
from yaml.loader import SafeLoader

ansible_vars = f"""
[all:vars]
ansible_user=rocky
ansible_password=rockylinux
ansible_become_password=rockylinux
"""

with open('hosts.ini', 'w') as ansible:
    ansible.write('[all]\n')
    ansible.close()

for ip_index in ip_address:
    with open('hosts.ini', 'a') as ansible:
        ansible.write(f'{ip_index}\n')
        ansible.close()

with open('hosts.ini', 'a') as ansible:
    ansible.write(ansible_vars)
    ansible.close()


ansible_vars = dict(zip(hostname, ip_address))
ansible_vars['total_servers'] = total_servers

with open('terraform.yml', 'w') as yaml_file:
    yaml.dump(ansible_vars, yaml_file, default_flow_style=False)


print(ansible_vars)
