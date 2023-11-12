# Домашнее задание к занятию 4. «Оркестрация группой Docker-контейнеров на примере Docker Compose»

##Задача 1
Cоздайте собственный образ любой операционной системы (например, debian-11) с помощью Packer версии 1.7.0 . Перед выполнением задания изучите (инструкцию!!!). В инструкции указана минимальная версия 1.5, но нужно использовать 1.7, так как там есть нужный нам функционал
Чтобы получить зачёт, вам нужно предоставить скриншот страницы с созданным образом из личного кабинета YandexCloud.

Авторизуемся, создаем сеть, подсеть .
```console
root@server1:~# yc init
Welcome! This command will take you through the configuration process.
Please go to https://oauth.yandex.ru/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb in order to obtain OAuth token.

Please enter OAuth token: y0_AgAAAAAIIsBGAATuwQAAAADxx0FFaMG86onpTYyRxd9128bowkuuqeY
You have one cloud available: 'cloud-ivancad33' (id = b1g8h2rh376qfol4bodf). It is going to be used by default.
Please choose folder to use:
 [1] default (id = b1gs07e2bjqttco10jqf)
 [2] Create a new folder
Please enter your numeric choice: 1
Your current folder has been set to 'default' (id = b1gs07e2bjqttco10jqf).
Do you want to configure a default Compute zone? [Y/n] y
Which zone do you want to use as a profile default?
 [1] ru-central1-a
 [2] ru-central1-b
 [3] ru-central1-c
 [4] ru-central1-d
 [5] Don't set default zone
Please enter your numeric choice: 1
Your profile default Compute zone has been set to 'ru-central1-a'.
root@server1:~#
root@server1:~# yc config list
token: y0_AgAAAAAIIsBGAATuwQAAAADxx0FFaMG86onpTYyRxd9128bowkuuqeY
cloud-id: b1g8h2rh376qfol4bodf
folder-id: b1gs07e2bjqttco10jqf
compute-default-zone: ru-central1-a
root@server1:~# yc vpc network create --name test-net --labels my-label=netology --description "test network via yc"
id: enpdrdt3pu23r64oh35i
folder_id: b1gs07e2bjqttco10jqf
created_at: "2023-11-12T11:27:12Z"
name: test-net
description: test network via yc
labels:
  my-label: netology
default_security_group_id: enpqu9hcvpqd0st260b3

root@server1:~# yc vpc subnet create --name test-subnet-a --zone ru-central1-a --range 10.1.2.0/24 --network-name test-net --description "test subnet via yc"
id: e9bkc01a7828r8se8lsi
folder_id: b1gs07e2bjqttco10jqf
created_at: "2023-11-12T11:27:43Z"
name: test-subnet-a
description: test subnet via yc
network_id: enpdrdt3pu23r64oh35i
zone_id: ru-central1-a
v4_cidr_blocks:
  - 10.1.2.0/24

root@server1:~# yc vpc network list
+----------------------+----------+
|          ID          |   NAME   |
+----------------------+----------+
| enp70hv581ggarjc12nq | default  |
| enpdrdt3pu23r64oh35i | test-net |
+----------------------+----------+
root@server1:~#
```
#установка packer 
```console

root@server1:/opt/yc# packer init /opt/yc/config.pkr.hcl
Installed plugin github.com/hashicorp/yandex v1.1.2 in "/root/.config/packer/plugins/github.com/hashicorp/yandex/packer-plugin-yandex_v1.1.2_x5.0_linux_amd64"
```
# Создание json для сборки образа
```console
root@server1:/opt/yc# cat imagedeb11.json
{
  "builders": [
    {
      "type":      "yandex",
      "token":     "y0_AgAAAAAIIsBGAATuwQAAAADxx0FFaMG86onpTYyRxd9128bowkuuqeY",
      "folder_id": "b1gs07e2bjqttco10jqf",
      "zone":      "ru-central1-a",

      "image_name":        "debian-11-nginx-{{isotime | clean_resource_name}}",
      "image_family":      "debian-web-server",
      "image_description": "my custom debian with nginx",

      "source_image_family": "debian-11",
      "subnet_id":           "e9bkc01a7828r8se8lsi",
      "use_ipv4_nat":        true,
      "disk_type":           "network-ssd",
      "ssh_username":        "debian"
    }
  ],
  "provisioners": [
    {
      "type": "shell",
      "inline": [
        "echo 'updating APT'",
        "sudo apt-get update -y",
        "sudo apt-get install -y nginx",
        "sudo su -",
        "sudo systemctl enable nginx.service",
        "curl localhost"
      ]
    }
  ]
}
```
#Сборка образа
```console

root@server1:/opt/yc# packer validate imagedeb11.json
The configuration is valid.
root@server1:/opt/yc# packer build imagedeb11.json
yandex: output will be in this color.
......
....
Build 'yandex' finished after 3 minutes 27 seconds.

==> Wait completed after 3 minutes 27 seconds

==> Builds finished. The artifacts of successful builds are:
--> yandex: A disk image was created: debian-11-nginx-2023-11-12t11-50-12z (id: fd8r4rp5imt2j9aot693) with family name debian-web-server
```


