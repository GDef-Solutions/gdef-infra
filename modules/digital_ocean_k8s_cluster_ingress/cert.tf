provider "acme" {
  server_url = "https://acme-v02.api.letsencrypt.org/directory"
}

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

resource "acme_registration" "reg" {
  account_key_pem = tls_private_key.private_key.private_key_pem
  email_address   = var.acme_registration_email_address
}

resource "acme_certificate" "root_certificate" {
  account_key_pem = acme_registration.reg.account_key_pem
  common_name     = var.root_hostname

  dns_challenge {
    provider = "digitalocean"
    config   = {
      DO_AUTH_TOKEN  = var.do_token
    }
  }
}

resource "acme_certificate" "wildcard_certificate" {
  account_key_pem = acme_registration.reg.account_key_pem
  common_name     = local.wildcard_hostname

  dns_challenge {
    provider = "digitalocean"
    config   = {
      DO_AUTH_TOKEN  = var.do_token
    }
  }
  depends_on = [acme_certificate.root_certificate]  # they cannot be created in parallel
}
