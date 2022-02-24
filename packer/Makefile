SHELL := /bin/bash
all: build

.PHONY: help
help:		## Show the help.
	@echo "Usage: make <target>"
	@echo ""
	@echo "** Sem target é executado build **"
	@echo "Targets:"
	@fgrep "##" Makefile | fgrep -v fgrep

.PHONY: build
build:		## Cria o disco para o terraform
	@if [ ! -f output/rocky8_5 ]; then \
		ls -lah packer/output/rocky8_5 ; \
		packer init . ; \
		packer validate . ; \
		packer build . ; \
	else \
		echo "Disco já existe!" ;\
	fi