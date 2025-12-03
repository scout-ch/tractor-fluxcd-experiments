resource "github_repository_file" "this" {
  repository = var.cluster_config_repository
  file       = "infrastructure/traefik.yaml"
  content    = file("${path.module}/resources/traefik.yaml")
}
