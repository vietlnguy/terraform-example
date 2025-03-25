ansible_custom_roles = [
  {
    repo    = "gitlab.example.example.edu/core-services/utils/ansible-roles/falcon-sensor.git"
    version = "0.0.5"
  },
  {
    repo    = "gitlab.example.example.edu/core-services/utils/ansible-roles/user.git"
    version = "0.0.2"
  },
  {
    repo    = "gitlab.example.example.edu/core-services/utils/ansible-roles/host-key.git"
    version = "0.0.1"
  },
  {
    repo    = "gitlab.example.example.edu/core-services/utils/ansible-roles/client-key.git"
    version = "0.0.1"
  },
  {
    repo    = "gitlab.example.example.edu/core-services/utils/ansible-roles/expand.git"
    version = "0.0.1"
  },
  {
    repo    = "gitlab.example.example.edu/core-services/utils/ansible-roles/site24x7.git"
    version = "0.0.6"
  }
]

ansible_var_files = [
  "ansible/vars/production.yml",
  "ansible/vars/env.yml"
]

nodes = [
  "example-prod01.example.example.int",
  "example-prod02.example.example.int"
]

citrixadc = {
  servers = {
    prod01 = {
      name      = "example-prod01"
      ipaddress = "example"
    }
  }
  services = {
    prod01_80 = {
      name       = "example-prod"
      servername = "example-prod01"
    }
    prod01_5432 = {
      name        = "example-prod-psql"
      port        = 5432
      servername  = "example-prod01"
      servicetype = "TCP"
    }
  }
  virtual_servers = {
    prod01_443 = {
      ipv46 = "example"
      name  = "example-prod"
    }
    prod01_5432 = {
      ipv46       = "example"
      port        = 5432
      name        = "example-prod-psql"
      servicetype = "TCP"
    }
  }
  service_bindings = {
    prod01_443 = {
      servicename = "example-prod"
      vservername = "example-prod"
    }
    prod01_5432 = {
      servicename = "example-prod-psql"
      vservername = "example-prod-psql"
    }
  }
  sslcertkey_bindings = {
    prod01_443_wildcard = {
      certkeyname = "InCommon_example-wildcard_2022"
      vservername = "example-prod"
    }
  }
  sslservers = {
    prod01_443 = {
      vservername = "example-prod"
    }
  }
  rewrite_bindings = {
    prod01_443_proto = {
      vservername = "example-prod"
      policyname  = "insert_X-Forwarded-Proto"
      priority    = 100
    }
  }
}

solidserver_cnames = [
    "example-rails"
]

solidserver_ip_addresses = {
  example = {
    hostname   = "example"
    request_ip = "example"
  }
}

vms = {
  vm1 = {
    name                        = "example-prod01"
    ip                          = "example"
    attributes_application_env  = "Production"
    attributes_application_type = "Web"
    attributes_applications     = "example"
    attributes_poc_email        = "example@example.edu"
    attributes_poc_name         = example"
    memory                      = "65536"
    expand = {
      partitions = {
        sda2 = {
          parition_device = "/dev/sda"
          parition_number = "2"
          parition_end    = "100%"
        }
      }
      logical_volumes = {
        varlv = {
          lv   = "varlv"
          vg   = "vg01"
          size = "256G"
        }
        rootv = {
          lv   = "rootlv"
          vg   = "vg01"
          size = "16G"
        }
      }
      volume_groups = {
        vg01 = {
          pesize = "300G"
          pvs    = "/dev/sda2"
          vg     = "vg01"
        }
      }
    }
    template_disks = {
      disk0 = {
        size        = 325
        unit_number = 0
      }
    }
  }
  vm2 = {
    name                        = "example-prod02"
    ip                          = "example"
    attributes_application_env  = "Production"
    attributes_application_type = "Web"
    attributes_applications     = "example"
    attributes_poc_email        = "example@example.edu"
    attributes_poc_name         = "example"
    memory                      = "65536"
    expand = {
      partitions = {
        sda2 = {
          parition_device = "/dev/sda"
          parition_number = "2"
          parition_end    = "100%"
        }
      }
      logical_volumes = {
        varlv = {
          lv   = "varlv"
          vg   = "vg01"
          size = "256G"
        }
        rootlv = {
          lv   = "rootlv"
          vg   = "vg01"
          size = "16G"
        }
      }
      volume_groups = {
        vg01 = {
          pesize = "300G"
          pvs    = "/dev/sda2"
          vg     = "vg01"
        }
      }
    }
    template_disks = {
      disk0 = {
        size        = 325
        unit_number = 0
      }
    }
  }
}

vsphere_project_subfolder = "Production"
