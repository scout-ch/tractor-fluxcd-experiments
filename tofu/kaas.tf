resource "infomaniak_kaas" "fluxcd_experiments" {
  public_cloud_id         = var.infomaniak_public_cloud_id
  public_cloud_project_id = var.infomaniak_public_cloud_project_id

  name               = var.cluster_name
  pack_name          = var.cluster_instance_pack_name
  kubernetes_version = var.cluster_version
  region             = var.cluster_region
}

resource "infomaniak_kaas_instance_pool" "instance_pool" {
  public_cloud_id         = infomaniak_kaas.fluxcd_experiments.public_cloud_id
  public_cloud_project_id = infomaniak_kaas.fluxcd_experiments.public_cloud_project_id
  kaas_id                 = infomaniak_kaas.fluxcd_experiments.id

  name              = var.cluster_instance_pool_name
  flavor_name       = var.cluster_instance_pool_flavor
  min_instances     = var.cluster_instance_pool_instances
  max_instances     = var.cluster_instance_pool_instances
  availability_zone = var.cluster_instance_pool_availability_zone
}
