TF = terraform
TF_VERSION := $(shell terraform version -json | jq -r '.terraform_version')

.PHONY: all version plan apply clean

all: version plan apply

version:
	@echo "Terraform version: $(TF_VERSION)"

plan:
	@$(TF) init -input=false
	@$(TF) plan -var="terraform_version=$(TF_VERSION)" -out=tfplan.out

apply:
	@$(TF) apply -var="terraform_version=$(TF_VERSION)" -input=false tfplan.out

clean:
	@rm -f tfplan.out
	@rm -rf .terraform .terraform.lock.hcl terraform.tfstate terraform.tfstate.backup hello.txt
