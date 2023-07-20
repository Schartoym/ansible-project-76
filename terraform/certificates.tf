resource "yandex_cm_certificate" "project" {
  name    = "ansible-76-domain"
  domains = ["${var.domain_name}", "www.${var.domain_name}"]

  managed {
    challenge_type = "DNS_CNAME"
    challenge_count = 2
  }
}