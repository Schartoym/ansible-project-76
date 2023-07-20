# https://registry.terraform.io/providers/yandex-cloud/yandex/0.95.0/docs/resources/alb_target_group
resource "yandex_alb_target_group" "ansible-76" {
  name = "ansible-76-tagret-group"

  target {
    subnet_id  = yandex_vpc_subnet.subnet-1.id
    ip_address = yandex_compute_instance.vm-1.network_interface.0.ip_address
  }

  target {
    subnet_id  = yandex_vpc_subnet.subnet-1.id
    ip_address = yandex_compute_instance.vm-2.network_interface.0.ip_address
  }
}

# https://registry.terraform.io/providers/yandex-cloud/yandex/0.95.0/docs/resources/alb_backend_group
resource "yandex_alb_backend_group" "ansible-76" {
  name = "ansible-76-backend-group"

  http_backend {
    name             = "http-backend"
    weight           = 1
    port             = 80
    target_group_ids = ["${yandex_alb_target_group.ansible-76.id}"]
    healthcheck {
      timeout  = "5s"
      interval = "5s"
      http_healthcheck {
        path = "/"
      }
    }
  }
}

# https://registry.terraform.io/providers/yandex-cloud/yandex/0.95.0/docs/resources/alb_http_router
resource "yandex_alb_http_router" "ansible-76" {
  name = "ansible-76-router"
}


# https://registry.terraform.io/providers/yandex-cloud/yandex/0.95.0/docs/resources/alb_load_balancer
resource "yandex_alb_load_balancer" "ansible-76-lb" {
  name = "ansible-76-load-balancer"

  network_id = yandex_vpc_network.network-1.id

  allocation_policy {
    location {
      zone_id   = var.zone
      subnet_id = yandex_vpc_subnet.subnet-1.id
    }
  }

  listener {
    name = "ansible-76-listener"
    endpoint {
      address {
        external_ipv4_address {
          address = local.load_balancer_ip_address
        }
      }
      ports = [80]
    }
    http {
      redirects {
        http_to_https = true
      }
    }
  }

  listener {
    name = "ansible-76-listener-https"
    endpoint {
      address {
        external_ipv4_address {
            address = local.load_balancer_ip_address
        }
      }
      ports = [443]
    }
    tls {
      default_handler {
        http_handler {
          http_router_id = yandex_alb_http_router.ansible-76.id
        }
        certificate_ids = [yandex_cm_certificate.project.id]
      }
    }
  }

  log_options {
    discard_rule {
      http_code_intervals = ["HTTP_2XX", "HTTP_3XX"]
      discard_percent     = 75
    }
  }
}

# https://registry.terraform.io/providers/yandex-cloud/yandex/0.95.0/docs/resources/alb_virtual_host
resource "yandex_alb_virtual_host" "project-host" {
  name           = "ansible-76-host"
  http_router_id = yandex_alb_http_router.ansible-76.id
  route {
    name = "default-route"
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.ansible-76.id
        timeout          = "15s"
      }
    }
  }
}

output "load_balancer_ip_address" {
  value = yandex_alb_load_balancer.ansible-76-lb.listener.0.endpoint.0.address.0.external_ipv4_address.0.address
}
