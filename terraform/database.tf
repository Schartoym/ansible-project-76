# https://registry.terraform.io/providers/yandex-cloud/yandex/0.95.0/docs/resources/mdb_postgresql_cluster

resource "yandex_mdb_postgresql_cluster" "ansible-76-cluster" {
  name        = "ansible-76-databse"
  environment = "PRODUCTION"
  network_id  = yandex_vpc_network.network-1.id

  config {
    version = 14
    resources {
      resource_preset_id = "b1.medium"
      disk_type_id       = "network-hdd"
      disk_size          = 16
    }
    postgresql_config = {
      max_connections                = 100
      enable_parallel_hash           = true
      autovacuum_vacuum_scale_factor = 0.34
      default_transaction_isolation  = "TRANSACTION_ISOLATION_READ_COMMITTED"
      shared_preload_libraries       = "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN,SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN"
    }
  }

  maintenance_window {
    type = "WEEKLY"
    day  = "SAT"
    hour = 12
  }

  host {
    zone      = var.zone
    subnet_id = yandex_vpc_subnet.subnet-1.id
  }
}

resource "yandex_mdb_postgresql_user" "db-user" {
  cluster_id = yandex_mdb_postgresql_cluster.ansible-76-cluster.id
  name       = var.database_user
  password   = var.database_password
  conn_limit = 50
}