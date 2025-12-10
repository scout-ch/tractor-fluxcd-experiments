output "kubeconfig_clever" {
  value     = module.u_clever.kubeconfig
  sensitive = true
}
