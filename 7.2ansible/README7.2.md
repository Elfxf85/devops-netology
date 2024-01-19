# Домашнее задание к занятию 2 «Работа с Playbook»

## Основная часть

1. Подготовьте свой inventory-файл `prod.yml`.
2. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает [vector](https://vector.dev). Конфигурация vector должна деплоиться через template файл jinja2. От вас не требуется использовать все возможности шаблонизатора, просто вставьте стандартный конфиг в template файл. Информация по шаблонам по [ссылке](https://www.dmosk.ru/instruktions.php?object=ansible-nginx-install).
3. При создании tasks рекомендую использовать модули: `get_url`, `template`, `unarchive`, `file`.
4. Tasks должны: скачать дистрибутив нужной версии, выполнить распаковку в выбранную директорию, установить vector.
5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.
6. Попробуйте запустить playbook на этом окружении с флагом `--check`.
7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.
8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.
9. Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги. Пример качественной документации ansible playbook по [ссылке](https://github.com/opensearch-project/ansible-playbook).
10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-02-playbook` на фиксирующий коммит, в ответ предоставьте ссылку на него.

## Решение основной части



1. Подготовил свой inventory-файл `prod.yml`:

[task_1_1](img/task1.png)

Для установки Vector and Clickhouse буду использовать виртуальный сервер в Yandex Cloud, Centos7.

2. 3. 4. Дописал playbook для установки Vector используя модули `get_url`, `template`, `unarchive`, `file` , шаблоны jinja2.  Выполняется скачивание, разархивирование в указанную директорию, добавление конфигурации из файла шаблона и запуск Vector.
 
5.  Запустил `ansible-lint site.yml`, были ошибки в playbook отсутствовали права на скачиваемые и исполняемые файлы, проблемы с разметой yaml -  неправильные отступы в Playbook, ошибка синтаксиса, был исправлен порядок запуска сервиса Clickhouse.
Остался warning
console ```
WARNING  Overriding detected file kind 'yaml' with 'playbook' for given positional argument: site.yml
an AnsibleCollectionFinder has not been installed in this process
```

6. Запусил playbook с флагом --check. Флаг --check не вносит изменения в конечную систему. Выполнение плейбука не происходит, пакеты дистрибутивов не скачиваются,  в логе выполнения ошибки по отсутсвию пакетов.

```console
TASK [Get clickhouse distrib] ***********************************************************************************************************************************************************************************
task path: /root/source/playbook/site.yml:6
changed: [clickhouse-01] => (item=clickhouse-client) => {"ansible_loop_var": "item", "changed": true, "checksum_dest": null, "checksum_src": "da39a3ee5e6b4b0d3255bfef95601890afd80709", "dest": "/tmp/clickhouse-client-22.3.3.44.rpm", "elapsed": 0, "item": "clickhouse-client", "msg": "OK (38090 bytes)", "src": "/home/elfxf/.ansible/tmp/ansible-tmp-1705674284.3508377-7902-226674254914636/tmpBDqP1j", "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-client-22.3.3.44.noarch.rpm"}
changed: [clickhouse-01] => (item=clickhouse-server) => {"ansible_loop_var": "item", "changed": true, "checksum_dest": null, "checksum_src": "da39a3ee5e6b4b0d3255bfef95601890afd80709", "dest": "/tmp/clickhouse-server-22.3.3.44.rpm", "elapsed": 0, "item": "clickhouse-server", "msg": "OK (61151 bytes)", "src": "/home/elfxf/.ansible/tmp/ansible-tmp-1705674285.601851-7902-136238051313895/tmp2uTlXR", "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-server-22.3.3.44.noarch.rpm"}
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "/tmp/clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "item": "clickhouse-common-static", "msg": "Request failed", "response": "HTTP Error 404: Not Found", "status_code": 404, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib] ***********************************************************************************************************************************************************************************
task path: /root/source/playbook/site.yml:13
changed: [clickhouse-01] => {"changed": true, "checksum_dest": null, "checksum_src": "da39a3ee5e6b4b0d3255bfef95601890afd80709", "dest": "/tmp/clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "msg": "OK (246310036 bytes)", "src": "/home/elfxf/.ansible/tmp/ansible-tmp-1705674287.9068365-7925-163437947522067/tmp6MUamU", "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.x86_64.rpm"}

TASK [Install clickhouse packages] ******************************************************************************************************************************************************************************
task path: /root/source/playbook/site.yml:18
fatal: [clickhouse-01]: FAILED! => {"changed": false, "msg": "No RPM file matching '/tmp/clickhouse-common-static-22.3.3.44.rpm' found on system", "rc": 127, "results": ["No RPM file matching '/tmp/clickhouse-common-static-22.3.3.44.rpm' found on system"]}
...ignoring

TASK [Unarchive Vector package] *********************************************************************************************************************************************************************************
task path: /root/source/playbook/site.yml:66
fatal: [vector-01]: FAILED! => {"changed": false, "msg": "Source '/tmp/vector-0.33.0-x86_64-unknown-linux-gnu.tar.gz' does not exist"}

PLAY RECAP ******************************************************************************************************************************************************************************************************
clickhouse-01              : ok=4    changed=2    unreachable=0    failed=0    skipped=0    rescued=1    ignored=1
vector-01                  : ok=3    changed=1    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0
```

6. Запускаю playbook с флагом `--check`. Флаг `--check` не вносит изменения в конечную систему. Выполнение плейбука невозможно с этим флагом, т.к. нет скачанных файлов дистрибутива, а значит нечего устанавливать:

[task_1_6](img/task6.png)
[task_1_61](img/task61.png)


7. Запускаю playbook с флагом `--diff`. Флаг позволяет отслеживать изменения в файлах на удаленных хостах, чтобы можно было видеть, какие конкретные изменения будут внесены на хостах в результате выполнения плейбука.

[task_1_7](img/task7.png)
[task_1_71](img/task71.png)


8. Повторно запускаю playbook с флагом `--diff`,  playbook идемпотентен, за исключением части запуска Vector:

[task_1_8](img/task8.png)

9.  Подготовил README.md-файл по  playbook Ссылка на описание Playbook: https://github.com/Elfxf85/devops-netology/blob/main/7.2ansible/src/playbook/README.md


