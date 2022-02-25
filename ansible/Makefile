SHELL := /bin/bash
cnf ?= ../.env
include $(cnf)
export $(shell sed 's/=.*//' $(cnf))
VENV := source .venv/bin/activate

all: venv install format valid certs ssl playbook

.PHONY: venv
venv:
	@python -m venv .venv

.PHONY: install
install:
	@$(VENV); pip install --upgrade pip
	@$(VENV); pip install -r requirements.txt

.PHONY: valid
valid:
	@$(VENV); ansible all -m ping

.PHONY: format
format:
	@$(VENV); ./format.py

.PHONY: playbook
playbook:
	@$(VENV); ansible --version
	@$(VENV); ansible-playbook playbook.yml

.PHONY: certs
certs:
	@if [ ! -f ./consul/files/certs/consul-agent-ca.pem ]; then \
		docker run --rm -v $(shell pwd)/consul/files/certs/:/root -w /root consul keygen; \
		docker run --rm -v /tmp/:/tmp/ -w /tmp consul tls ca create; \
		docker run --rm -v /tmp/:/tmp/ -w /tmp consul tls cert create -server -dc dc01; \
		docker run --rm -v /tmp/:/tmp/ -w /tmp consul tls cert create -client -dc dc01; \
		sudo chown -R $$USER:$$USER /tmp/*.pem ; \
		mv /tmp/*consul*.pem $(shell pwd)/consul/files/certs/ ; \
	else \
		# echo "certificates exists"; \
		ls -lah ./consul/files/certs/ ;\
	fi

.PHONY: clean
clean:
	@rm -rf ./hostname.yml
	@rm -rf ./hosts.py
	@rm -rf ./hosts.ini
	@rm -rf ./__pycache__
	@rm -rf ./.venv
	@rm -rf consul/files/certs/*
	@rm -rf vault/files/ssl/*

.PHONY: ssl
ssl:		## Create SSL certificate in vault/files/ssl/
	@if [ ! -f vault/files/ssl/$(PROJECT_DOMAIN).crt ]; then \
		openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout vault/files/ssl/$(PROJECT_DOMAIN).key -out vault/files/ssl/$(PROJECT_DOMAIN).crt -subj "/C=/ST=/L=/O=/OU=/CN=" ;\
	else \
		echo "vault certificate exist"; \
	fi