resource "local_file" "ansible_inventory" {
  content = templatefile("templates/inventory.tmpl", {
    instances = [
        yandex_compute_instance.vm-1,
        yandex_compute_instance.vm-2
    ],
    db = {
      name: var.database_name,
      user: var.database_user,
      host: local.database_host
    }
    domain_name: var.domain_name
  })
  filename = "../inventory.ini"
}

resource "local_file" "ansible_all_vars" {
  content = templatefile("templates/all-vars.tmpl", {
    db = {
      name: var.database_name,
      user: var.database_user,
      host: local.database_host
    }
    domain_name: var.domain_name
  })
  filename = "../group_vars/all/all.generated.yml"
}

resource "local_file" "ansible_db_vars" {
  content = templatefile("templates/db-vars.tmpl", {
    db = {
      name: var.database_name,
      user: var.database_user,
      host: local.database_host
    }
  })
  filename = "../group_vars/webservers/db.generated.yml"
}
