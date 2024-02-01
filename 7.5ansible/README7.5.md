# Домашнее задание к занятию 5 «Тестирование roles» 

## Подготовка к выполнению

1. Установите molecule: `pip3 install "molecule==3.5.2"` и драйвера `pip3 install molecule_docker molecule_podman`.
2. Выполните `docker pull aragast/netology:latest` —  это образ с podman, tox и несколькими пайтонами (3.7 и 3.9) внутри.

## Основная часть

Ваша цель — настроить тестирование ваших ролей. 

Задача — сделать сценарии тестирования для vector. 

Ожидаемый результат — все сценарии успешно проходят тестирование ролей.

### Molecule

1. Запустите  `molecule test -s centos_7` внутри корневой директории clickhouse-role, посмотрите на вывод команды. Данная команда может отработать с ошибками, это нормально. Наша цель - посмотреть как другие в реальном мире используют молекулу.
![img_1.png](img/task1.png)

2. Перейдите в каталог с ролью vector-role и создайте сценарий тестирования по умолчанию при помощи `molecule init scenario --driver-name docker`.
![img_2.png](img/task2.png)

3. Добавьте несколько разных дистрибутивов (oraclelinux:8, ubuntu:latest) для инстансов и протестируйте роль, исправьте найденные ошибки, если они есть.
```console
---
cat molecule/default/molecule.yml

dependency:
  name: galaxy
driver:
  name: docker
platforms:
  - name: ubuntu_latest
    image: docker.io/pycontribs/ubuntu:latest
    pre_build_image: true
  - name: oracle_linux
    image: docker.io/pycontribs/oraclelinux:8
    pre_build_image: true
provisioner:
  name: ansible
verifier:
  name: ansible

```
Запускаю тестирование:
![img_3.png](img/task3.png)

4. Добавьте несколько assert в verify.yml-файл для  проверки работоспособности vector-role (проверка, что конфиг валидный, проверка успешности запуска и др.).
здаем файл verify.yml
```console
- name: Verify
  hosts: all
  gather_facts: true
  tasks:
    - name: Include vector role
      include_role:
        name: vector
    - name: Check vector service
      assert:
        that: vector_pid.stdout != 0
        success_msg: "Service is running"
        fail_msg: "Service not running"
    - name: Check vector config
      assert:
        that: valid_config.rc == 0
        success_msg: "Config valid"
        fail_msg: "Config not valid"
```


5. Запустите тестирование роли повторно и проверьте, что оно прошло успешно.
Проверяем `molecule test`
![img_4.png](img/task4.png)

6. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.
https://github.com/Elfxf85/devops-netology/releases/tag/v1.0.11



## Tox

1. Добавьте в директорию с vector-role файлы из [директории](./example).
2. Запустите `docker run --privileged=True -v <path_to_repo>:/opt/vector-role -w /opt/vector-role -it aragast/netology:latest /bin/bash`, где path_to_repo — путь до корня репозитория с vector-role на вашей файловой системе.
```
docker run --privileged=True -v /home/elfxf/reposu/vector-role:/opt/vector-role -w /opt/vector-role -it aragast/netology:latest /bin/bash
```

3. Внутри контейнера выполните команду `tox`, посмотрите на вывод.
![img_5.png](img/task5.png)

5. Создайте облегчённый сценарий для `molecule` с драйвером `molecule_podman`. Проверьте его на исполнимость.
```
scenario:
  test_sequence:
  - destroy
  - create
  - converge
  - destroy
```

6. Пропишите правильную команду в `tox.ini`, чтобы запускался облегчённый сценарий.
```
commands =
    {posargs:molecule test -s podman --destroy always}
```

8. Запустите команду `tox`. Убедитесь, что всё отработало успешно.
```
elfxf@server1:~/reposu/vector-role$ docker run --privileged=True -v /home/elfxf/reposu/vector-role:/opt/vector-role -w /opt/vector-role -it aragast/netology:latest /bin/bash
[root@38351a26d949 vector-role]# tox
py37-ansible210 installed: ansible==2.10.7,ansible-base==2.10.17,ansible-compat==1.0.0,ansible-lint==5.1.3,arrow==1.2.3,bcrypt==4.1.2,binaryornot==0.4.4,bracex==2.3.post1,cached-property==1.5.2,Cerberus==1.3.5,certifi==2023.11.17,cffi==1.15.1,chardet==5.2.0,charset-normalizer==3.3.2,click==8.1.7,click-help-colors==0.9.4,cookiecutter==2.5.0,cryptography==42.0.2,distro==1.9.0,enrich==1.2.7,idna==3.6,importlib-metadata==6.7.0,Jinja2==3.1.3,jmespath==1.0.1,lxml==5.1.0,markdown-it-py==2.2.0,MarkupSafe==2.1.4,mdurl==0.1.2,molecule==3.5.2,molecule-podman==1.1.0,packaging==23.2,paramiko==2.12.0,pathspec==0.11.2,pluggy==1.2.0,pycparser==2.21,Pygments==2.17.2,PyNaCl==1.5.0,python-dateutil==2.8.2,python-slugify==8.0.3,PyYAML==5.4.1,requests==2.31.0,rich==13.7.0,ruamel.yaml==0.18.5,ruamel.yaml.clib==0.2.8,selinux==0.2.1,six==1.16.0,subprocess-tee==0.3.5,tenacity==8.2.3,text-unidecode==1.3,typing_extensions==4.7.1,urllib3==2.0.7,wcmatch==8.4.1,yamllint==1.26.3,zipp==3.15.0
py37-ansible210 run-test-pre: PYTHONHASHSEED='254402827'
py37-ansible210 run-test: commands[0] | molecule test -s podman --destroy always
CRITICAL 'molecule/podman/molecule.yml' glob failed.  Exiting.
ERROR: InvocationError for command /opt/vector-role/.tox/py37-ansible210/bin/molecule test -s podman --destroy always (exited with code 1)
py37-ansible30 create: /opt/vector-role/.tox/py37-ansible30
py37-ansible30 installdeps: -rtox-requirements.txt, ansible<3.1
```

9. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.

https://github.com/Elfxf85/devops-netology/releases/tag/v1.0.2

