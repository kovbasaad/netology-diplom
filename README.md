# Дипломное задание по профессии Системный администратор - Ковбаса Анна


Задание расположено [ссылке](https://github.com/netology-code/sys-diplom/blob/main/README.md)

### Этапы выполнения

1. Создана инфраструктура в Яндекс Облаке с помощью Terraform, код представлен в файле main.tf


Outputs:

external_ip_address_balancer = tolist([
  tolist([
    {
      "address" = "130.193.49.152"
    },
  ]),
])
external_ip_address_vm_1 = "84.201.130.207"
external_ip_address_vm_2 = "158.160.4.45"
external_ip_address_vm_3 = "51.250.12.161"
external_ip_address_vm_4 = "51.250.7.128"
external_ip_address_vm_5 = "84.201.162.58"
external_ip_address_vm_6 = "158.160.22.73"
external_ip_address_vm_7 = "130.193.52.254"
internal_ip_address_vm_1 = "192.168.1.15"
internal_ip_address_vm_2 = "192.168.2.27"
internal_ip_address_vm_3 = "192.168.3.15"
internal_ip_address_vm_4 = "192.168.3.18"
internal_ip_address_vm_5 = "192.168.5.31"
internal_ip_address_vm_6 = "192.168.6.4"
internal_ip_address_vm_7 = "192.168.7.18"



http://158.160.22.73:5601/app/discover

http://51.250.7.128:3000/d/4aBQsjSmz/nginx-servers-metrics (admin/sys-12)




- Какие сетевые службы в ней разрешены?<br>
![1-1](https://github.com/kovbasaad/13-1-homework/blob/main/img/1-1.JPG)

- Какие уязвимости были вами обнаружены? (список со ссылками: достаточно трёх уязвимостей)<br>
[Multiple Vendor Telnet Client - Env_opt_add Heap Buffer Overflow](https://www.exploit-db.com/exploits/25303)<br>
[Pachev FTP Server 1.0 - Path Traversal](https://www.exploit-db.com/exploits/47956)<br>
[OpenSMTPD - MAIL FROM Remote Code Execution (Metasploit)](https://www.exploit-db.com/exploits/48038)
  

### Задание 2

Проведите сканирование Metasploitable в режимах SYN, FIN, Xmas, UDP.

Запишите сеансы сканирования в Wireshark.

Ответьте на следующие вопросы:

- Чем отличаются эти режимы сканирования с точки зрения сетевого трафика?

Используемыми сетевыми протоколами, и флагами пакетов в случае TCP протокола: <br>
SYN - TCP [SYN]<br>
FIN - TCP [FIN]<br>
Xmas - TCP [FIN, PSH, URG]<br>

- Как отвечает сервер?

При UDP сканировании - ICMP пакетыми с кодом ошибок (порт закрыт) или UDP пакетом (порт открыт). Нет ответа - вероятно, порт открыт<br>
SYN сканирование - TCP [SYN, ACK] (порт открыт) [RST, ACK], [RST] (порт закрыт) пакеты<br>
FIN сканирование - TCP [RST, ACK] пакеты (порт закрыт)<br>
Xmas сканирование - TCP [RST, ACK] пакеты (порт закрыт)<br>
