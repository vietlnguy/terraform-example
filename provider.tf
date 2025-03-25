terraform {
  required_version = ">=1.5.7"

  backend "http" {
  }

  required_providers {
    ansible = {
      source  = "ansible/ansible"
      version = "1.3.0"
    }
    solidserver = {
      source  = "EfficientIP-Labs/solidserver"
      version = "1.1.23"
    }
    citrixadc = {
      source  = "citrix/citrixadc"
      version = "1.42.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "3.23.0"
    }
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "2.6.0"
    }
  }
}

provider "solidserver" {
  host     = var.solidserver_server
  password = var.solidserver_password
  username = var.solidserver_username
}

provider "citrixadc" {
  endpoint = var.citrixadc_server
  password = var.citrixadc_password
  username = var.citrixadc_username
}

provider "vault" {
  address = "https://vault.example.example.edu"
}

provider "vsphere" {
  user                 = var.vsphere_username
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}
