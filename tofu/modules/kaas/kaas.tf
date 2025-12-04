resource "infomaniak_kaas" "fluxcd_experiments" {
  public_cloud_id         = var.infomaniak_public_cloud.id
  public_cloud_project_id = var.infomaniak_public_cloud.project_id

  name               = var.cluster.name
  pack_name          = var.cluster.pack_name
  kubernetes_version = var.cluster.version
  region             = var.cluster.region
}

resource "infomaniak_kaas_instance_pool" "instance_pool" {
  for_each = var.cluster_instance_pools

  public_cloud_id         = infomaniak_kaas.fluxcd_experiments.public_cloud_id
  public_cloud_project_id = infomaniak_kaas.fluxcd_experiments.public_cloud_project_id
  kaas_id                 = infomaniak_kaas.fluxcd_experiments.id

  name              = each.key
  flavor_name       = each.value.flavor_name
  min_instances     = each.value.instances
  max_instances     = each.value.instances
  availability_zone = each.value.availability_zone
}
