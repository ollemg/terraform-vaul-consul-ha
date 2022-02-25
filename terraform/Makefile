SHELL := /bin/bash
cnf ?= ../.env
include $(cnf)
export $(shell sed 's/=.*//' $(cnf))

all: deploy output

.PHONY: help
help:		## Show the help.
	@echo "Usage: make <target>"
	@echo ""
	@echo "** Sem target é executado deploy e output **"
	@echo "Targets:"
	@fgrep "##" Makefile | fgrep -v fgrep


.PHONY: deploy
deploy:		## terraform apply
	@env | grep TF_VAR_
	@terraform init
	@terraform plan -out=tfplan
	@terraform apply -auto-approve

.PHONY: destroy
destroy:	## terraform destroy
	@terraform destroy -auto-approve

.PHONY: console
console:	## terraform console
	@terraform console

.PHONY: output
output:		## terraform output
	@terraform refresh
	@terraform output > ../ansible/hosts.py

.PHONY: clean
clean:		## Limpa os arquivos que o terraform gera
	@rm -rf ./terraform.tfstate.backup
	@rm -rf ./terraform.tfstate
	@rm -rf ./tfplan
	@rm -rf ./.terraform
	@rm -rf ./.terraform.lock.hcl
	@rm -rf ./.terraform.log