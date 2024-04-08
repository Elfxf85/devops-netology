# Домашнее задание к занятию «Средство визуализации Grafana»

## Задание повышенной сложности

**При решении задания 1** не используйте директорию [help](./help) для сборки проекта. Самостоятельно разверните grafana, где в роли источника данных будет выступать prometheus, а сборщиком данных будет node-exporter:

- grafana;
- prometheus-server;
- prometheus node-exporter.

За дополнительными материалами можете обратиться в официальную документацию grafana и prometheus.

В решении к домашнему заданию также приведите все конфигурации, скрипты, манифесты, которые вы 
использовали в процессе решения задания.

**При решении задания 3** вы должны самостоятельно завести удобный для вас канал нотификации, например, Telegram или email, и отправить туда тестовые события.

В решении приведите скриншоты тестовых событий из каналов нотификаций.

## Обязательные задания

## Задание 1

1. Используя директорию [help](./help) внутри этого домашнего задания, запустите связку prometheus-grafana.
2. Зайдите в веб-интерфейс grafana, используя авторизационные данные, указанные в манифесте docker-compose.
3. Подключите поднятый вами prometheus, как источник данных.
4. Решение домашнего задания — скриншот веб-интерфейса grafana со списком подключенных Datasource.

## Задание 2

Изучите самостоятельно ресурсы:

1. [PromQL tutorial for beginners and humans](https://valyala.medium.com/promql-tutorial-for-beginners-9ab455142085).
2. [Understanding Machine CPU usage](https://www.robustperception.io/understanding-machine-cpu-usage).
3. [Introduction to PromQL, the Prometheus query language](https://grafana.com/blog/2020/02/04/introduction-to-promql-the-prometheus-query-language/).

Создайте Dashboard и в ней создайте Panels:

- утилизация CPU для nodeexporter (в процентах, 100-idle);
- CPULA 1/5/15;
- количество свободной оперативной памяти;
- количество места на файловой системе.

Для решения этого задания приведите promql-запросы для выдачи этих метрик, а также скриншот получившейся Dashboard.

## Задание 3

1. Создайте для каждой Dashboard подходящее правило alert — можно обратиться к первой лекции в блоке «Мониторинг».
2. В качестве решения задания приведите скриншот вашей итоговой Dashboard.

## Задание 4

1. Сохраните ваш Dashboard. Для этого перейдите в настройки Dashboard, выберите в боковом меню «JSON MODEL». Далее скопируйте отображаемое json-содержимое в отдельный файл и сохраните его.
2. В качестве решения задания приведите листинг этого файла.

--- ---

## Решение обязательного задания

## Решение 1

1. Используя docker-compose, развернул grafana, prometheus и node-exporter:

![Alt text](img/task1.png)

Все конфигурации, скрипты, манифесты, которые  использовались в процессе решения задания доступны по ссылке: https://github.com/Elfxf85/devops-netology/tree/main/10-03-grafana/src/grafana_prom

2. Зашел в web-интерфейс Grafana. По умолчанию логин и пароль admin/admin, но при первом входе предлагается изменить пароль:

![Alt text](img/task2.png)

3. Подключил Prometheus как источник данных.

4. Скриншот Data sources:

![Alt text](img/task3.png)

## Решение 2

Создал Dashboard c панелями:
- утилизация CPU для node-exporter (в процентах, 100-idle):
```text
100 - avg(irate(node_cpu_seconds_total{job="node-exporter", mode="idle"}[1m])) * 100
```
Скриншот:
![Alt text](img/task4.png)

- CPULA 1/5/15:
```text
avg(node_load1{job="node-exporter"})
avg(node_load5{job="node-exporter"})
avg(node_load15{job="node-exporter"})
```
Скриншот:
![Alt text](img/img_5.png)

- количество свободной оперативной памяти:
```text
node_memory_MemFree_bytes
```
Скриншот:
![Alt text](img/img_6.png)

- количество места на файловой системе:
```text
node_filesystem_avail_bytes
```
Скриншот:
![Alt text](img/img_7.png)

Общий скриншот Dashboard:

![Alt text](img/img_8.png)

## Решение 3

Для панелей созданного ранее Dashboard настроил алертинг. Алерты отправляются в Telegram канал.

Пример оповещения в Telegram канале:

![Alt text](img/img_9.png)

В итоге Dashboard выглядит следующим образом:

![Alt text](img/img_10.png)

## Решение 4

1. Сохранил Dashboard в json файл.

2. Ссылка на файл: https://github.com/Elfxf85/devops-netology/blob/main/10-03-grafana/src/dashboard/dashboard.json
---


## Дополнительное задание* (со звёздочкой) 
 не делал