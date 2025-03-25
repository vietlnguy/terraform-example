variable "ansible_custom_roles" {
  type        = list(any)
  description = "List of custom ansible roles to install"
}

variable "ansible_dir" {
  type        = string
  description = "Directory where ansible files are store (do not include ending /)"
  default     = "ansible"
}

variable "ansible_extra_vars" {
  type        = map(any)
  description = "Ansible extra vars to pass to the playbook"
  default     = {}
}

variable "ansible_hashi_vault_token" {
  type        = string
  description = "Vault token to use with ansible playbook"
}

variable "ansible_playbook_file" {
  type        = string
  description = "Ansible playbook file"
  default     = "playbook.yml"
}

variable "ansible_roles_group_token" {
  type        = string
  description = "Group token used to access private ansible roles"
  default     = "playbook.yml"
}

variable "ansible_roles_group_username" {
  type        = string
  description = "Group username used to access private ansible roles"
  default     = "playbook.yml"
}

variable "ansible_ssh_private_key_file" {
  type        = string
  description = "The private key file used to access inventory items"
}

variable "ansible_ssh_remote_user" {
  type        = string
  description = "Ansible remote ssh user"
}

variable "ansible_tags" {
  type        = list(string)
  description = "Ansible tags"
  default     = []
}

variable "ansible_var_files" {
  type        = list(any)
  description = "List of paths to Ansible var files"
  default     = []
}

variable "citrixadc" {
  type        = map(any)
  description = "Citrix ADC map"
}

variable "citrixadc_password" {
  type        = string
  description = "Citrix ADC password"
}

variable "citrixadc_server" {
  type        = string
  description = "Citrix ADC server to connect to"
}

variable "citrixadc_username" {
  type        = string
  description = "Citrix ADC username"
}

variable "falcon_cid" {
  type        = string
  description = "Falcon CID"
}

variable "nodes" {
  type        = list(string)
  description = "List of node ip addresses"
  default     = []
}

variable "solidserver_ip_addresses" {
  type        = map(any)
  description = "Solidserver ip address map"
  default     = {}
}

variable "solidserver_password" {
  type        = string
  description = "SolidServer password"
}

variable "solidserver_server" {
  type        = string
  description = "SolidServer server to connect to"
}

variable "solidserver_username" {
  type        = string
  description = "SolidServer username"
}

variable "vms" {
  type        = map(any)
  description = "List of virtual machines to be deployed"
  default     = {}
}

variable "vsphere_password" {
  type        = string
  description = "VSphere password"
}

variable "vsphere_project_folder" {
  type        = string
  description = "Sub folder, under the folder Terraform-Managed, to place the vm's"
  default     = "example"
}

variable "vsphere_project_subfolder" {
  type        = string
  description = "Sub folder, under the folder Terraform-Managed/vsphere_project_folder, to place the vm's"
  default     = ""
}

variable "vsphere_server" {
  type        = string
  description = "VSphere server to connect to"
}

variable "vsphere_username" {
  type        = string
  description = "VSphere username"
}

variable "solidserver_cnames" {
  type = list(string)
  description = "List of cnames"
  default = []
}