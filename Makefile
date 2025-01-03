TERRAFORM_DIR := terraform

init:
	@echo "Initializing Terraform..."
	cd $(TERRAFORM_DIR) && terraform init

up: init
	@echo "Applying Terraform configuration..."
	cd $(TERRAFORM_DIR) && terraform apply -auto-approve

down: init
	@echo "Destroying all Terraform resources..."
	cd $(TERRAFORM_DIR) && terraform destroy -auto-approve

plan: init
	@echo "Showing Terraform plan..."
	cd $(TERRAFORM_DIR) && terraform plan

fmt:
	@echo "Formatting Terraform configuration..."
	cd $(TERRAFORM_DIR) && terraform fmt -recursive

validate:
	@echo "Validating Terraform configuration..."
	cd $(TERRAFORM_DIR) && terraform validate

clean:
	@echo "Cleaning up Terraform state files..."
	rm -rf $(TERRAFORM_DIR)/.terraform $(TERRAFORM_DIR)/.terraform.lock.hcl

.PHONY: init up down plan fmt validate clean

