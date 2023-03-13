# Дипломное задание по профессии Системный администратор - Ковбаса Анна


Задание расположено [ссылке](https://github.com/netology-code/sys-diplom/blob/main/README.md)

### Этапы выполнения

1. Создана инфраструктура в Яндекс Облаке с помощью Terraform, включая группы безопасности и расписание создания снимков дисков ВМ, код представлен в папке [terraform](https://github.com/kovbasaad/netology-diplom/tree/main/terraform). Токен передан через командную строку аргументом --var <br>
![1-1](https://github.com/kovbasaad/netology-diplom/blob/main/img/vm.JPG)<br>
![1-2](https://github.com/kovbasaad/netology-diplom/blob/main/img/sg.JPG)<br>
![1-3](https://github.com/kovbasaad/netology-diplom/blob/main/img/sdsnapshots.JPG)<br>

Outputs:<br>

external_ip_address_balancer = tolist([<br>
  tolist([<br>
    {
      "address" = "158.160.5.131" #load balancer<br>
    },<br>
  ]),<br>
])<br>
external_ip_address_vm_4 = "158.160.20.34" #grafana<br>
external_ip_address_vm_6 = "158.160.30.60" #kibana<br>
external_ip_address_vm_7 = "158.160.6.156" #bastionhost<br>
internal_ip_address_vm_3 = "192.168.1.18" #prometheus<br>
internal_ip_address_vm_4 = "192.168.3.28" #grafana<br>
internal_ip_address_vm_5 = "192.168.2.16" #elasticsearch<br>
internal_ip_address_vm_6 = "192.168.3.35" #kibana<br>
internal_ip_address_vm_7 = "192.168.3.22" #bastionhost<br>
internal_ip_address_web_1 = "192.168.1.8" #webserver1<br>
internal_ip_address_web_2 = "192.168.2.12" #webserver2<br>

Сгенерирован [inventory-файл](https://github.com/kovbasaad/netology-diplom/blob/main/ansible/inventory/hosts.ini) ansible ([inventory.tf](https://github.com/kovbasaad/netology-diplom/blob/main/terraform/inventory.tf) и [hosts.tftpl](https://github.com/kovbasaad/netology-diplom/blob/main/terraform/hosts.tftpl))

2. С помощью ansible установлены и настроены необходимые сервисы на виртуальных машинах (playbook'и представлены в папке [ansible](https://github.com/kovbasaad/netology-diplom/tree/main/ansible))

Адрес сайта (балансировщик) http://158.160.5.131/ ([servers-playbook.yml](https://github.com/kovbasaad/netology-diplom/blob/main/ansible/servers-playbook.yml))<br>
![3](https://github.com/kovbasaad/netology-diplom/blob/main/img/web.JPG)<br>
![3-1](https://github.com/kovbasaad/netology-diplom/blob/main/img/curl%20balancer.JPG)<br>

[elasticsearch-playbook.yml](https://github.com/kovbasaad/netology-diplom/blob/main/ansible/elasticsearch-playbook.yml)<br>
![3-2](https://github.com/kovbasaad/netology-diplom/blob/main/img/elasticsearch.JPG)<br>
![3-3](https://github.com/kovbasaad/netology-diplom/blob/main/img/kibana_get_es.JPG)<br>

Kibana: http://158.160.30.60:5601/app/discover ([kibana-playbook.yml](https://github.com/kovbasaad/netology-diplom/blob/main/ansible/kibana-playbook.yml))<br>
![3-4](https://github.com/kovbasaad/netology-diplom/blob/main/img/kibanahosta.JPG)<br>
![3-5](https://github.com/kovbasaad/netology-diplom/blob/main/img/kibanahostb.JPG)<br>
![3-6](https://github.com/kovbasaad/netology-diplom/blob/main/img/kibanalogpath.JPG)<br>

[prometheus-playbook.yml](https://github.com/kovbasaad/netology-diplom/blob/main/ansible/prometheus-playbook.yml)<br>
![3-7](https://github.com/kovbasaad/netology-diplom/blob/main/img/prometheus.JPG)<br>

Grafana: http://158.160.20.34:3000/d/4aBQsjSmz34/nginx-servers-metrics111 (Логин: admin Пароль: sys-12 ) ([grafana-playbook.yml](https://github.com/kovbasaad/netology-diplom/blob/main/ansible/grafana-playbook.yml)), пароль при запуске playbook'a передан через --extra-vars<br>
![3-8](https://github.com/kovbasaad/netology-diplom/blob/main/img/grafana.JPG)<br>


