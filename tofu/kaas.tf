resource "infomaniak_kaas" "fluxcd_experiments" {
  public_cloud_id         = "2976"
  public_cloud_project_id = "36930"

  name               = "tractor-fluxcd-tests"
  pack_name          = "shared"
  kubernetes_version = "1.34"
  region             = "dc4-a"
}

resource "infomaniak_kaas_instance_pool" "instance_pool" {
  public_cloud_id         = infomaniak_kaas.fluxcd_experiments.public_cloud_id
  public_cloud_project_id = infomaniak_kaas.fluxcd_experiments.public_cloud_project_id
  kaas_id                 = infomaniak_kaas.fluxcd_experiments.id

  name              = "instance-pool-1"
  flavor_name       = "a1-ram2-disk20-perf1"
  min_instances     = 1
  max_instances     = 1
  availability_zone = "az-1"
}
