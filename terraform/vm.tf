# https://registry.terraform.io/providers/yandex-cloud/yandex/0.95.0/docs/resources/compute_instance

data "local_file" "ssh_pub_key" {
  filename = var.ssh_public_key_file
}

locals {
  ssh_keys = "ubuntu:${data.local_file.ssh_pub_key.content}"
}

resource "yandex_compute_instance" "vm-1" {
  name        = "vm-1"
  platform_id = "standard-v1"
  zone        = var.zone
  folder_id   = var.folder_id

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = local.ssh_keys
  }
}

resource "yandex_compute_instance" "vm-2" {
  name        = "vm-2"
  platform_id = "standard-v1"
  zone        = var.zone
  folder_id   = var.folder_id
  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = local.ssh_keys
  }
}

output "external_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
}

output "external_ip_address_vm_2" {
  value = yandex_compute_instance.vm-2.network_interface.0.nat_ip_address
}
