terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {  
  token     = "y0_AgAAAAAl_ehBAATuwQAAAADUVseO7eWczeNFT1y3cxJ-yHniOx5ghnM"
  cloud_id  = "b1gu8tli85id3nl4uqas"
  folder_id = "b1gabb4kmdl6d6b2gi7t"
  zone      = "ru-central1-a"
}

resource "yandex_compute_instance" "vm-1" {
  name = "web1"
  description = "nginxserver1"
 
  resources {
    cores = 2
    memory = 6
  }

  boot_disk {
    initialize_params {
      image_id = "fd8a67rb91j689dqp60h"
      size = 16
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat = true
    security_group_ids = ["${yandex_vpc_security_group.webservers-sg.id}"]
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }
}

resource "yandex_compute_instance" "vm-2" {
  name = "web2"
  zone = "ru-central1-b"
  description = "nginxserver2" 
 
  resources {
    cores = 2
    memory = 6
  }
 
  boot_disk {
    initialize_params {
      image_id = "fd8a67rb91j689dqp60h"
      size = 16
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-2.id
    nat = true
    security_group_ids = ["${yandex_vpc_security_group.webservers-sg.id}"]
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }
}

resource "yandex_compute_instance" "vm-3" {
  name = "prometheus"
  description = "prometheus_server"

  resources {
    cores = 2
    memory = 6
  }

  boot_disk {
    initialize_params {
      image_id = "fd8a67rb91j689dqp60h"
      size = 16
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-3.id
    nat = true
    security_group_ids = ["${yandex_vpc_security_group.prometheus-sg.id}"]
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }
}

resource "yandex_compute_instance" "vm-4" {
  name = "grafana"
  description = "grafana_server"

  resources {
    cores = 2
    memory = 8
  }

  boot_disk {
    initialize_params {
      image_id = "fd8a67rb91j689dqp60h"
      size = 20
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-3.id
    nat = true
    security_group_ids = ["${yandex_vpc_security_group.grafana-sg.id}"]
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }
}

resource "yandex_compute_instance" "vm-5" {
  name = "elasticsearch"
  zone = "ru-central1-b"
  description = "elasticsearch_server"

  resources {
    cores = 2
    memory = 6
  }

  boot_disk {
    initialize_params {
      image_id = "fd8a67rb91j689dqp60h"
      size = 25
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-5.id
    nat = true
    security_group_ids = ["${yandex_vpc_security_group.elasticsearch-sg.id}"]
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }
}

resource "yandex_compute_instance" "vm-6" {
  name = "kibana"
  zone = "ru-central1-b"
  description = "kibana_server"

  resources {
    cores = 2
    memory = 8
  }

  boot_disk {
    initialize_params {
      image_id = "fd8a67rb91j689dqp60h"
      size = 16
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-6.id
    nat = true
    security_group_ids = ["${yandex_vpc_security_group.kibana-sg.id}"]
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }
}

resource "yandex_compute_instance" "vm-7" {
  name = "bastionhost"
  zone = "ru-central1-b"
  description = "bastion"

  resources {
    cores = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8a67rb91j689dqp60h"
      size = 10
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-7.id
    nat = true
    security_group_ids = ["${yandex_vpc_security_group.bastion.id}"]
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.1.0/24"]
}

resource "yandex_vpc_subnet" "subnet-2" {
  name           = "subnet2"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.2.0/24"]
}

resource "yandex_vpc_subnet" "subnet-3" {
  name           = "subnet3"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.3.0/24"]
}

resource "yandex_vpc_subnet" "subnet-4" {
  name           = "subnet4"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.4.0/24"]
}

resource "yandex_vpc_subnet" "subnet-5" {
  name           = "subnet5"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.5.0/24"]
}

resource "yandex_vpc_subnet" "subnet-6" {
  name           = "subnet6"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.6.0/24"]
}

resource "yandex_vpc_subnet" "subnet-7" {
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.7.0/24"]
}

output "internal_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.ip_address
}
output "external_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
}

output "internal_ip_address_vm_2" {
  value = yandex_compute_instance.vm-2.network_interface.0.ip_address
}
output "external_ip_address_vm_2" {
  value = yandex_compute_instance.vm-2.network_interface.0.nat_ip_address
}

output "internal_ip_address_vm_3" {
  value = yandex_compute_instance.vm-3.network_interface.0.ip_address
}
output "external_ip_address_vm_3" {
  value = yandex_compute_instance.vm-3.network_interface.0.nat_ip_address
}

output "internal_ip_address_vm_4" {
  value = yandex_compute_instance.vm-4.network_interface.0.ip_address
}
output "external_ip_address_vm_4" {
  value = yandex_compute_instance.vm-4.network_interface.0.nat_ip_address
}

output "internal_ip_address_vm_5" {
  value = yandex_compute_instance.vm-5.network_interface.0.ip_address
}
output "external_ip_address_vm_5" {
  value = yandex_compute_instance.vm-5.network_interface.0.nat_ip_address
}

output "internal_ip_address_vm_6" {
  value = yandex_compute_instance.vm-6.network_interface.0.ip_address
}
output "external_ip_address_vm_6" {
  value = yandex_compute_instance.vm-6.network_interface.0.nat_ip_address
}

output "internal_ip_address_vm_7" {
  value = yandex_compute_instance.vm-7.network_interface.0.ip_address
}
output "external_ip_address_vm_7" {
  value = yandex_compute_instance.vm-7.network_interface.0.nat_ip_address
}
resource "yandex_alb_target_group" "web-target" {
  name      = "web-target-group"

  target {
    subnet_id = "${yandex_vpc_subnet.subnet-1.id}"
    ip_address   = "${yandex_compute_instance.vm-1.network_interface.0.ip_address}"
  }

  target {
    subnet_id = "${yandex_vpc_subnet.subnet-2.id}"
    ip_address   = "${yandex_compute_instance.vm-2.network_interface.0.ip_address}"
  }
}

resource "yandex_alb_backend_group" "web-backend" {
  name      = "web-backend-group"

  http_backend {
    name = "http-backend"
    weight = 1
    port = 80
    target_group_ids = ["${yandex_alb_target_group.web-target.id}"]
    load_balancing_config {
      panic_threshold = 90
    }    
    healthcheck {
      timeout              = "10s"
      interval             = "2s"
      healthy_threshold    = 10
      unhealthy_threshold  = 15
      http_healthcheck {
        path  = "/"
      }
    }
  }
}

resource "yandex_alb_http_router" "web-router" {
  name      = "webrouter"
    labels = {
    tf-label    = "tf-web-http-router"
    empty-label = ""
  }
}

resource "yandex_alb_virtual_host" "virtual-host" {
  name           = "vhrouter"
  http_router_id = yandex_alb_http_router.web-router.id
  route {
    name = "route1"
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.web-backend.id
        timeout          = "10s"
      }
    }
  }
}

resource "yandex_alb_load_balancer" "web-load-balancer" {
  name        = "load-balancer"
  network_id  = yandex_vpc_network.network-1.id
  security_group_ids = ["${yandex_vpc_security_group.loadbalancer.id}"]

  allocation_policy {
    location {
      zone_id   = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.subnet-1.id
     }
    location {
      zone_id   = "ru-central1-b"
      subnet_id = yandex_vpc_subnet.subnet-2.id
     }
  }

  listener {
    name = "my-listener"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [ 80 ]
    }    
    http {
      handler {
        http_router_id = yandex_alb_http_router.web-router.id
      }
    }
  }
}

output "external_ip_address_balancer" {
  value = yandex_alb_load_balancer.web-load-balancer.listener.*.endpoint.0.address.0.external_ipv4_address
}

resource "yandex_vpc_security_group" "webservers-sg" {
  name        = "webserverssg"
  description = "Webservers security group"
  network_id  = yandex_vpc_network.network-1.id

  ingress {
    protocol       = "TCP"
    description    = "Rule1 for healthchecks"
    v4_cidr_blocks = ["198.18.235.0/24"]
    from_port      = 1
    to_port        = 32767
  }

  ingress {
    protocol       = "TCP"
    description    = "Rule2 for healthchecks"
    v4_cidr_blocks = ["198.18.248.0/24"]
    from_port      = 1
    to_port        = 32767
  }

  ingress {
    protocol       = "TCP"
    description    = "Rule for load balancer"
    security_group_id = yandex_vpc_security_group.loadbalancer.id
    port           = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "Rule for bastion ssh"
    security_group_id = yandex_vpc_security_group.bastion.id
    port           = 22
  }

  ingress {
    protocol       = "TCP"
    description    = "Rule1 for metrics"
    security_group_id = yandex_vpc_security_group.prometheus-sg.id
    port           = 9100
  }

  ingress {
    protocol       = "TCP"
    description    = "Rule2 for metrics"
    security_group_id = yandex_vpc_security_group.prometheus-sg.id
    port           = 4040
  }

  egress {
    protocol       = "ANY"
    description    = "Rule out"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "prometheus-sg" {
  name        = "prometheussg"
  description = "Prometheus security group"
  network_id  = yandex_vpc_network.network-1.id

  ingress {
    protocol       = "TCP"
    description    = "Rule for grafana"
    security_group_id = yandex_vpc_security_group.grafana-sg.id
    port           = 9090
  }

  ingress {
    protocol       = "TCP"
    description    = "Rule for bastion ssh"
    security_group_id = yandex_vpc_security_group.bastion.id
    port           = 22
  }

  egress {
    protocol       = "ANY"
    description    = "Rule out"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "elasticsearch-sg" {
  name        = "elasticsearchsg"
  description = "Elasticsearch security group"
  network_id  = yandex_vpc_network.network-1.id

  ingress {
    protocol       = "TCP"
    description    = "Rule for kibana"
    security_group_id = yandex_vpc_security_group.kibana-sg.id
    port           = 9200
  }

  ingress {
    protocol       = "TCP"
    description    = "Rule for webservers"
    security_group_id = yandex_vpc_security_group.webservers-sg.id
    port           = 9200
  }

  ingress {
    protocol       = "TCP"
    description    = "Rule for bastion ssh"
    security_group_id = yandex_vpc_security_group.bastion.id
    port           = 22
  }

  egress {
    protocol       = "ANY"
    description    = "Rule out"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "grafana-sg" {
  name        = "grafanasg"
  description = "Grafana security group"
  network_id  = yandex_vpc_network.network-1.id

  ingress {
    protocol       = "TCP"
    description    = "Rule for all"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 3000
  }

  ingress {
    protocol       = "TCP"
    description    = "Rule for bastion ssh"
    security_group_id = yandex_vpc_security_group.bastion.id
    port           = 22
  }

  egress {
    protocol       = "ANY"
    description    = "Rule out"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "kibana-sg" {
  name        = "kibanasg"
  description = "Kibana security group"
  network_id  = yandex_vpc_network.network-1.id

  ingress {
    protocol       = "TCP"
    description    = "Rule for all"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 5601
  }

  ingress {
    protocol       = "TCP"
    description    = "Rule for bastion ssh"
    security_group_id = yandex_vpc_security_group.bastion.id
    port           = 22
  }

  egress {
    protocol       = "ANY"
    description    = "Rule out"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "loadbalancer" {
  name        = "loadbalancer1sg"
  description = "Load balancer security group"
  network_id  = yandex_vpc_network.network-1.id

  ingress {
    protocol       = "TCP"
    description    = "Rule for income"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }
  
  ingress {
    protocol       = "TCP"
    description    = "Rule1 for healthchecks"
    v4_cidr_blocks = ["198.18.235.0/24"]
    from_port      = 1
    to_port        = 32767
  }

  ingress {
    protocol       = "TCP"
    description    = "Rule2 for healthchecks"
    v4_cidr_blocks = ["198.18.248.0/24"]
    from_port      = 1
    to_port        = 32767
  }  

  egress {
    protocol       = "ANY"
    description    = "Rule out"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "bastion" {
  name        = "Bastionsg"
  description = "Bastion security group"
  network_id  = yandex_vpc_network.network-1.id

  ingress {
    protocol       = "TCP"
    description    = "Rule for income"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  egress {
    protocol       = "ANY"
    description    = "Rule out"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}
