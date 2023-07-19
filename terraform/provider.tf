terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
    acme = {
      source  = "vancluever/acme"
    }
  }

  backend "s3" {
    endpoint                    = "storage.yandexcloud.net"
    bucket                      = "terraform-state-schartoym"
    region                      = "ru-central1"
    key                         = "ansible-76.tfstate"
    dynamodb_endpoint           = "https://docapi.serverless.yandexcloud.net/ru-central1/b1g5nml78tkiddl7pfjm/etna2s93llusnuhfqa5i"
    dynamodb_table              = "tf-state-lock-ansible-76"
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  token     = var.cloud_token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

provider "acme" {
  server_url = "https://acme-v02.api.letsencrypt.org/directory"
}