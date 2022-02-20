#!/usr/bin/env python
from hosts import *
import yaml

hosts = f"""
# consul
[{vms[0]}]
{vms[1]} hostname_suffix={vms[0]}

[{vms[2]}]
{vms[3]} hostname_suffix={vms[2]}

[{vms[4]}]
{vms[5]} hostname_suffix={vms[4]}

# vault
[{vms[6]}]
{vms[7]} hostname_suffix={vms[6]}

[{vms[8]}]
{vms[9]} hostname_suffix={vms[8]}

[{vms[10]}]
{vms[11]} hostname_suffix={vms[10]}

[consul:children]
{vms[0]}
{vms[2]}
{vms[4]}

[vault:children]
{vms[6]}
{vms[8]}
{vms[10]}

[all:vars]
ansible_user=rocky
ansible_password=rockylinux
ansible_become_password=rockylinux
"""

with open('ansible/hosts.ini', 'w') as ansible:
    ansible.write(hosts)
    ansible.close()