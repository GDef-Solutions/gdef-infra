terraform {
  cloud {
    organization = "gdeforest"

    workspaces {
      name = "gdef-infra"
    }
  }

  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}