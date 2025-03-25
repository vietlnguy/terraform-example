module "vsphere" {
  source  = "gitlab.example.example.edu/core-services/vsphere/local"
  version = ">=0.0.13"

  for_each = var.vms

  vsphere_project_folder      = var.vsphere_project_folder
  vsphere_project_subfolder   = var.vsphere_project_subfolder
  name                        = each.value.name
  ip                          = each.value.ip
  memory                      = each.value.memory
  attributes_application_env  = each.value.attributes_application_env
  attributes_application_type = each.value.attributes_application_type
  attributes_applications     = each.value.attributes_applications
  attributes_poc_email        = each.value.attributes_poc_email
  attributes_poc_name         = each.value.attributes_poc_name
  template_disks              = each.value.template_disks
  # additional_disks          = each.value.additional_disks
}

module "ansible-galaxy" {
  source  = "gitlab.example.example.edu/core-services/ansible-galaxy/local"
  version = ">=0.0.3"

  ansible_roles_group_username = var.ansible_roles_group_username
  ansible_roles_group_token    = var.ansible_roles_group_token
  ansible_custom_roles         = var.ansible_custom_roles
  depends_on = [
    module.vsphere
  ]
}

module "ansible" {
  source  = "gitlab.example.example.edu/core-services/ansible-playbook/local"
  version = ">=1.3.0"

  for_each = { for vm in var.vms : vm.name => vm }

  ansible_dir        = var.ansible_dir
  ansible_extra_vars = merge(local.ansible_extra_vars, var.ansible_extra_vars)
  ansible_tags       = ["falcon-sensor", "sudoers", "user", "client-key", "host-key", "site24x7", "swap"]
  ansible_var_files  = var.ansible_var_files
  hostname           = each.value.ip

  depends_on = [
    module.ansible-galaxy
  ]
}

module "ansible-expand" {
  source  = "gitlab.example.example.edu/core-services/ansible-playbook/local"
  version = ">=1.3.0"

  for_each = { for vm in local.vms_with_expand : vm.name => vm }

  ansible_dir        = var.ansible_dir
  ansible_extra_vars = merge(local.ansible_extra_vars, { expand = jsonencode(each.value.expand) })
  ansible_tags       = ["expand"]
  ansible_var_files  = var.ansible_var_files

  hostname = each.value.ip

  depends_on = [
    module.ansible
  ]
}

module "citrixadc" {
  source  = "gitlab.example.example.edu/core-services/citrix-adc/local"
  version = ">=1.42.0"

  servers             = var.citrixadc.servers
  services            = var.citrixadc.services
  virtual_servers     = var.citrixadc.virtual_servers
  service_bindings    = var.citrixadc.service_bindings
  sslcertkey_bindings = var.citrixadc.sslcertkey_bindings
  sslservers          = var.citrixadc.sslservers
  rewrite_bindings    = var.citrixadc.rewrite_bindings
}

module "solidserver_ip_address" {
  source  = "gitlab.example.example.edu/core-services/ip-address/local"
  version = ">=1.1.23"

  for_each = { for solidserver_ip_address in var.solidserver_ip_addresses : solidserver_ip_address.hostname => solidserver_ip_address }

  hostname   = each.value.hostname
  request_ip = each.value.request_ip
}

# Add CNAME for mdoc-dev to example-staging.example.example.edu
resource "solidserver_ip_alias" "primary_alias" {
  for_each = toset(var.solidserver_cnames)
  
  space   = "example"
  address = var.solidserver_ip_addresses.example.request_ip #the IP address of the destination. i.e example-staging IP
  name    = "${each.value}.example.example.edu" #the source address that you want to be redirected i.e. mdoc-dev
  type    = "CNAME"
}

resource "null_resource" "cleanup" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command    = "rm -fr /tmp/private_key.pem"
    on_failure = continue
  }

  provisioner "local-exec" {
    command    = "rm -fr ansible/vars/env.yml"
    on_failure = continue
  }

  depends_on = [
    module.ansible-expand
  ]
}
