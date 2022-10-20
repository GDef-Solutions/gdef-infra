output "lb_ip" {
  value = data.kubernetes_service.ingress_nginx_controller.status.0.load_balancer.0.ingress.0.ip
}
