
all: tf-deploy tf-output

tf-deploy:
	@sudo terraform init
	@sudo terraform plan -out=tfplan
	@sudo terraform apply -auto-approve
tf-destroy:
	@sudo terraform destroy -auto-approve
tf-output:
	@sudo terraform refresh
	@terraform output > ../hosts.py