Результат:

![task_1](img/task1.png)



Список образов (чтобы узнать id образа): `yc compute image list`
```console
root@server1:/opt/yc# yc compute image list
+----------------------+--------------------------------------+-------------------+----------------------+--------+
|          ID          |                 NAME                 |      FAMILY       |     PRODUCT IDS      | STATUS |
+----------------------+--------------------------------------+-------------------+----------------------+--------+
| fd8r4rp5imt2j9aot693 | debian-11-nginx-2023-11-12t11-50-12z | debian-web-server | f2edn2qkmo97e9idkiqr | READY  |
```

Удаление образа: `yc compute image delete --id fd8r4rp5imt2j9aot693`

Удаление подсети: `yc vpc subnet delete --name test-subnet-a`

Удаление сети: `yc vpc network delete --name test-net`



###Задача 2
2.1. Создайте вашу первую виртуальную машину в YandexCloud с помощью web-интерфейса YandexCloud.


### Решение.

```console 
server was created and started 
...

elfxf@server1:/opt/yc$ ssh elfxf@84.201.179.234
Welcome to Ubuntu 22.04.3 LTS (GNU/Linux 5.15.0-88-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Sun Nov 12 12:23:34 PM UTC 2023

  System load:  0.783203125        Processes:             140
  Usage of /:   28.0% of 14.68GB   Users logged in:       0
  Memory usage: 11%                IPv4 address for eth0: 10.129.0.9
  Swap usage:   0%


Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


Last login: Sun Nov 12 12:23:35 2023 from 62.217.189.172
```
Скриншот
![task_2](img/task2.png)



###Задача 3

С помощью Ansible и Docker Compose разверните на виртуальной машине из предыдущего задания систему мониторинга на основе Prometheus/Grafana. Используйте Ansible-код в директории (src/ansible).
Чтобы получить зачёт, вам нужно предоставить вывод команды "docker ps" , все контейнеры, описанные в docker-compose, должны быть в статусе "Up".

```console 

curl -L https://github.com/docker/compose/releases/download/1.29.2/docker -o /usr/local/bin/docker-compose \ chmod +x /usr/local/bin/docker-compose

elfxf@ubuntusrv1:~/install/virtd-homeworks/05-virt-04-docker-compose/src/ansible/stack$ docker-compose up
permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get "http://%2Fvar%2Frun%2Fdocker.sock/v1.24/containers/json?all=1&filters=%7B%22label%22%3A%7B%22com.docker.compose.config-hash%22%3Atrue%2C%22com.docker.compose.project%3Dstack%22%3Atrue%7D%7D": dial unix /var/run/docker.sock: connect: permission denied
elfxf@ubuntusrv1:~/install/virtd-homeworks/05-virt-04-docker-compose/src/ansible/stack$ sudo docker-compose up
[+] Running 47/18
 ✔ nodeexporter 3 layers [⣿⣿⣿]      0B/0B      Pulled                                                                              10.4s
 ✔ pushgateway 2 layers [⣿⣿]      0B/0B      Pulled                                                                                10.6s
 ✔ caddy 6 layers [⣿⣿⣿⣿⣿⣿]      0B/0B      Pulled                                                                                   5.1s
 ✔ prometheus 12 layers [⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]      0B/0B      Pulled                                                                       8.9s
 ✔ alertmanager 4 layers [⣿⣿⣿⣿]      0B/0B      Pulled

....
....
.

caddy exited with code 2
caddy exited with code 2
caddy         | panic: runtime error: slice bounds out of range
caddy         |
caddy         | goroutine 1 [running]:
caddy         | github.com/mholt/caddy/vendor/github.com/miekg/dns.ClientConfigFromFile(0xbb4739, 0x10, 0x0, 0x0, 0x0)
caddy         |         src/github.com/mholt/caddy/vendor/github.com/miekg/dns/clientconfig.go:86 +0xad6
caddy         | github.com/mholt/caddy/vendor/github.com/xenolf/lego/acme.getNameservers(0xbb4739, 0x10, 0xfeaf20, 0x2, 0x2, 0xf77460, 0xc4200582b0, 0xc420037f50)
caddy         |         src/github.com/mholt/caddy/vendor/github.com/xenolf/lego/acme/dns_challenge.go:40 +0x4d
caddy         | github.com/mholt/caddy/vendor/github.com/xenolf/lego/acme.init()
caddy         |         src/github.com/mholt/caddy/vendor/github.com/xenolf/lego/acme/dns_challenge.go:33 +0x12d
caddy         | github.com/mholt/caddy/caddy/caddymain.init()
caddy         |         <autogenerated>:1 +0x75
caddy         | main.init()
caddy         |         <autogenerated>:1 +0x44
caddy exited with code 2


```


Скриншот
![task_2](img/task3.png)