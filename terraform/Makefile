SHELL := /bin/bash

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
	@sudo terraform init
	@sudo terraform plan -out=tfplan
	@sudo terraform apply -parallelism=20 -auto-approve

.PHONY: destroy
destroy:	## terraform destroy
	@sudo terraform destroy -auto-approve

.PHONY: console
console:	## terraform console
	@sudo terraform console

.PHONY: output
output:		## terraform output
	@sudo terraform refresh
	@terraform output > ../ansible/hosts.py

.PHONY: clean
clean:		## Limpa os arquivos que o terraform gera
	@sudo rm -rf ./terraform.tfstate.backup
	@sudo rm -rf ./terraform.tfstate
	@sudo rm -rf ./tfplan
	@sudo rm -rf ./.terraform
	@sudo rm -rf ./.terraform.lock.hcl