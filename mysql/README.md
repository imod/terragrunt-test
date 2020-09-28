# terragrunt-test

demonstrates the problem described at: https://github.com/gruntwork-io/terragrunt/issues/1376

Following the description given at for [passing outputs between modules](https://terragrunt.gruntwork.io/docs/features/execute-terraform-commands-on-multiple-modules-at-once/#passing-outputs-between-modules), I have the following:

```
root
├─ terragrunt.hcl
├── backend-app
│   ├── main.tf
│   └── terragrunt.hcl
└── mysql
    ├── main.tf
    └── terragrunt.hcl
```

The `terragrunt.hcl` in the `root` folder only contains the `remote_state` configuration:

```
remote_state {
  backend = "azurerm"
  config = {
    resource_group_name  = "XXX"
    storage_account_name = "XXX"
    container_name       = "XXX"
    key                  = "${path_relative_to_include()}/terraform.tfstate"
  }
}
```

For `backend-app` I define a variable called `environment` and the the following dependency:

```
include {
  path = find_in_parent_folders()
}
dependency "mysql" {
  config_path = "../mysql"
}
inputs = {
  vpc_id = dependency.mysql.outputs.environment
}
```

Now I would expect the following to work:

```
cd root
terragrunt apply mysql
terragrunt apply backend-app
```

...but I get a prompt asking me for the value of `environment` (Note: I'm starting `terragrunt from within the root directory)

In my experience this only works when I do the following:

```
cd vpc
terragrunt apply
cd ../backend-app
terragrunt apply
```

Note: I'm always changing into the module folders and start terragrunt from there.

Is this correct, is this expected or am I doing something wrong?
