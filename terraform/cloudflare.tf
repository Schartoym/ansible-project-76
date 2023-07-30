resource "cloudflare_record" "project-a-record" {
  zone_id = var.cloudflare_zone_id
  name    = "@"
  value   = local.load_balancer_ip_address
  type    = "A"
  ttl     = 3600
}

resource "cloudflare_record" "project-a-record-www" {
  zone_id = var.cloudflare_zone_id
  name    = "www"
  value   = local.load_balancer_ip_address
  type    = "A"
  ttl     = 3600
}


resource "cloudflare_record" "project-acme-cname" {
  zone_id = var.cloudflare_zone_id
  name    = "_acme-challenge"
  value   = "${yandex_cm_certificate.project.id}.cm.yandexcloud.net"
  type    = "CNAME"
  ttl     = 3600
}

resource "cloudflare_record" "project-acme-cname-www" {
  zone_id = var.cloudflare_zone_id
  name    = "_acme-challenge.www.${var.domain_name}"
  value   = "${yandex_cm_certificate.project.id}.cm.yandexcloud.net"
  type    = "CNAME"
  ttl     = 3600
}
