# https://registry.terraform.io/providers/yandex-cloud/yandex/0.95.0/docs/resources/lb_target_group
resource "yandex_lb_target_group" "ansible-76" {
  name      = "ansible-76-tagret-group"
  region_id = "ru-central1"

  target {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    address   = yandex_compute_instance.vm-1.network_interface.0.ip_address
  }

  target {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    address   = yandex_compute_instance.vm-2.network_interface.0.ip_address
  }
}

# https://registry.terraform.io/providers/yandex-cloud/yandex/0.95.0/docs/resources/lb_network_load_balancer
resource "yandex_lb_network_load_balancer" "ansible-76-lb" {
  name = "ansible-76-load-balancer"

  listener {
    name = "ansible-76-listener"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.ansible-76.id

    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}

output "load_balancer_ip_address" {
  value = flatten(
    [for l in yandex_lb_network_load_balancer.ansible-76-lb.listener : [
      for a in l.external_address_spec : "${a.address}"
  ]])[0]
}
