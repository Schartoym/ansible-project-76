resource "local_file" "ansible_inventory" {
  content = templatefile("inventory.tmpl", {
    instances = [
        yandex_compute_instance.vm-1,
        yandex_compute_instance.vm-2
    ],
    db = {
      name: var.database_name,
      user: var.database_user,
      host: local.database_host
    }

  })
  filename = "../inventory.ini"
}
