resource "local_file" "ansible_inventory" {
  content = templatefile("inventory.tmpl", {
    instances = [
        yandex_compute_instance.vm-1,
        yandex_compute_instance.vm-2 
    ]
  })
  filename = "../inventory.ini"
}
