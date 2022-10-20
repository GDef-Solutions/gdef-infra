resource "kubernetes_namespace" "ingress_nginx" {
  metadata {
    name = local.namespace
  }
}

resource "kubernetes_namespace" "site" {
  metadata {
    name = local.site_namespace
  }
}

resource "kubernetes_secret" "wildcard_tls" {
  type = "kubernetes.io/tls"
  metadata {
    namespace = kubernetes_namespace.ingress_nginx.metadata.0.name
    name = "wildcard-tls"
  }
  data = {
    "tls.crt" = "${acme_certificate.wildcard_certificate.certificate_pem}${acme_certificate.wildcard_certificate.issuer_pem}"
    "tls.key" = acme_certificate.wildcard_certificate.private_key_pem
  }
}

resource "kubernetes_secret" "root_tls" {
  type = "kubernetes.io/tls"
  metadata {
    namespace = kubernetes_namespace.site.metadata.0.name
    name = "root-site-tls"
  }
  data = {
    "tls.crt" = "${acme_certificate.root_certificate.certificate_pem}${acme_certificate.root_certificate.issuer_pem}"
    "tls.key" = acme_certificate.root_certificate.private_key_pem
  }
}

resource "helm_release" "ingress_nginx" {
  name       = local.namespace
  namespace = kubernetes_namespace.ingress_nginx.metadata.0.name

  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = var.ingress_nginx_version

  dynamic "set" {
    for_each = local.helm_settings
    content {
      name = set.value["name"]
      value = set.value["value"]
    }
  }
}

data "kubernetes_service" "ingress_nginx_controller" {
  metadata {
    namespace = kubernetes_namespace.ingress_nginx.metadata.0.name
    name      = local.service_name
  }
  depends_on = [helm_release.ingress_nginx]
}
