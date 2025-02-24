terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
    # dns = {
    #   source  = "hashicorp/dns"
    #   version = "3.4.2"
    # }
  }

  required_version = "~> 1.10.0"
}
