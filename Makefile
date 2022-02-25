SHELL := /bin/bash
cnf ?= .env
include $(cnf)
export $(shell sed 's/=.*//' $(cnf))


all: requirements deploy

.PHONY: help
help:		## Show the help.
	@echo "Usage: make <target>"
	@echo ""
	@echo "** Sem target é executado requirements e deploy **"
	@echo "Targets:"
	@fgrep "##" Makefile | fgrep -v fgrep

.PHONY:	requirements
requirements:	## Valida se os binários necessários estão instalados
	@which packer
	@which terraform
	@which docker
	@which python

.PHONY: deploy
deploy:		## Cria o cluster do vault
	@if [ ! -f packer/output/rocky8_5 ]; then \
		make -C packer ;\
	else \
		echo "Disk exist!" ;\
	fi
	make -C terraform
	make -C ansible

.PHONY: destroy
destroy:	## Remove todos os recursos que o terraform criou
	make -C terraform destroy
	make -C ansible clean
	make -C terraform clean

.PHONY: output
output:		## Executa o comando de saida do terraform
	make -C terraform output

.PHONY: console
console:	## Executa o comando de debug do terraform
	make -C terraform console

.PHONY: playbook
playbook:	## executa o playbook do ansible
	make -C ansible playbook

.PHONY: clean
clean:		## executa limpeza nos arquivos
	make -C ansible clean
	make -C terraform clean

.PHONY: build
build:		## cria a imagem que será utilizada no terraform
	make -C packer build

.PHONY: remove
remove:		## delete o disco template
	make -C packer remove

.PHONY: format
format:		## Ajusta a identação dos arquivos
	terraform fmt terraform/
	packer fmt packer/
	ansible-lint ansible/playbook.yml
	ansible-playbook --syntax-check ansible/playbook.yml
