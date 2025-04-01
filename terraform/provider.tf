terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.6.0"
    }
    statuscake = {
      source  = "statuscakedev/statuscake"
      version = "2.2.2"
    }
    # dns = {
    #   source  = "hashicorp/dns"
    #   version = "3.4.2"
    # }
  }

  required_version = ">= 1.11, < 2.0"

}

provider "github" {}

provider "statuscake" {}

# provider "dns" {
#   update {
#     server        = "hover.com"
#     key_name      = "kallelilja-com."
#     key_algorithm = "hmac-md5"
#     key_secret    = var.dns_key_secret
#   }
# }
