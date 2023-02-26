# Дипломное задание по профессии Системный администратор - Ковбаса Анна


Задание расположено [ссылке](https://github.com/netology-code/sys-diplom/blob/main/README.md)

### Этапы выполнения

1. Создана инфраструктура в Яндекс Облаке с помощью Terraform, код представлен в файле main.tf

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
