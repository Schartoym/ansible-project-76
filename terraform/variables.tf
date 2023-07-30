variable "cloud_token" {
  type = string
  description = "Yandex Cloud token"
  sensitive = true
}

variable "cloud_id" {
  type = string
  description = "Yandex Cloud Id"
}

variable "folder_id" {
  type = string
  description = "Yandex Cloud Folder Id"
}

variable "service_account_id" {
  type = string
  description = "Yandex Service Account Id"
}

variable "zone" {
  type = string
  default = "ru-central1-a"
  description = "Yandex Cloud Zone"
}

variable "ssh_public_key_file" {
  type = string
  default = "../id_rsa.pub"
  description = "Full path to public key"
}

variable "image_id" {
   type = string
   description = "VM image id"
}

variable "database_name" {
  type = string
  description = "DB Name"
}

variable "database_user" {
  type = string
  sensitive = true
  description = "DB User"
}

variable "database_password" {
  type = string
  sensitive = true
  description = "DB Password"
}

variable "cloudflare_api_token" {
  type = string
  sensitive = true
  description =  "Cloudflare API token"
}

variable "domain_name" {
  type = string
  description = "Domain name"
}


variable "cloudflare_zone_id" {
  type = string
  sensitive = true
  description =  "Cloudflare Zone Id"
}