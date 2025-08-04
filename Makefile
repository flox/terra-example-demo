TF = terraform

.PHONY: all version plan apply clean

all: version plan apply

version:
	@echo "Terraform version:"
	@$(TF) version

plan:
	@echo "\nRunning terraform init and plan..."
	@$(TF) init -input=false
	@$(TF) plan -out=tfplan.out

apply:
	@echo "\nApplying the terraform plan..."
	@$(TF) apply -input=false tfplan.out

clean:
	@echo "\nCleaning up local terraform state..."
	@rm -f tfplan.out
	@rm -rf .terraform .terraform.lock.hcl terraform.tfstate terraform.tfstate.backup hello.txt
