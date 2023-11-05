# Домашнее задание по лекции "5.3. Введение. Экосистема. Архитектура. Жизненный цикл Docker контейнера"

##Задача 1
Сценарий выполнения задачи:

создайте свой репозиторий на https://hub.docker.com;
выберите любой образ, который содержит веб-сервер Nginx;
создайте свой fork образа;
реализуйте функциональность: запуск веб-сервера в фоне с индекс-страницей, содержащей HTML-код ниже:
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html>
Опубликуйте созданный fork в своём репозитории и предоставьте ответ в виде ссылки на https://hub.docker.com/username_repo.


Ответ:


- https://hub.docker.com/r/elfxf85/ivanmikurov
Docker commands
To push a new tag to this repository:
docker push elfxf85/ivanmikurov:tagname
docker pull elfxf85/ivanmikurov
-----

dockerfile содержит

FROM nginx
RUN  echo "<html><head>Hey, Netology</head><body><h1>I’m DevOps Engineer!</h1></body></html>" >/usr/share/nginx/html/index.html

запускаем сборку
```console
docker build -t elfxf85/el-nginx:1.0 

root@server1:~# docker build -t elfxf85/nginxsvr1:1.0 .
[+] Building 7.3s (7/7) FINISHED                                                                         docker:default
 => [internal] load .dockerignore                                                                                  0.0s
 => => transferring context: 2B                                                                                    0.0s
 => [internal] load build definition from dockerfile                                                               0.0s
 => => transferring dockerfile: 185B                                                                               0.0s
 => [internal] load metadata for docker.io/library/nginx:1.25                                                      6.7s
 => [auth] library/nginx:pull token for registry-1.docker.io                                                       0.0s
 => [1/2] FROM docker.io/library/nginx:1.25@sha256:86e53c4c16a6a276b204b0fd3a8143d86547c967dc8258b3d47c3a21bb68d3  0.1s
 => => resolve docker.io/library/nginx:1.25@sha256:86e53c4c16a6a276b204b0fd3a8143d86547c967dc8258b3d47c3a21bb68d3  0.0s
 => [2/2] RUN  echo "<html><head>Hey, Netology</head><body><h1>I’m DevOps Engineer!</h1></body></html>" >/usr/s    0.5s
 => exporting to image                                                                                             0.0s
 => => exporting layers                                                                                            0.0s
 => => writing image sha256:8197cc7bda2f0a8a23bb77014ad0b6761e8aca77170d0a6c0b1d94cf3dc2ce7f                       0.0s
 => => naming to docker.io/elfxf85/nginxsvr1:1.0                                                                   0.0s
root@server1:~# docker images
REPOSITORY          TAG       IMAGE ID       CREATED         SIZE
elfxf85/nginxsvr1   1.0       8197cc7bda2f   5 seconds ago   187MB
nginx               latest    c20060033e06   32 hours ago    187MB
hello-world         latest    9c7a54a9a43c   6 months ago    13.3kB

```

Запуск контейнера: `docker run <опции> <образ>`, где `<опции>` - параметры запуска, `<образ>` - имя запускаемого образа

Расшифровка используемых опций:

  - `-d` - создание "отвязанного" контейнера (работает в фоне);

  - `-p 8080:80` - проброс 80 порта контейнера на 8080 порт хоста;

  - `--rm` - удаление контейнера после его остановки;

  - `--name mycntnr` - присвоение создаваемому контейнеру имени `mycntnr`

```console

--Запуск контейнера
root@server1:~# docker run -d -p 8080:80 --rm --name mycntnr elfxf85/nginxsvr1:1.0
c54cb218ad6aeb1c4d08d34ca4fa89231791f757c1968483f6f590a7dc6d77da
root@server1:~# docker ps
CONTAINER ID   IMAGE                   COMMAND                  CREATED         STATUS         PORTS
               NAMES
c54cb218ad6a   elfxf85/nginxsvr1:1.0   "/docker-entrypoint.…"   8 seconds ago   Up 7 seconds   0.0.0.0:8080->80/tcp, :::8080->80/tcp   mycntnr

--Проверка работы
root@server1:~# curl 127.0.0.1:8080
<html><head>Hey, Netology</head><body><h1>I’m DevOps Engineer!</h1></body></html>
root@server1:~#

--остановка контейнера
root@server1:~# docker stop c54cb218ad6a
root@server1:~# docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
root@server1:~# curl 127.0.0.1:8080
curl: (7) Failed to connect to 127.0.0.1 port 8080 after 0 ms: Connection refused
root@server1:~#

---- login into Docker
root@server1:~docker login -u elfxf85
Password:
WARNING! Your password will be stored unencrypted in /root/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded
root@server1:~#
----push image
root@server1:~# docker push elfxf85/nginxsvr1:1.0
The push refers to repository [docker.io/elfxf85/nginxsvr1]
7c15af05d647: Pushed
505f49f13fbe: Mounted from library/nginx
9920f1ebf52b: Mounted from library/nginx
768e28a222fd: Mounted from library/nginx
715b32fa0f12: Mounted from library/nginx
e503754c9a26: Mounted from library/nginx
609f2a18d224: Mounted from library/nginx
ec983b166360: Mounted from library/nginx
1.0: digest: sha256:7501babc9652a15a85117d44e37e7b61d4ac458c4fb10951da4e6df7e9e3adfa size: 1985

```
Ссылка на репозиторий

