# https://registry.terraform.io/providers/vancluever/acme/latest/docs
resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

resource "acme_registration" "reg" {
  account_key_pem = tls_private_key.private_key.private_key_pem
  email_address   = "robot@bulka.dev"
}

resource "acme_certificate" "certificate" {
  account_key_pem           = acme_registration.reg.account_key_pem
  common_name               = "bulka.dev"
  subject_alternative_names = ["www.bulka.dev"]

  dns_challenge {
    provider = "cloudflare"

    config = {
      CF_DNS_API_TOKEN = var.cloudflare_api_token
    }
  }
}
