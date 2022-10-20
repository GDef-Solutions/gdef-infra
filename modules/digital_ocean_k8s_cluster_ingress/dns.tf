resource "digitalocean_domain" "default" {
  name = var.root_hostname
  ip_address = data.kubernetes_service.ingress_nginx_controller.status.0.load_balancer.0.ingress.0.ip
}

resource "digitalocean_record" "mx" {
  domain   = digitalocean_domain.default.id
  type     = "MX"
  name     = "@"
  priority = 10
  value    = "mail.${var.root_hostname}."
}

resource "digitalocean_record" "wildcard" {
  domain = digitalocean_domain.default.id
  type   = "A"
  name   = "*"
  value  = data.kubernetes_service.ingress_nginx_controller.status.0.load_balancer.0.ingress.0.ip
}
