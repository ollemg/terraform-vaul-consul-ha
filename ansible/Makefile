SHELL := /bin/bash

all: valid playbook

venv:
	@source .venv/bin/activate; \
	which python
	which ansible
as-conf:
	@export ANSIBLE_CONFIG=$(shell pwd)/ansible.cfg
	@source .venv/bin/activate; \
	ansible --version
valid:
	@export ANSIBLE_CONFIG=$(shell pwd)/ansible.cfg
	@source .venv/bin/activate; \
	ansible consul -m ping
	@source .venv/bin/activate; \
	ansible vault -m ping
playbook:
	@export ANSIBLE_CONFIG=$(shell pwd)/ansible.cfg
	@source .venv/bin/activate; \
	ansible-playbook playbook.yml
teste:
	echo $(shell pwd)
	export ANSIBLE_CONFIG=$(shell pwd)/ansible.cfg
	echo $$ANSIBLE_CONFIG
	ansible --version
.PHONY: python
python:
	#@pyenv install 3.9.10
	@pyenv local 3.9.10
	@python -m venv .venv
	@pip install --upgrade pip
	@pip install -r requirements.txt
	@echo "!!! Please run 'source .venv/bin/activate' to enable the environment !!!"