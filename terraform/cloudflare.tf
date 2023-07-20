resource "cloudflare_account" "project" {
  name = "Schartoym@gmail.com's Account"
}

resource "cloudflare_zone" "project-zone" {
  account_id = cloudflare_account.project.id
  zone       = var.domain_name
}

resource "cloudflare_record" "project-a-record" {
  zone_id = cloudflare_zone.project-zone.id
  name    = "@"
  value   = local.load_balancer_ip_address
  type    = "A"
  ttl     = 3600
}

resource "cloudflare_record" "project-a-record-www" {
  zone_id = cloudflare_zone.project-zone.id
  name    = "www"
  value   = local.load_balancer_ip_address
  type    = "A"
  ttl     = 3600
}


resource "cloudflare_record" "project-acme-cname" {
  zone_id = cloudflare_zone.project-zone.id
  name    = "_acme-challenge"
  value   = "${yandex_cm_certificate.project.id}.cm.yandexcloud.net"
  type    = "CNAME"
  ttl     = 3600
}

resource "cloudflare_record" "project-acme-cname-www" {
  zone_id = cloudflare_zone.project-zone.id
  name    = "_acme-challenge.www.${var.domain_name}"
  value   = "${yandex_cm_certificate.project.id}.cm.yandexcloud.net"
  type    = "CNAME"
  ttl     = 3600
}
