# https://registry.terraform.io/providers/yandex-cloud/yandex/0.95.0/docs/resources/vpc_network

resource "yandex_vpc_network" "network-1" {
    name = "ansible-76-network"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "ansible-76-subnet"
  zone           =  var.zone
  network_id     = "${yandex_vpc_network.network-1.id}"
  v4_cidr_blocks = ["10.76.0.0/16"]
}

#https://registry.terraform.io/providers/yandex-cloud/yandex/0.95.0/docs/resources/vpc_address
resource "yandex_vpc_address" "ansible-76-lb-address" {
  name = "ansible-76-lb-address"

  external_ipv4_address {
    zone_id = var.zone
  }
}

locals {
  load_balancer_ip_address = yandex_vpc_address.ansible-76-lb-address.external_ipv4_address.0.address
}