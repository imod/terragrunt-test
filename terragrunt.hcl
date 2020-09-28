remote_state {
  backend = "azurerm"
  config = {
    resource_group_name  = "XXX"
    storage_account_name = "XXX"
    container_name       = "testcontainer"
    key                  = "${path_relative_to_include()}/terraform.tfstate"
  }
}
