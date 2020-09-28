include {
  path = find_in_parent_folders()
}

dependency "mysql" {
  config_path = "../mysql"
}

inputs = {
  environment = dependency.mysql.outputs.environement
}
