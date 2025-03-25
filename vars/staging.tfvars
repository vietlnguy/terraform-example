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
  "ansible/vars/staging.yml",
  "ansible/vars/env.yml"
]

nodes = [
  "example-stg01.example.example.int",
  "example-stg02.example.example.int"
]

citrixadc = {
  servers = {
    stg01 = {
      name      = "example-stg01"
      ipaddress = "example"
    }
  }
  services = {
    stg01_80 = {
      name       = "example-stg"
      servername = "example-stg01"
    }
  }
  virtual_servers = {
    stg01_443 = {
      ipv46 = "example"
      name  = "example-stg"
    }
  }
  service_bindings = {
    stg01_443 = {
      servicename = "example-stg"
      vservername = "example-stg"
    }
  }
  sslcertkey_bindings = {
    stg01_443_wildcard = {
      certkeyname = "InCommon_example-wildcard_2022"
      vservername = "example-stg"
    }
  }
  sslservers = {
    stg01_443 = {
      vservername = "example-stg"
    }
  }
  rewrite_bindings = {
    stg01_443_proto = {
      vservername = "example-stg"
      policyname  = "insert_X-Forwarded-Proto"
      priority    = 100
    }
  }
}

solidserver_ip_addresses = {
  example = {
    hostname   = "example-staging"
    request_ip = "example"
  }
}

solidserver_cnames = [
    "mdoc-dev"
]

vms = {
  vm1 = {
    name                        = "example-stg01"
    ip                          = "example"
    attributes_application_env  = "Staging"
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
  vm2 = {
    name                        = "example-stg02"
    ip                          = "example"
    attributes_application_env  = "Staging"
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

vsphere_project_subfolder = "Staging"
