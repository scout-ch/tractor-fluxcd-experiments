output "kubeconfig_clever" {
  value     = module.u_clever.kubeconfig
  sensitive = true
}

output "kubeconfig_clever_kaas_emergency" {
  value     = module.u_clever_kaas_emergency.kubeconfig
  sensitive = true
}
