resource "local_file" "hosts_ini" {
  content = templatefile("${path.module}/hosts.tftpl",
    {
      webservers    = [for p in yandex_compute_instance.webserver: p.network_interface.0.ip_address]
      prometheus    = yandex_compute_instance.vm-3.network_interface.*.ip_address
      grafana       = yandex_compute_instance.vm-4.network_interface.*.ip_address
      elasticsearch = yandex_compute_instance.vm-5.network_interface.*.ip_address
      kibana        = yandex_compute_instance.vm-6.network_interface.*.ip_address
      bastion       = yandex_compute_instance.vm-7.network_interface.0.nat_ip_address
    }
  )
  filename = "../ansible/inventory/hosts.ini"
} 

