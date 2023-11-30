terraform {
  required_providers {
    virtualbox = {
      source = "shekeriev/virtualbox"
      version = "0.0.4"
    }
  }
}

provider "virtualbox" {
  delay      = 60
  mintimeout = 5
}

resource "virtualbox_vm" "vm1" {
  name   = "debian76"
  image  = "https://github.com/kraksoft/vagrant-box-debian/releases/download/7.6.0/debian-7.6.0-amd64.box"
  cpus      = 1
  memory    = "512 mib"
#  user_data = file("${path.module}/user_data")

  network_adapter {
    type           = "hostonly"
    device         = "IntelPro1000MTDesktop"
   # host_interface = "vboxnet1"
    # On Windows use this instead
    host_interface = "VirtualBox Host-Only Ethernet Adapter"
  }
}

output "IPAddress" {
  value = element(virtualbox_vm.vm1.*.network_adapter.0.ipv4_address, 1)
}