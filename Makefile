SHELL := /bin/bash
cnf ?= project.env
include $(cnf)
export $(shell sed 's/=.*//' $(cnf))


all: deploy

.PHONY: help
help:		## Show the help.
	@echo "Usage: make <target>"
	@echo ""
	@echo "Targets:"
	@fgrep "##" Makefile | fgrep -v fgrep


#.PHONY: ssl
ssl:		## Create SSL certificate in ./config_nc_web/files/ssl/
	cert=ollemg.br
	@openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ./ansible/vault/files/ssl/ollemg.br.key -out ./role_nginx/files/ssl/ollemg.br.crt

.PHONY: deploy
deploy:		## Terraform deploy
	# make -C packer
	make -C terraform
	@source .venv/bin/activate; \
	./format-test.py
	make -C ansible

.PHONY: destroy
destroy:		## Terraform destroy
	make -C terraform tf-destroy

format:
	terraform fmt terraform/
	packer fmt packer/
	ansible-lint ansible/playbook.yml
	ansible-playbook --syntax-check ansible/playbook.yml

# Get the latest tag
TAG=$(shell git describe --tags --abbrev=0)
# GIT_COMMIT=$(shell git log -1 --format=%h)
TERRAFORM_VERSION=1.1.6

# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html

terraform-init: ## Run terraform init to download all necessary plugins
	docker run --rm -v $$PWD:/app -v $$HOME/.ssh/:/root/.ssh/ -w /app/ -e TF_VAR_APP_VERSION=$(GIT_COMMIT) hashicorp/terraform:$(TERRAFORM_VERSION) init -upgrade=true

terraform-plan: ## Exec a terraform plan and puts it on a file called tfplan
	docker run --rm -v $$PWD:/app -v $$HOME/.ssh/:/root/.ssh/ -w /app/ -e TF_VAR_APP_VERSION=$(GIT_COMMIT) hashicorp/terraform:$(TERRAFORM_VERSION) plan -out=tfplan

terraform-apply: ## Uses tfplan to apply the changes on AWS.
	docker run --rm -v $$PWD:/app -v $$HOME/.ssh/:/root/.ssh/ -w /app/ -e TF_VAR_APP_VERSION=$(GIT_COMMIT) hashicorp/terraform:$(TERRAFORM_VERSION) apply -auto-approve

terraform-destroy: ## Destroy all resources created by the terraform file in this repo.
	docker run --rm -v $$PWD:/app -v $$HOME/.ssh/:/root/.ssh/ -w /app/ -e TF_VAR_APP_VERSION=$(GIT_COMMIT) hashicorp/terraform:$(TERRAFORM_VERSION) destroy -auto-approve

terraform-set-workspace-dev: ## Set workspace dev
	docker run --rm -v $$PWD:/app -v $$HOME/.ssh/:/root/.ssh/ -w /app/ -e TF_VAR_APP_VERSION=$(GIT_COMMIT) hashicorp/terraform:$(TERRAFORM_VERSION) workspace select dev

terraform-set-workspace-prod: ## Set workspace production
	docker run --rm -v $$PWD:/app -v $$HOME/.ssh/:/root/.ssh/ -w /app/ -e TF_VAR_APP_VERSION=$(GIT_COMMIT) hashicorp/terraform:$(TERRAFORM_VERSION) workspace select prod

terraform-set-workspace-staging: ## Set workspace staging
	docker run --rm -v $$PWD:/app -v $$HOME/.ssh/:/root/.ssh/ -w /app/ -e TF_VAR_APP_VERSION=$(GIT_COMMIT) hashicorp/terraform:$(TERRAFORM_VERSION) workspace select staging

terraform-new-workspace-staging: ## Create workspace staging
	docker run --rm -v $$PWD:/app -v $$HOME/.ssh/:/root/.ssh/ -w /app/ -e TF_VAR_APP_VERSION=$(GIT_COMMIT) hashicorp/terraform:$(TERRAFORM_VERSION) workspace new staging

terraform-sh: ## terraform console
	docker run -it --rm -v $$PWD:/app -v $$HOME/.ssh/:/root/.ssh/ -w /app/ -e TF_VAR_APP_VERSION=$(GIT_COMMIT) --entrypoint "" hashicorp/terraform:$(TERRAFORM_VERSION) sh

packer-build: ## packer build
	docker run -it --rm -v $$PWD:/app -v $$HOME/.ssh/:/root/.ssh/ -w /app/ -e TF_VAR_APP_VERSION=$(GIT_COMMIT) hashicorp/packer build examples/consul-ami/consul.json

packer-sh: ## packer console
	docker run -it --rm -v $$PWD:/app -v $$HOME/.ssh/:/root/.ssh/ -w /app/ -e TF_VAR_APP_VERSION=$(GIT_COMMIT) --entrypoint "" hashicorp/packer sh