https://hub.docker.com/repository/docker/elfxf85/nginxsvr1/general



```
Задача 2
Посмотрите на сценарий ниже и ответьте на вопрос: «Подходит ли в этом сценарии использование Docker-контейнеров или лучше подойдёт виртуальная машина, физическая машина? Может быть, возможны разные варианты?»

Детально опишите и обоснуйте свой выбор.

--

Сценарий:

высоконагруженное монолитное Java веб-приложение;
Nodejs веб-приложение;
мобильное приложение c версиями для Android и iOS;
шина данных на базе Apache Kafka;
Elasticsearch-кластер для реализации логирования продуктивного веб-приложения — три ноды elasticsearch, два logstash и две ноды kibana;
мониторинг-стек на базе Prometheus и Grafana;
MongoDB как основное хранилище данных для Java-приложения;
Gitlab-сервер для реализации CI/CD-процессов и приватный (закрытый) Docker Registry.

Ответ:

В данном сценарии использование Docker контейнеров является наиболее подходящим вариантом. Вот почему:

1.Высоконагруженное монолитное java веб-приложение: В данном случае, нужно использовать виртуальные машины или физические машины, так как они обладают большим 
объемом ресурсов и могут более эффективно обрабатывать высокие нагрузки.

2.Nodejs веб-приложение: Docker обеспечивает простоту установки и запуска Nodejs приложений в контейнере, что позволяет изолировать их от основных системных компонентов
 и гарантирует совместимость с любой операционной системой.

3. Мобильное приложение c версиями для Android и iOS: для разработки мобильных приложений, Docker позволяет создавать контейнеры с необходимой конфигурацией и зависимостями,
 что упрощает процесс развертывания и тестирования приложений на разных платформах.

4. Шина данных на базе Apache Kafka: Docker позволяет создавать и управлять контейнерами с Kafka брокерами и другими компонентами шины данных, обеспечивая простоту масштабирования 
и управления взаимодействием между компонентами.

5. Elasticsearch кластер: Elasticsearch может быть запущен как Docker контейнеры, однако для обеспечения высокой доступности и отказоустойчивости может быть предпочтительнее
 использование виртуальных машин или физических машин.

6.Мониторинг-стек на базе Prometheus и Grafana: Docker позволяет создавать и управлять контейнерами с Prometheus и Grafana, обеспечивая простоту масштабирования и управления 
мониторингом.

7.MongoDB: MongoDB может быть запущен как Docker контейнеры для упрощения развертывания и масштабирования, однако для больших объемов данных и высокой производительности
 может требоваться использование виртуальных машин или физических машин.


8.Gitlab . Одним из способов установки Gitlab как раз и являются образы Docker. Причём их использование значительно 
упрощает и экономит время на установку, настройку и дальнейшее обслуживание системы, так как всё эти действия
грубо говоря сводятся к запуску образа или перезапуску на новом образе при обновлении. Установка, обновление или 
удаление используемых компонентов выполняется автоматически.


Таким образом, использование Docker контейнеров для некоторых из компонентов сценария обеспечивает гибкость, масштабируемость, 
переносимость и простоту управления всей инфраструктурой приложения но для нагруженных приложений лучше использовать виртуальные сервера а для баз данных предпочтительнее
физическая машина или виртуальный сервер. 
-----------

Задача 3
Запустите первый контейнер из образа centos c любым тегом в фоновом режиме, подключив папку /data из текущей рабочей директории на хостовой машине в /data контейнера.
Запустите второй контейнер из образа debian в фоновом режиме, подключив папку /data из текущей рабочей директории на хостовой машине в /data контейнера.
Подключитесь к первому контейнеру с помощью docker exec и создайте текстовый файл любого содержания в /data.
Добавьте ещё один файл в папку /data на хостовой машине.
Подключитесь во второй контейнер и отобразите листинг и содержание файлов в /data контейнера.

###Ответ:

Подключение каталога осуществляется опциями: `-v <снаружи>:<внутри>`, где `<снаружи>` - монтируемый каталог хоста, `<внутри>` - соответствующий каталог в контейнере

Интерактивный режим активируется комбинацией ключей: `-i` (сохранение потока STDIN) и `-t` (создание псердотерминала TTY)

Предварительно создан каталог `data`

Запуск первого контейнера на основе образа **centos** (используется тэг [centos8] [centos](https://hub.docker.com/_/centos))
```console
elfxf@server1:~$ sudo docker run -i -t -d --rm --name my_centos8 -v $(pwd)/data:/data centos:centos8
[sudo] password for elfxf:
Unable to find image 'centos:centos8' locally
centos8: Pulling from library/centos
a1d0c7532777: Pull complete
Digest: sha256:a27fd8080b517143cbbbab9dfb7c8571c40d67d534bbdee55bd6c473f432b177
Status: Downloaded newer image for centos:centos8
3cc6cb3d7266bad4abb6fb5501ba7e42093dba57ef16343d42f0072985003644
elfxf@server1:~$ docker ps
CONTAINER ID   IMAGE            COMMAND       CREATED          STATUS         PORTS     NAMES
3cc6cb3d7266   centos:centos8   "/bin/bash"   10 seconds ago   Up 8 seconds             my_centos8
```
Запуск второго контейнера на основе образа **debiad**
```console
elfxf@server1:~$ sudo docker run -i -t -d --rm --name my_debian -v $(pwd)/data:/data debian
Unable to find image 'debian:latest' locally
latest: Pulling from library/debian
8457fd5474e7: Pull complete
Digest: sha256:fab22df37377621693c68650b06680c0d8f7c6bf816ec92637944778db3ca2c0
Status: Downloaded newer image for debian:latest
583cf6b100bc294de5ac07ffcb548e3002fc7b10ce8c1ff9285a23120294245b
elfxf@server1:~$ docker ps
CONTAINER ID   IMAGE            COMMAND       CREATED         STATUS         PORTS     NAMES
220935b1c9da   debian           "bash"        3 seconds ago   Up 2 seconds             my_debian
3cc6cb3d7266   centos:centos8   "/bin/bash"   4 minutes ago   Up 4 minutes             my_centos8
```
Создание файла в контейнере `my_centos8`

```console
elfxf@server1:~$ sudo docker exec -it my_centos8 bash
[root@3cc6cb3d7266 /]# echo "data1">/data/file1 && cat /data/file1
data1
[root@3cc6cb3d7266 data]# ls -latr /data/
total 12
drwxr-xr-x 1 root root 4096 Nov  2 13:52 ..
-rw-r--r-- 1 root root    6 Nov  2 13:58 file1
drwxrwxr-x 2 1000 1000 4096 Nov  2 13:58 .
[root@3cc6cb3d7266 data]#  exit

