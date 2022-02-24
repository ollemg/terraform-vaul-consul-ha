
all: deploy output

.PHONY: deploy
deploy:
	@sudo terraform init
	@sudo terraform plan -out=tfplan
	@sudo terraform apply -parallelism=20 -auto-approve
.PHONY: destroy
destroy:
	@sudo terraform destroy -auto-approve
.PHONY: output
output:
	@sudo terraform refresh
	@terraform output > ../ansible/hosts.py
.PHONY: clean
clean:
	@rm -rf ./terraform.tfstate.backup
	@rm -rf ./terraform.tfstate
	@rm -rf ./tfplan
	@rm -rf ./.terraform
	@rm -rf ./.terraform.lock.hcl