locals {
  ansible_extra_vars = {
    ansible_ssh_private_key_file = "/tmp/private_key.pem"
    ansible_user                 = var.ansible_ssh_remote_user
  }

  vms_with_expand = [for vm in var.vms : vm if vm.expand != null]
}
