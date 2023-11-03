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
------
запускаем сборку
docker build -t elfxf85/el-nginx:1.0 
------
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

  - `--name myn` - присвоение создаваемому контейнеру имени `myn`

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

FROM alpine:3.18

RUN CARGO_NET_GIT_FETCH_WITH_CLI=1 && \
    apk --no-cache add \
        sudo \
        python3\
        py3-pip \
        openssl \
        ca-certificates \
        sshpass \
        openssh-client \
        rsync \
        git && \
    apk --no-cache add --virtual build-dependencies \
        python3-dev \
        libffi-dev \
        musl-dev \
        gcc \
        cargo \
        openssl-dev \
        libressl-dev \
        build-base && \
    pip install --upgrade pip wheel && \
    pip install --upgrade cryptography cffi && \
    pip uninstall ansible-base && \
    pip install ansible-core && \
    pip install ansible==2.10 && \
    pip install mitogen ansible-lint jmespath && \
    pip install --upgrade pywinrm && \
    apk del build-dependencies && \
    rm -rf /var/cache/apk/* && \
    rm -rf /root/.cache/pip && \
    rm -rf /root/.cargo

RUN mkdir /ansible && \
    mkdir -p /etc/ansible && \
    echo 'localhost' > /etc/ansible/hosts

WORKDIR /ansible

CMD [ "ansible-playbook", "--version" ]




```
##сборка падает с ошибкой
```console


sudo docker build -t elfxf/ansible:2.10 .

elfxf@server1:~/ansible$ sudo docker build -t elfxf/ansible:2.10 .
[sudo] password for elfxf:
[+] Building 291.6s (6/8)                                                                                                                    docker:default
 => [internal] load .dockerignore                                                                                                                      0.0s
 => => transferring context: 2B                                                                                                                        0.0s
 => [internal] load build definition from dockerfile                                                                                                   0.0s
 => => transferring dockerfile: 1.07kB                                                                                                                 0.0s
 => [internal] load metadata for docker.io/library/alpine:3.14                                                                                         9.1s
 => [auth] library/alpine:pull token for registry-1.docker.io                                                                                          0.0s
 => CACHED [1/4] FROM docker.io/library/alpine:3.14@sha256:0f2d5c38dd7a4f4f733e688e3a6733cb5ab1ac6e3cb4603a5dd564e5bfb80eed                            0.0s
 => ERROR [2/4] RUN CARGO_NET_GIT_FETCH_WITH_CLI=1 &&     apk --no-cache add         sudo         python3        py3-pip         openssl         ca  282.4s
------
 > [2/4] RUN CARGO_NET_GIT_FETCH_WITH_CLI=1 &&     apk --no-cache add         sudo         python3        py3-pip         openssl         ca-certificates         sshpass         openssh-client         rsync         git &&     apk --no-cache add --virtual build-dependencies         python3-dev         libffi-dev         musl-dev         gcc         cargo         openssl-dev         libressl-dev         build-base &&     pip install --upgrade pip wheel &&     pip install --upgrade cryptography cffi &&     pip uninstall ansible-base &&     pip install ansible-core &&     pip install ansible==2.10 &&     pip install mitogen ansible-lint jmespath &&     pip install --upgrade pywinrm &&     apk del build-dependencies &&     rm -rf /var/cache/apk/* &&     rm -rf /root/.cache/pip &&     rm -rf /root/.cargo:
0.480 fetch https://dl-cdn.alpinelinux.org/alpine/v3.14/main/x86_64/APKINDEX.tar.gz
1.206 fetch https://dl-cdn.alpinelinux.org/alpine/v3.14/community/x86_64/APKINDEX.tar.gz
1.766 (1/55) Installing ca-certificates (20230506-r0)
1.910 (2/55) Installing brotli-libs (1.0.9-r5)
2.020 (3/55) Installing nghttp2-libs (1.43.0-r0)
2.111 (4/55) Installing libcurl (8.0.1-r0)
2.225 (5/55) Installing expat (2.5.0-r0)
2.317 (6/55) Installing pcre2 (10.36-r1)
2.428 (7/55) Installing git (2.32.7-r0)
2.969 (8/55) Installing openssh-keygen (8.6_p1-r3)
3.070 (9/55) Installing ncurses-terminfo-base (6.2_p20210612-r1)
3.166 (10/55) Installing ncurses-libs (6.2_p20210612-r1)
3.269 (11/55) Installing libedit (20210216.3.1-r0)
3.360 (12/55) Installing openssh-client-common (8.6_p1-r3)
3.510 (13/55) Installing openssh-client-default (8.6_p1-r3)
3.620 (14/55) Installing openssl (1.1.1t-r2)
3.730 (15/55) Installing libbz2 (1.0.8-r1)
3.815 (16/55) Installing libffi (3.3-r2)
3.900 (17/55) Installing gdbm (1.19-r0)
3.993 (18/55) Installing xz-libs (5.2.5-r1)
4.083 (19/55) Installing libgcc (10.3.1_git20210424-r2)
4.172 (20/55) Installing libstdc++ (10.3.1_git20210424-r2)
4.294 (21/55) Installing mpdecimal (2.5.1-r1)
4.386 (22/55) Installing readline (8.1.0-r0)
4.482 (23/55) Installing sqlite-libs (3.35.5-r0)
4.601 (24/55) Installing python3 (3.9.17-r0)
6.282 (25/55) Installing py3-appdirs (1.4.4-r2)
6.377 (26/55) Installing py3-chardet (4.0.0-r2)
6.527 (27/55) Installing py3-idna (3.2-r0)
6.631 (28/55) Installing py3-urllib3 (1.26.5-r0)
7.215 (29/55) Installing py3-certifi (2020.12.5-r1)
7.326 (30/55) Installing py3-requests (2.25.1-r4)
7.446 (31/55) Installing py3-msgpack (1.0.2-r1)
7.545 (32/55) Installing py3-lockfile (0.12.2-r4)
7.639 (33/55) Installing py3-cachecontrol (0.12.6-r1)
7.737 (34/55) Installing py3-colorama (0.4.4-r1)
7.828 (35/55) Installing py3-contextlib2 (0.6.0-r1)
7.915 (36/55) Installing py3-distlib (0.3.1-r3)
8.047 (37/55) Installing py3-distro (1.5.0-r3)
8.137 (38/55) Installing py3-six (1.15.0-r1)
8.225 (39/55) Installing py3-webencodings (0.5.1-r4)
8.316 (40/55) Installing py3-html5lib (1.1-r1)
8.450 (41/55) Installing py3-parsing (2.4.7-r2)
8.553 (42/55) Installing py3-packaging (20.9-r1)
8.650 (43/55) Installing py3-toml (0.10.2-r2)
8.741 (44/55) Installing py3-pep517 (0.10.0-r2)
8.836 (45/55) Installing py3-progress (1.5-r2)
8.922 (46/55) Installing py3-retrying (1.3.3-r1)
9.009 (47/55) Installing py3-ordered-set (4.0.2-r1)
9.096 (48/55) Installing py3-setuptools (52.0.0-r3)
9.311 (49/55) Installing py3-pip (20.3.4-r1)
9.821 (50/55) Installing libacl (2.2.53-r0)
9.907 (51/55) Installing popt (1.18-r0)
9.993 (52/55) Installing zstd-libs (1.4.9-r1)
10.12 (53/55) Installing rsync (3.2.5-r0)
10.23 (54/55) Installing sshpass (1.09-r0)
10.32 (55/55) Installing sudo (1.9.12_p2-r0)
10.51 Executing busybox-1.33.1-r8.trigger
10.53 Executing ca-certificates-20230506-r0.trigger
10.64 OK: 99 MiB in 69 packages
10.73 fetch https://dl-cdn.alpinelinux.org/alpine/v3.14/main/x86_64/APKINDEX.tar.gz
11.41 fetch https://dl-cdn.alpinelinux.org/alpine/v3.14/community/x86_64/APKINDEX.tar.gz
11.88 (1/38) Upgrading musl (1.2.2-r4 -> 1.2.2-r5)
11.98 (2/38) Installing pkgconf (1.7.4-r1)
12.07 (3/38) Installing python3-dev (3.9.17-r0)
13.70 (4/38) Installing linux-headers (5.10.41-r0)
14.48 (5/38) Installing libffi-dev (3.3-r2)
14.58 (6/38) Installing musl-dev (1.2.2-r5)
15.01 (7/38) Installing binutils (2.35.2-r2)
15.43 (8/38) Installing libgomp (10.3.1_git20210424-r2)
15.53 (9/38) Installing libatomic (10.3.1_git20210424-r2)
15.61 (10/38) Installing libgphobos (10.3.1_git20210424-r2)
15.91 (11/38) Installing gmp (6.2.1-r1)
16.02 (12/38) Installing isl22 (0.22-r0)
16.17 (13/38) Installing mpfr4 (4.1.0-r0)
16.48 (14/38) Installing mpc1 (1.2.1-r0)
16.57 (15/38) Installing gcc (10.3.1_git20210424-r2)
20.69 (16/38) Installing rust-stdlib (1.52.1-r1)
68.39 (17/38) Installing libxml2 (2.9.14-r2)
68.67 (18/38) Installing llvm11-libs (11.1.0-r2)
75.33 (19/38) Installing http-parser (2.9.4-r0)
75.42 (20/38) Installing pcre (8.44-r0)
75.53 (21/38) Installing libssh2 (1.9.0-r1)
75.62 (22/38) Installing libgit2 (1.1.0-r2)
75.75 (23/38) Installing rust (1.52.1-r1)
85.98 (24/38) Installing cargo (1.52.1-r1)
86.50 (25/38) Installing openssl-dev (1.1.1t-r2)
86.63 (26/38) Installing libressl3.3-libcrypto (3.3.6-r0)
86.79 (27/38) Installing libressl3.3-libssl (3.3.6-r0)
86.89 (28/38) Installing libressl3.3-libtls (3.3.6-r0)
87.06 (29/38) Installing libressl-dev (3.3.6-r0)
88.60 (30/38) Installing libmagic (5.40-r1)
88.73 (31/38) Installing file (5.40-r1)
88.81 (32/38) Installing libc-dev (0.7.2-r3)
89.27 (33/38) Installing g++ (10.3.1_git20210424-r2)
91.96 (34/38) Installing make (4.3-r0)
92.05 (35/38) Installing fortify-headers (1.1-r1)
92.14 (36/38) Installing patch (2.7.6-r7)
92.24 (37/38) Installing build-base (0.5-r3)
92.32 (38/38) Installing build-dependencies (20231103.043828)
92.33 Executing busybox-1.33.1-r8.trigger
92.36 OK: 1111 MiB in 106 packages
93.24 Requirement already satisfied: pip in /usr/lib/python3.9/site-packages (20.3.4)
93.97 Collecting pip
94.58   Downloading pip-23.3.1-py3-none-any.whl (2.1 MB)
95.55 Collecting wheel
95.70   Downloading wheel-0.41.3-py3-none-any.whl (65 kB)
95.87 Installing collected packages: wheel, pip
96.00   Attempting uninstall: pip
96.00     Found existing installation: pip 20.3.4
96.01     Uninstalling pip-20.3.4:
96.04       Successfully uninstalled pip-20.3.4
99.35 Successfully installed pip-23.3.1 wheel-0.41.3
102.1 Collecting cryptography
102.4   Downloading cryptography-41.0.5-cp37-abi3-musllinux_1_1_x86_64.whl.metadata (5.2 kB)
102.9 Collecting cffi
103.1   Downloading cffi-1.16.0-cp39-cp39-musllinux_1_1_x86_64.whl.metadata (1.5 kB)
103.4 Collecting pycparser (from cffi)
103.5   Downloading pycparser-2.21-py2.py3-none-any.whl (118 kB)
103.7      ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 118.7/118.7 kB 667.7 kB/s eta 0:00:00
103.8 Downloading cryptography-41.0.5-cp37-abi3-musllinux_1_1_x86_64.whl (4.4 MB)
104.4    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 4.4/4.4 MB 7.9 MB/s eta 0:00:00
104.5 Downloading cffi-1.16.0-cp39-cp39-musllinux_1_1_x86_64.whl (465 kB)
104.5    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 465.3/465.3 kB 12.8 MB/s eta 0:00:00
104.8 Installing collected packages: pycparser, cffi, cryptography
105.9 Successfully installed cffi-1.16.0 cryptography-41.0.5 pycparser-2.21
105.9 WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv
107.2 WARNING: Skipping ansible-base as it is not installed.
107.2 WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv
108.8 Collecting ansible-core
111.8   Downloading ansible_core-2.15.5-py3-none-any.whl.metadata (7.0 kB)
112.0 Collecting jinja2>=3.0.0 (from ansible-core)
112.2   Downloading Jinja2-3.1.2-py3-none-any.whl (133 kB)
112.4      ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 133.1/133.1 kB 567.4 kB/s eta 0:00:00
112.8 Collecting PyYAML>=5.1 (from ansible-core)
112.9   Downloading PyYAML-6.0.1-cp39-cp39-musllinux_1_1_x86_64.whl.metadata (2.1 kB)
112.9 Requirement already satisfied: cryptography in /usr/lib/python3.9/site-packages (from ansible-core) (41.0.5)
112.9 Requirement already satisfied: packaging in /usr/lib/python3.9/site-packages (from ansible-core) (20.9)
113.1 Collecting resolvelib<1.1.0,>=0.5.3 (from ansible-core)
113.2   Downloading resolvelib-1.0.1-py2.py3-none-any.whl (17 kB)
113.5 Collecting importlib-resources<5.1,>=5.0 (from ansible-core)
113.6   Downloading importlib_resources-5.0.7-py3-none-any.whl (24 kB)
114.3 Collecting MarkupSafe>=2.0 (from jinja2>=3.0.0->ansible-core)
114.4   Downloading MarkupSafe-2.1.3-cp39-cp39-musllinux_1_1_x86_64.whl.metadata (3.0 kB)
114.6 Requirement already satisfied: cffi>=1.12 in /usr/lib/python3.9/site-packages (from cryptography->ansible-core) (1.16.0)
114.6 Requirement already satisfied: pycparser in /usr/lib/python3.9/site-packages (from cffi>=1.12->cryptography->ansible-core) (2.21)
114.8 Downloading ansible_core-2.15.5-py3-none-any.whl (2.2 MB)
115.2    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 2.2/2.2 MB 4.7 MB/s eta 0:00:00
115.4 Downloading PyYAML-6.0.1-cp39-cp39-musllinux_1_1_x86_64.whl (750 kB)
115.4    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 750.3/750.3 kB 19.9 MB/s eta 0:00:00
115.5 Downloading MarkupSafe-2.1.3-cp39-cp39-musllinux_1_1_x86_64.whl (29 kB)
115.8 Installing collected packages: resolvelib, PyYAML, MarkupSafe, importlib-resources, jinja2, ansible-core
119.9 Successfully installed MarkupSafe-2.1.3 PyYAML-6.0.1 ansible-core-2.15.5 importlib-resources-5.0.7 jinja2-3.1.2 resolvelib-1.0.1
119.9 WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv
121.8 Collecting ansible==2.10
122.3   Downloading ansible-2.10.0.tar.gz (25.5 MB)
134.4      ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 25.5/25.5 MB 1.7 MB/s eta 0:00:00
151.8   Preparing metadata (setup.py): started
163.4   Preparing metadata (setup.py): finished with status 'done'
163.5 Collecting ansible-base<2.11,>=2.10.1 (from ansible==2.10)
163.7   Downloading ansible-base-2.10.17.tar.gz (6.1 MB)
166.6      ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 6.1/6.1 MB 2.1 MB/s eta 0:00:00
171.6   Preparing metadata (setup.py): started
172.8   Preparing metadata (setup.py): finished with status 'done'
172.8 Requirement already satisfied: jinja2 in /usr/lib/python3.9/site-packages (from ansible-base<2.11,>=2.10.1->ansible==2.10) (3.1.2)
172.8 Requirement already satisfied: PyYAML in /usr/lib/python3.9/site-packages (from ansible-base<2.11,>=2.10.1->ansible==2.10) (6.0.1)
172.8 Requirement already satisfied: cryptography in /usr/lib/python3.9/site-packages (from ansible-base<2.11,>=2.10.1->ansible==2.10) (41.0.5)
172.8 Requirement already satisfied: packaging in /usr/lib/python3.9/site-packages (from ansible-base<2.11,>=2.10.1->ansible==2.10) (20.9)
172.8 Requirement already satisfied: cffi>=1.12 in /usr/lib/python3.9/site-packages (from cryptography->ansible-base<2.11,>=2.10.1->ansible==2.10) (1.16.0)
172.8 Requirement already satisfied: MarkupSafe>=2.0 in /usr/lib/python3.9/site-packages (from jinja2->ansible-base<2.11,>=2.10.1->ansible==2.10) (2.1.3)
172.8 Requirement already satisfied: pycparser in /usr/lib/python3.9/site-packages (from cffi>=1.12->cryptography->ansible-base<2.11,>=2.10.1->ansible==2.10) (2.21)
172.8 Building wheels for collected packages: ansible, ansible-base
172.8   Building wheel for ansible (setup.py): started
216.7   Building wheel for ansible (setup.py): finished with status 'done'
216.8   Created wheel for ansible: filename=ansible-2.10.0-py3-none-any.whl size=43068822 sha256=b9be4a2e9ca8a0c0da3962187cec8fb9897c1e046994bca170b2208ff0324c36
216.8   Stored in directory: /root/.cache/pip/wheels/5c/ab/85/c81eaaeaf7239a38ab4eceea7cec8d110618aee6887b2491d3
217.1   Building wheel for ansible-base (setup.py): started
219.2   Building wheel for ansible-base (setup.py): finished with status 'done'
219.2   Created wheel for ansible-base: filename=ansible_base-2.10.17-py3-none-any.whl size=1880367 sha256=51cc5ec987b29fc667fe74ce2a3894d644dec42238fcf0544f3e68237ba6be20
219.2   Stored in directory: /root/.cache/pip/wheels/77/01/15/0d4b716065c1270fd0b9c28e5bd44d5fd907c43a85791747d7
219.2 Successfully built ansible ansible-base
219.6 Installing collected packages: ansible-base, ansible
248.0 Successfully installed ansible-2.10.0 ansible-base-2.10.17
248.0 WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv
252.3 Collecting mitogen
253.1   Downloading mitogen-0.3.4-py2.py3-none-any.whl.metadata (1.7 kB)
253.5 Collecting ansible-lint
253.7   Downloading ansible_lint-6.21.1-py3-none-any.whl.metadata (7.7 kB)
253.9 Collecting jmespath
254.0   Downloading jmespath-1.0.1-py3-none-any.whl (20 kB)
254.2 Requirement already satisfied: ansible-core>=2.12.0 in /usr/lib/python3.9/site-packages (from ansible-lint) (2.15.5)
254.4 Collecting ansible-compat>=4.1.10 (from ansible-lint)
254.5   Downloading ansible_compat-4.1.10-py3-none-any.whl.metadata (2.8 kB)
254.8 Collecting black>=22.8.0 (from ansible-lint)
255.1   Downloading black-23.10.1-py3-none-any.whl.metadata (66 kB)
255.3      ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 66.0/66.0 kB 475.4 kB/s eta 0:00:00
255.5 Collecting filelock>=3.3.0 (from ansible-lint)
255.7   Downloading filelock-3.13.1-py3-none-any.whl.metadata (2.8 kB)
255.9 Collecting jsonschema>=4.10.0 (from ansible-lint)
256.3   Downloading jsonschema-4.19.2-py3-none-any.whl.metadata (7.9 kB)
256.6 Collecting packaging>=21.3 (from ansible-lint)
256.8   Downloading packaging-23.2-py3-none-any.whl.metadata (3.2 kB)
257.0 Collecting pathspec>=0.10.3 (from ansible-lint)
257.3   Downloading pathspec-0.11.2-py3-none-any.whl.metadata (19 kB)
257.5 Requirement already satisfied: pyyaml>=5.4.1 in /usr/lib/python3.9/site-packages (from ansible-lint) (6.0.1)
258.6 Collecting rich>=12.0.0 (from ansible-lint)
258.7   Downloading rich-13.6.0-py3-none-any.whl.metadata (18 kB)
259.8 Collecting ruamel.yaml!=0.17.29,!=0.17.30,<0.18,>=0.17.0 (from ansible-lint)
260.1   Downloading ruamel.yaml-0.17.40-py3-none-any.whl.metadata (19 kB)
260.3 Collecting requests>=2.31.0 (from ansible-lint)
260.5   Downloading requests-2.31.0-py3-none-any.whl.metadata (4.6 kB)
260.6 Collecting subprocess-tee>=0.4.1 (from ansible-lint)
260.8   Downloading subprocess_tee-0.4.1-py3-none-any.whl (5.1 kB)
261.0 Collecting yamllint>=1.30.0 (from ansible-lint)
261.2   Downloading yamllint-1.32.0-py3-none-any.whl.metadata (4.2 kB)
261.4 Collecting wcmatch>=8.1.2 (from ansible-lint)
261.6   Downloading wcmatch-8.5-py3-none-any.whl.metadata (5.1 kB)
261.9 Collecting typing-extensions>=4.5.0 (from ansible-compat>=4.1.10->ansible-lint)
262.1   Downloading typing_extensions-4.8.0-py3-none-any.whl.metadata (3.0 kB)
262.2 Requirement already satisfied: jinja2>=3.0.0 in /usr/lib/python3.9/site-packages (from ansible-core>=2.12.0->ansible-lint) (3.1.2)
262.2 Requirement already satisfied: cryptography in /usr/lib/python3.9/site-packages (from ansible-core>=2.12.0->ansible-lint) (41.0.5)
262.2 Requirement already satisfied: resolvelib<1.1.0,>=0.5.3 in /usr/lib/python3.9/site-packages (from ansible-core>=2.12.0->ansible-lint) (1.0.1)
262.2 Requirement already satisfied: importlib-resources<5.1,>=5.0 in /usr/lib/python3.9/site-packages (from ansible-core>=2.12.0->ansible-lint) (5.0.7)
262.4 Collecting click>=8.0.0 (from black>=22.8.0->ansible-lint)
262.5   Downloading click-8.1.7-py3-none-any.whl.metadata (3.0 kB)
262.7 Collecting mypy-extensions>=0.4.3 (from black>=22.8.0->ansible-lint)
262.8   Downloading mypy_extensions-1.0.0-py3-none-any.whl (4.7 kB)
263.1 Collecting platformdirs>=2 (from black>=22.8.0->ansible-lint)
263.2   Downloading platformdirs-3.11.0-py3-none-any.whl.metadata (11 kB)
263.4 Collecting tomli>=1.1.0 (from black>=22.8.0->ansible-lint)
263.5   Downloading tomli-2.0.1-py3-none-any.whl (12 kB)
263.8 Collecting attrs>=22.2.0 (from jsonschema>=4.10.0->ansible-lint)
264.1   Downloading attrs-23.1.0-py3-none-any.whl (61 kB)
264.1      ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 61.2/61.2 kB 3.0 MB/s eta 0:00:00
264.3 Collecting jsonschema-specifications>=2023.03.6 (from jsonschema>=4.10.0->ansible-lint)
264.7   Downloading jsonschema_specifications-2023.7.1-py3-none-any.whl.metadata (2.8 kB)
265.1 Collecting referencing>=0.28.4 (from jsonschema>=4.10.0->ansible-lint)
265.2   Downloading referencing-0.30.2-py3-none-any.whl.metadata (2.6 kB)
266.0 Collecting rpds-py>=0.7.1 (from jsonschema>=4.10.0->ansible-lint)
266.2   Downloading rpds_py-0.10.6-cp39-cp39-musllinux_1_2_x86_64.whl.metadata (3.7 kB)
266.7 Collecting charset-normalizer<4,>=2 (from requests>=2.31.0->ansible-lint)
266.9   Downloading charset_normalizer-3.3.2-cp39-cp39-musllinux_1_1_x86_64.whl.metadata (33 kB)
266.9 Requirement already satisfied: idna<4,>=2.5 in /usr/lib/python3.9/site-packages (from requests>=2.31.0->ansible-lint) (3.2)
267.0 Requirement already satisfied: urllib3<3,>=1.21.1 in /usr/lib/python3.9/site-packages (from requests>=2.31.0->ansible-lint) (1.26.5)
267.0 Requirement already satisfied: certifi>=2017.4.17 in /usr/lib/python3.9/site-packages (from requests>=2.31.0->ansible-lint) (2020.12.5)
267.2 Collecting markdown-it-py>=2.2.0 (from rich>=12.0.0->ansible-lint)
267.3   Downloading markdown_it_py-3.0.0-py3-none-any.whl.metadata (6.9 kB)
267.5 Collecting pygments<3.0.0,>=2.13.0 (from rich>=12.0.0->ansible-lint)
267.7   Downloading Pygments-2.16.1-py3-none-any.whl.metadata (2.5 kB)
268.0 Collecting ruamel.yaml.clib>=0.2.7 (from ruamel.yaml!=0.17.29,!=0.17.30,<0.18,>=0.17.0->ansible-lint)
268.1   Downloading ruamel.yaml.clib-0.2.8-cp39-cp39-musllinux_1_1_x86_64.whl.metadata (2.2 kB)
268.3 Collecting bracex>=2.1.1 (from wcmatch>=8.1.2->ansible-lint)
268.4   Downloading bracex-2.4-py3-none-any.whl.metadata (3.6 kB)
268.7 Requirement already satisfied: MarkupSafe>=2.0 in /usr/lib/python3.9/site-packages (from jinja2>=3.0.0->ansible-core>=2.12.0->ansible-lint) (2.1.3)
268.9 Collecting mdurl~=0.1 (from markdown-it-py>=2.2.0->rich>=12.0.0->ansible-lint)
269.1   Downloading mdurl-0.1.2-py3-none-any.whl (10.0 kB)
269.5 Requirement already satisfied: cffi>=1.12 in /usr/lib/python3.9/site-packages (from cryptography->ansible-core>=2.12.0->ansible-lint) (1.16.0)
269.5 Requirement already satisfied: pycparser in /usr/lib/python3.9/site-packages (from cffi>=1.12->cryptography->ansible-core>=2.12.0->ansible-lint) (2.21)
269.8 Downloading mitogen-0.3.4-py2.py3-none-any.whl (291 kB)
270.2    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 291.9/291.9 kB 713.4 kB/s eta 0:00:00
270.4 Downloading ansible_lint-6.21.1-py3-none-any.whl (295 kB)
270.7    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 295.2/295.2 kB 824.4 kB/s eta 0:00:00
270.8 Downloading ansible_compat-4.1.10-py3-none-any.whl (22 kB)
271.0 Downloading black-23.10.1-py3-none-any.whl (184 kB)
271.2    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 184.6/184.6 kB 854.5 kB/s eta 0:00:00
271.3 Downloading filelock-3.13.1-py3-none-any.whl (11 kB)
271.5 Downloading jsonschema-4.19.2-py3-none-any.whl (83 kB)
271.6    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 83.6/83.6 kB 1.9 MB/s eta 0:00:00
271.7 Downloading packaging-23.2-py3-none-any.whl (53 kB)
271.8    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 53.0/53.0 kB 1.8 MB/s eta 0:00:00
271.9 Downloading pathspec-0.11.2-py3-none-any.whl (29 kB)
272.1 Downloading requests-2.31.0-py3-none-any.whl (62 kB)
272.2    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 62.6/62.6 kB 3.1 MB/s eta 0:00:00
272.3 Downloading rich-13.6.0-py3-none-any.whl (239 kB)
272.7    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 239.8/239.8 kB 696.3 kB/s eta 0:00:00
272.9 Downloading ruamel.yaml-0.17.40-py3-none-any.whl (113 kB)
273.0    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 113.7/113.7 kB 845.7 kB/s eta 0:00:00
273.2 Downloading wcmatch-8.5-py3-none-any.whl (39 kB)
273.3 Downloading yamllint-1.32.0-py3-none-any.whl (65 kB)
273.4    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 65.4/65.4 kB 819.0 kB/s eta 0:00:00
273.6 Downloading bracex-2.4-py3-none-any.whl (11 kB)
273.7 Downloading charset_normalizer-3.3.2-cp39-cp39-musllinux_1_1_x86_64.whl (142 kB)
273.9    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 142.7/142.7 kB 945.6 kB/s eta 0:00:00
274.1 Downloading click-8.1.7-py3-none-any.whl (97 kB)
274.1    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 97.9/97.9 kB 4.7 MB/s eta 0:00:00
274.3 Downloading jsonschema_specifications-2023.7.1-py3-none-any.whl (17 kB)
274.5 Downloading markdown_it_py-3.0.0-py3-none-any.whl (87 kB)
274.5    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 87.5/87.5 kB 2.5 MB/s eta 0:00:00
274.7 Downloading platformdirs-3.11.0-py3-none-any.whl (17 kB)
274.9 Downloading Pygments-2.16.1-py3-none-any.whl (1.2 MB)
276.0    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 1.2/1.2 MB 1.0 MB/s eta 0:00:00
276.2 Downloading referencing-0.30.2-py3-none-any.whl (25 kB)
276.4 Downloading rpds_py-0.10.6-cp39-cp39-musllinux_1_2_x86_64.whl (1.3 MB)
277.7    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 1.3/1.3 MB 1.0 MB/s eta 0:00:00
277.9 Downloading ruamel.yaml.clib-0.2.8-cp39-cp39-musllinux_1_1_x86_64.whl (692 kB)
278.6    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 692.2/692.2 kB 939.0 kB/s eta 0:00:00
278.8 Downloading typing_extensions-4.8.0-py3-none-any.whl (31 kB)
279.5 Installing collected packages: typing-extensions, tomli, subprocess-tee, ruamel.yaml.clib, rpds-py, pygments, platformdirs, pathspec, packaging, mypy-extensions, mitogen, mdurl, jmespath, filelock, click, charset-normalizer, bracex, attrs, yamllint, wcmatch, ruamel.yaml, requests, referencing, markdown-it-py, black, rich, jsonschema-specifications, jsonschema, ansible-compat, ansible-lint
281.7   Attempting uninstall: packaging
281.7     Found existing installation: packaging 20.9
281.7 ERROR: Cannot uninstall 'packaging'. It is a distutils installed project and thus we cannot accurately determine which files belong to it which would lead to only a partial uninstall.
------
dockerfile:3
--------------------
   2 |
   3 | >>> RUN CARGO_NET_GIT_FETCH_WITH_CLI=1 && \
   4 | >>>     apk --no-cache add \
   5 | >>>         sudo \
   6 | >>>         python3\
   7 | >>>         py3-pip \
   8 | >>>         openssl \
   9 | >>>         ca-certificates \
  10 | >>>         sshpass \
  11 | >>>         openssh-client \
  12 | >>>         rsync \
  13 | >>>         git && \
  14 | >>>     apk --no-cache add --virtual build-dependencies \
  15 | >>>         python3-dev \
  16 | >>>         libffi-dev \
  17 | >>>         musl-dev \
  18 | >>>         gcc \
  19 | >>>         cargo \
  20 | >>>         openssl-dev \
  21 | >>>         libressl-dev \
  22 | >>>         build-base && \
  23 | >>>     pip install --upgrade pip wheel && \
  24 | >>>     pip install --upgrade cryptography cffi && \
  25 | >>>     pip uninstall ansible-base && \
  26 | >>>     pip install ansible-core && \
  27 | >>>     pip install ansible==2.10 && \
  28 | >>>     pip install mitogen ansible-lint jmespath && \
  29 | >>>     pip install --upgrade pywinrm && \
  30 | >>>     apk del build-dependencies && \
  31 | >>>     rm -rf /var/cache/apk/* && \
  32 | >>>     rm -rf /root/.cache/pip && \
  33 | >>>     rm -rf /root/.cargo
  34 |
--------------------
ERROR: failed to solve: process "/bin/sh -c CARGO_NET_GIT_FETCH_WITH_CLI=1 &&     apk --no-cache add        
 sudo         python3        py3-pip         openssl         ca-certificates         sshpass        
 openssh-client         rsync         git &&     apk --no-cache add --virtual build-dependencies         
 python3-dev         libffi-dev         musl-dev         gcc         cargo         openssl-dev         libressl-dev 
 build-base &&     pip install --upgrade pip wheel &&     pip install --upgrade cryptography cffi &&     
 pip uninstall ansible-base &&     pip install ansible-core &&     pip install ansible==2.10 &&   
 pip install mitogen ansible-lint jmespath &&     pip install --upgrade pywinrm &&     apk del build-dependencies &&  
 rm -rf /var/cache/apk/* &&     rm -rf /root/.cache/pip &&     rm -rf /root/.cargo" did not complete successfully: exit code: 1
 



```