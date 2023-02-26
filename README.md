# Дипломное задание по профессии Системный администратор - Ковбаса Анна


Задание расположено [ссылке](https://github.com/netology-code/sys-diplom/blob/main/README.md)

### Этапы выполнения

1. Создана инфраструктура в Яндекс Облаке с помощью Terraform, включая группы безопасности, код представлен в файле [main.tf](https://github.com/kovbasaad/netology-diplom/blob/main/main.tf)<br>
![1-1](https://github.com/kovbasaad/netology-diplom/blob/main/img/vm.JPG)<br>
![1-2](https://github.com/kovbasaad/netology-diplom/blob/main/img/sg.JPG)<br>

Outputs:<br>

external_ip_address_balancer = tolist([<br>
  tolist([<br>
    {
      "address" = "130.193.49.152" #load balancer<br>
    },<br>
  ]),<br>
])<br>
external_ip_address_vm_1 = "84.201.130.207" #webserver1<br>
external_ip_address_vm_2 = "158.160.4.45" #webserver2<br>
external_ip_address_vm_3 = "51.250.12.161" #prometheus<br>
external_ip_address_vm_4 = "51.250.7.128" #grafana<br>
external_ip_address_vm_5 = "84.201.162.58" #elasticsearch<br>
external_ip_address_vm_6 = "158.160.22.73" #kibana<br>
external_ip_address_vm_7 = "130.193.52.254" #bastionhost<br>
internal_ip_address_vm_1 = "192.168.1.15" #webserver1<br>
internal_ip_address_vm_2 = "192.168.2.27" #webserver2<br>
internal_ip_address_vm_3 = "192.168.3.15" #prometheus<br>
internal_ip_address_vm_4 = "192.168.3.18" #grafana<br>
internal_ip_address_vm_5 = "192.168.5.31" #elasticsearch<br>
internal_ip_address_vm_6 = "192.168.6.4" #kibana<br>
internal_ip_address_vm_7 = "192.168.7.18" #bastionhost<br>

2. С помощью ansible ([bastion.yml](https://github.com/kovbasaad/netology-diplom/blob/main/ansible/bastion.yml)) выполнена установка ansible и копирование файлов (представленны в папке [ansible](https://github.com/kovbasaad/netology-diplom/tree/main/ansible)) на bastionhost для дальнейшей настройки всех виртуальных машин.
3. С помощью ansible на bastionhost, установлены и настроены необходимые сервисы на виртуальных машинах

Адрес сайта (балансировщик) http://130.193.49.152/ ([servers-playbook.yml](https://github.com/kovbasaad/netology-diplom/blob/main/ansible/servers-playbook.yml))<br>
![3-1](https://github.com/kovbasaad/netology-diplom/blob/main/img/curl%20balancer.JPG)<br>

Kibana: http://158.160.22.73:5601/app/discover ([kibana-playbook.yml](https://github.com/kovbasaad/netology-diplom/blob/main/ansible/kibana-playbook.yml))<br>

Grafana: http://51.250.7.128:3000/d/4aBQsjSmz/nginx-servers-metrics (Логин: admin Пароль: sys-12 ) ([grafana-playbook.yml](https://github.com/kovbasaad/netology-diplom/blob/main/ansible/grafana-playbook.yml))<br>

[prometheus-playbook.yml](https://github.com/kovbasaad/netology-diplom/blob/main/ansible/prometheus-playbook.yml)<br>
![3-2](https://github.com/kovbasaad/netology-diplom/blob/main/img/prometheus.JPG)<br>

[elasticsearch-playbook.yml](https://github.com/kovbasaad/netology-diplom/blob/main/ansible/elasticsearch-playbook.yml)<br>
![3-3](https://github.com/kovbasaad/netology-diplom/blob/main/img/elasticsearch.JPG)<br>
![3-4](https://github.com/kovbasaad/netology-diplom/blob/main/img/kibana_get_es.JPG)<br>

4. Созданы снимки всех дисков виртуальных машин, и расписание создания новых, код в файле [snapshot.tf](https://github.com/kovbasaad/netology-diplom/blob/main/snapshot.tf)<br>
![4-1](https://github.com/kovbasaad/netology-diplom/blob/main/img/snapshots.JPG)<br>
![4-2](https://github.com/kovbasaad/netology-diplom/blob/main/img/sdsnapshots.JPG)<br>

