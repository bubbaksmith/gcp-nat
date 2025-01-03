TERRAFORM_DIR := terraform

up: init
	@echo "Applying Terraform configuration..."
	cd $(TERRAFORM_DIR) && terraform apply -auto-approve

down: init
	@echo "Destroying all Terraform resources..."
	cd $(TERRAFORM_DIR) && terraform destroy -auto-approve

ssh:
	@echo "Connecting via gcloud compute ssh..."
	gcloud compute ssh --zone "us-central1-a" "instance1" --tunnel-through-iap --project "nat-dev-1"

ssh-nat:
	@echo "Connecting to nat via gcloud compute ssh..."
	gcloud compute ssh --zone "us-central1-a" "nat1" --tunnel-through-iap --project "nat-dev-1"

init:
	@echo "Initializing Terraform..."
	cd $(TERRAFORM_DIR) && terraform init

plan: init
	@echo "Showing Terraform plan..."
	cd $(TERRAFORM_DIR) && terraform plan

fmt:
	@echo "Formatting Terraform configuration..."
	cd $(TERRAFORM_DIR) && terraform fmt -recursive

.PHONY: *

