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

2. С помощью ansible ([bastion.yml](https://github.com/kovbasaad/netology-diplom/blob/main/ansible/bastion.yml)) выполнена установка ansible и копирование файлов (представлены в папке [ansible](https://github.com/kovbasaad/netology-diplom/tree/main/ansible)) на bastionhost для дальнейшей настройки всех виртуальных машин.
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

