terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

provider "local" {}

# Variable to receive Terraform version from Makefile
variable "terraform_version" {
  type    = string
  default = "unknown"
}

# Create a file with the Terraform version embedded in the content
resource "local_file" "hello" {
  content  = "Hello from Terraform ${var.terraform_version}!\n"
  filename = "${path.module}/hello.txt"
}

# Ensure the file has correct permissions (not executable)
resource "null_resource" "set_permissions" {
  depends_on = [local_file.hello]

  provisioner "local-exec" {
    command = "chmod 0644 ${local_file.hello.filename}"
  }
}
