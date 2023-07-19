locals {
  load_balancer_ip_address = flatten(
    [for l in yandex_lb_network_load_balancer.ansible-76-lb.listener : [
      for a in l.external_address_spec : "${a.address}"
  ]])[0]
}

resource "cloudflare_account" "schartoym" {
  name = "Schartoym@gmail.com's Account"
}

resource "cloudflare_zone" "bulka_dev" {
  account_id = cloudflare_account.schartoym.id
  zone       = "bulka.dev"
}

resource "cloudflare_record" "bulka_dev_a" {
  zone_id = cloudflare_zone.bulka_dev.id
  name    = "@"
  value   = local.load_balancer_ip_address
  type    = "A"
  ttl     = 3600
}

resource "cloudflare_record" "bulka_dev_www" {
  zone_id = cloudflare_zone.bulka_dev.id
  name    = "www"
  value   = local.load_balancer_ip_address
  type    = "A"
  ttl     = 3600
}
