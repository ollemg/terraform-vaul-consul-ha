SHELL := /bin/bash
cnf ?= ansible.env
VENV := source ~/.venv/bin/activate
PWD := pwd
include $(cnf)
export $(shell sed 's/=.*//' $(cnf))
all: install config format valid playbook

.PHONY: install
install:
	@$(VENV); pip install --upgrade pip
	@$(VENV); pip install -r requirements.txt

.PHONY: config
config:
	@$(VENV); set ANSIBLE_CONFIG=$(shell pwd)/ansible.cfg
	@$(VENV); ansible --version

.PHONY: valid
valid:
	@$(VENV); ANSIBLE_CONFIG=$(shell pwd)/ansible.cfg ansible all -m ping

.PHONY: format
format:
	@$(VENV); ./format.py

.PHONY: playbook
playbook:
	@$(VENV); echo $$ANSIBLE_CONFIG
	@$(VENV); ansible --version
	@$(VENV); ansible-playbook playbook.yml

.PHONY: certs
certs:
	@/usr/bin/docker run --rm -v $(shell pwd)/consul/files/certs/:/root -w /root consul keygen
	@/usr/bin/docker run --rm -v $(shell pwd)/consul/files/certs/:/root -w /root consul tls ca create
	@/usr/bin/docker run --rm -v $(shell pwd)/consul/files/certs/:/root -w /root consul tls cert create -server -dc dc01
	@/usr/bin/docker run --rm -v $(shell pwd)/consul/files/certs/:/root -w /root consul tls cert create -client -dc dc01

.PHONY: clean
clean:
	echo $$PATH
	@rm -rf ./hostname.yml
	@rm -rf ./hosts.py
	@rm -rf ./__pycache__