elfxf@server1:~$ sudo docker exec -it my_debian bash
root@220935b1c9da:/# "data super file2">data/file2 && cat data/file2
bash: data super file2: command not found
root@220935b1c9da:/# echo "data super file2">data/file2 && cat data/file2
data super file2

root@220935b1c9da:/# ls -latr /data
total 16
drwxr-xr-x 1 root root 4096 Nov  2 13:56 ..
-rw-r--r-- 1 root root    6 Nov  2 13:58 file1
drwxrwxr-x 2 1000 1000 4096 Nov  2 14:01 .
-rw-r--r-- 1 root root   17 Nov  2 14:01 file2
root@220935b1c9da:/#

--проверка на хостовой виртуальной машине содержимое папки 
elfxf@server1:~$ ls -latr data/
total 16
drwxr-x--- 18 elfxf elfxf 4096 ноя  2 16:48 ..
-rw-r--r--  1 root  root     6 ноя  2 16:58 file1
drwxrwxr-x  2 elfxf elfxf 4096 ноя  2 17:01 .
-rw-r--r--  1 root  root    17 ноя  2 17:01 file2
elfxf@server1:~$ cat data/file2
data super file2


```



Задача 4 (*)
Воспроизведите практическую часть лекции самостоятельно.

Соберите Docker-образ с Ansible, загрузите на Docker Hub и пришлите ссылку вместе с остальными ответами к задачам.

##ответ

```console
dockefile

