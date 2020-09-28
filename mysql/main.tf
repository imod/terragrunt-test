terraform {
  backend "azurerm" {}
}

resource "null_resource" "mysql-dummy" {
  provisioner "local-exec" {
    command = "echo hello mysql"
  }
}

output "environment" {
  value = "CI"
}
