#!/usr/bin/env python
from hosts import *
import yaml
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

for ips in vms:
    with open('hosts.ini', 'a') as ansible:
        ansible.write(f'{ips}\n')
        ansible.close()

with open('hosts.ini', 'a') as ansible:
    ansible.write(ansible_vars)
    ansible.close()

ansible_vars = dict(zip(names, vms))


with open('hostname.yml', 'w') as yaml_file:
    yaml.dump(ansible_vars, yaml_file, default_flow_style=False)


print(ansible_vars)