FROM alpine:3.14
RUN  CARGO_NET_GIT_FETCH_WITH_CLI=1 && \
     apk --no-cache add \
sudo python3 py3-pip openssl ca-certificates sshpass openssh-client rsync git && \
     apk --no-cache add \
     --virtual build-dependencies python3-dev libffi-dev musl-dev gcc cargo openssl-dev \
        libressl-dev \
        build-base && \
     pip install --upgrade pip wheel && \
     pip install --upgrade cryptography cffi && \
     pip install ansible==2.10 && \
     pip install -I packaging==20.8 && \
     pip install mitogen ansible-lint jmespath && \
     pip install --upgrade pywinrm && \
     apk del build-dependencies && \
     rm -rf /var/cache/apk/* && \
     rm -rf /root/.cache/pip && \
     rm -rf /root/.cargo

RUN  mkdir /ansible && \
     mkdir -p /etc/ansible && \
     echo 'localhost' > /etc/ansible/hosts

WORKDIR /ansible
COPY ansible.cfg /ansible/

CMD  [ "ansible-playbook", "--version" ]


```
##сборка ok
```console

elfxf@server1:~/ansible$ docker build -t elfxf85/ansible:3.10 .
[+] Building 348.3s (10/10) FINISHED                                                                                        docker:default
 => [internal] load build definition from dockerfile                                                                                  0.0s
 => => transferring dockerfile: 948B                                                                                                  0.0s
 => [internal] load .dockerignore                                                                                                     0.0s
 => => transferring context: 2B                                                                                                       0.0s
 => [internal] load metadata for docker.io/library/alpine:3.14                                                                        0.0s
 => CACHED [1/5] FROM docker.io/library/alpine:3.14                                                                                   0.0s
 => [internal] load build context                                                                                                     0.0s
 => => transferring context: 201B                                                                                                     0.0s
 => [2/5] RUN  CARGO_NET_GIT_FETCH_WITH_CLI=1 &&      apk --no-cache add sudo python3 py3-pip openssl ca-certificates sshpass open  342.9s
 => [3/5] RUN  mkdir /ansible &&      mkdir -p /etc/ansible &&      echo 'localhost' > /etc/ansible/hosts                             0.6s
 => [4/5] WORKDIR /ansible                                                                                                            0.0s
 => [5/5] COPY ansible.cfg /ansible/                                                                                                  0.0s
 => exporting to image                                                                                                                4.7s
 => => exporting layers                                                                                                               4.7s
 => => writing image sha256:8464c71ef16baffcf5272e428c604ddd7b8d5e81e801e93bfed373f704369c53                                          0.0s
 => => naming to docker.io/elfxf/ansible:3.10                                                                                         0.0s
elfxf@server1:~/ansible$ docke images
Command 'docke' not found, did you mean:
  command 'docker' from deb docker.io (24.0.5-0ubuntu1~22.04.1)
  command 'docker' from deb podman-docker (3.4.4+ds1-1ubuntu1.22.04.2)
Try: sudo apt install <deb name>
### какие репозитории есть
elfxf@server1:~/ansible$ docker images
REPOSITORY          TAG       IMAGE ID       CREATED         SIZE
elfxf85/ansible       3.10      8464c71ef16b   2 minutes ago   392MB

---- запуск контейнера
elfxf@server1:~/ansible$ sudo docker run --rm elfxf85/ansible:3.10
[sudo] password for elfxf:
Sorry, try again.
[sudo] password for elfxf:
ansible-playbook [core 2.15.5]
  config file = /ansible/ansible.cfg
  configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3.9/site-packages/ansible
  ansible collection location = /root/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/bin/ansible-playbook
  python version = 3.9.17 (main, Jun  9 2023, 02:31:24) [GCC 10.3.1 20210424] (/usr/bin/python3)
  jinja version = 3.1.2
  libyaml = True
  
root@server1:~/ansible# docker push elfxf85/ansible:3.10
The push refers to repository [docker.io/elfxf85/ansible]
832d3c535a73: Pushed
5f70bf18a086: Pushed
2816c1496df6: Pushed
e4c6c056fbff: Pushed
9733ccc39513: Pushed
3.10: digest: sha256:c8c0462735aae6d57686e0c70a78d2f087bee6bff381e06fec42c0a2250392f1 size: 1360
root@server1:~/ansible#


Ссылка на репозиторий [ansible]
https://hub.docker.com/repository/docker/elfxf85/ansible/general
```

