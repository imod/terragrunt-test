terraform {
  backend "local" {}
}

variable "environement" {
}

resource "null_resource" "backend-dummy" {
  provisioner "local-exec" {
    command = format("echo hallo %s", var.environement)
  }
}
