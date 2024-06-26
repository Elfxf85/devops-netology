# Домашнее задание к занятию «Микросервисы: принципы»

Вы работаете в крупной компании, которая строит систему на основе микросервисной архитектуры.
Вам как DevOps-специалисту необходимо выдвинуть предложение по организации инфраструктуры для разработки и эксплуатации.

## Задача 1: API Gateway 

Предложите решение для обеспечения реализации API Gateway. Составьте сравнительную таблицу возможностей различных программных решений. На основе таблицы сделайте выбор решения.

Решение должно соответствовать следующим требованиям:
- маршрутизация запросов к нужному сервису на основе конфигурации,
- возможность проверки аутентификационной информации в запросах,
- обеспечение терминации HTTPS.

Обоснуйте свой выбор.

## Задача 2: Брокер сообщений

Составьте таблицу возможностей различных брокеров сообщений. На основе таблицы сделайте обоснованный выбор решения.

Решение должно соответствовать следующим требованиям:
- поддержка кластеризации для обеспечения надёжности,
- хранение сообщений на диске в процессе доставки,
- высокая скорость работы,
- поддержка различных форматов сообщений,
- разделение прав доступа к различным потокам сообщений,
- простота эксплуатации.

Обоснуйте свой выбор.

## Задача 3: API Gateway * (необязательная)

### Есть три сервиса:

**minio**
- хранит загруженные файлы в бакете images,
- S3 протокол,

**uploader**
- принимает файл, если картинка сжимает и загружает его в minio,
- POST /v1/upload,

**security**
- регистрация пользователя POST /v1/user,
- получение информации о пользователе GET /v1/user,
- логин пользователя POST /v1/token,
- проверка токена GET /v1/token/validation.

### Необходимо воспользоваться любым балансировщиком и сделать API Gateway:

**POST /v1/register**
1. Анонимный доступ.
2. Запрос направляется в сервис security POST /v1/user.

**POST /v1/token**
1. Анонимный доступ.
2. Запрос направляется в сервис security POST /v1/token.

**GET /v1/user**
1. Проверка токена. Токен ожидается в заголовке Authorization. Токен проверяется через вызов сервиса security GET /v1/token/validation/.
2. Запрос направляется в сервис security GET /v1/user.

**POST /v1/upload**
1. Проверка токена. Токен ожидается в заголовке Authorization. Токен проверяется через вызов сервиса security GET /v1/token/validation/.
2. Запрос направляется в сервис uploader POST /v1/upload.

**GET /v1/user/{image}**
1. Проверка токена. Токен ожидается в заголовке Authorization. Токен проверяется через вызов сервиса security GET /v1/token/validation/.
2. Запрос направляется в сервис minio GET /images/{image}.

### Ожидаемый результат

Результатом выполнения задачи должен быть docker compose файл, запустив который можно локально выполнить следующие команды с успешным результатом.
Предполагается, что для реализации API Gateway будет написан конфиг для NGinx или другого балансировщика нагрузки, который будет запущен как сервис через docker-compose и будет обеспечивать балансировку и проверку аутентификации входящих запросов.
Авторизация
curl -X POST -H 'Content-Type: application/json' -d '{"login":"bob", "password":"qwe123"}' http://localhost/token

**Загрузка файла**

curl -X POST -H 'Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJib2IifQ.hiMVLmssoTsy1MqbmIoviDeFPvo-nCd92d4UFiN2O2I' -H 'Content-Type: octet/stream' --data-binary @yourfilename.jpg http://localhost/upload

**Получение файла**
curl -X GET http://localhost/images/4e6df220-295e-4231-82bc-45e4b1484430.jpg

---

#### [Дополнительные материалы: как запускать, как тестировать, как проверить](https://github.com/netology-code/devkub-homeworks/tree/main/11-microservices-02-principles)

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---

## Решение 1: API Gateway

Поиск в интернете по API Gateway дал следующие продукты:

- Nginx

- Kong

- Tyk

- AWS API Gateway

- Azure Gateway

- Ambassador


 **Решение**         | **Маршрутизация запросов** | **Проверка аутентификации** | **Обеспечение терминации HTTPS** 
---------------------|----------------------------|-----------------------------|----------------------------------
 **Kong**            | Да                         | Да                          | Да                               
 **Nginx**           | Да                         | Да                          | Да                               
 **Tyk**             | Да                         | Да                          | Да                               
 **AWS API Gateway** | Да                         | Да                          | Да                               
 **Azure Gateway**   | Да                         | Да                          | Да                               
 **Ambassador**      | Да                         | Да                          | Да                               

На основе таблицы можно сделать вывод, что любой из представленных решений подойдет для реализации API Gateway.

Но выбор конечного решения будет зависеть от дополнительных факторов:

1. Производительность - некоторые решения способны обрабатывать больше запросов в секунду, чем другие. Например, Nginx будет самым производительным.

2. Масштабируемость - некоторые решения могут масштабироваться до большего количества сервисов и запросов, чем другие. Например, AWS API Gateway может масштабироваться до миллионов запросов в секунду и поддерживает широкий спектр протоколов и форматов данных.

3. Удобство использования - некоторые решения могут быть проще в установке, настройке и использовании, чем другие. Например, AWS API Gateway имеет простой и интуитивно понятный пользовательский интерфейс, который позволяет легко создавать и управлять API.

4. Стоимость - некоторые решения могут быть бесплатными, в то время как другие могут требовать платной подписки и платной технической поддержки. Например, AWS API Gateway является платным сервисом, но в нем есть и бесплатный уровень, в котором есть ограничения на количество запросов в месяц. В то же время Nginx является бесплатным и открытым программным обеспечением, а значит за его использование не придется платить.

Полагаю, что однозначного выбора сервиса для обеспечения реализации API Gateway быть не может. Нужно принимать решение исходя из размеров проекта.

Для небольших и средних проектов выбираем  Nginx, Kong, Tyk и Ambassador. А для крупных проектов выбираем AWS API Gateway и Azure Gateway, а также можно выбрать Nginx.

В общем случае я бы выбрал Nginx, т.к. это бесплатное решение, не сильно требовательное к ресурсам и с большим сообществом пользователей, либо Kong, т.к. он тоже имеет большое сообщество пользователей и хорошую документацию, а ещё он имеет бесплатную версию, подходящую под наши требования.

## Решение 2: Брокер сообщений

| Брокер сообщений | Кластеризация | Хранение сообщений | Скорость работы | Поддержка форматов сообщений | Разделение прав доступа | Простота эксплуатации |
|---|---|---|---|---|---|---|
| Apache Kafka | Да | Да | Высокая | JSON, Avro, Protobuf, Binary | Да | Средняя |
| RabbitMQ | Да | Да | Средняя | JSON, XML, AMQP, MQTT | Да | Высокая |
| ActiveMQ | Да | Да | Средняя | JSON, XML, SOAP, STOMP | Да | Средняя |
| Redis | Да | Нет | Высокая | JSON, Strings, Lists, Sets, Hashes | Нет | Высокая |
| Beanstalk | Нет | Нет | Средняя | JSON, Strings | Нет | Средняя |

**Обоснование:**

* **Apache Kafka** является лучшим выбором для приложений, которым требуется высокая скорость работы, кластеризация и хранение сообщений на диске. Kafka также поддерживает различные форматы сообщений и разделение прав доступа. Однако Kafka сложнее в эксплуатации, чем другие брокеры сообщений.
* **RabbitMQ** является хорошим выбором для приложений, которым требуется высокая надежность, кластеризация и поддержка различных форматов сообщений. RabbitMQ также прост в эксплуатации. Однако RabbitMQ не так быстр, как Kafka.
* **ActiveMQ** является также хорошим выбором для приложений, которым требуется высокая надежность, кластеризация и поддержка различных форматов сообщений. ActiveMQ также прост в эксплуатации. Однако ActiveMQ не так быстр, как Kafka и RabbitMQ.
* **Redis** является тоже хорошим выбором для приложений, которым требуется высокая скорость работы и простота эксплуатации. Redis также поддерживает различные форматы сообщений. Однако Redis не поддерживает хранение сообщений на диске по умолчанию и не предназначен для этих целей. Но все же можно включить функцию для хранения сообщений на диске, именуемую Персистентностью, только это приведет к снижения производительности Redis.
* **Beanstalk** является хорошим выбором для приложений, которым требуется высокая скорость работы и простота эксплуатации. Beanstalk также поддерживает различные форматы сообщений. Однако Beanstalk не поддерживает кластеризацию и хранение сообщений на диске.

Для приложений, которым требуется высокая скорость работы, кластеризация, хранение сообщений на диске и поддержка различных форматов сообщений, лучшим выбором является **Apache Kafka**. Для приложений, которым требуется высокая надежность, кластеризация и поддержка различных форматов сообщений, лучшим выбором является **RabbitMQ**. Для остальных приложений нужно выбирать между **Redis** и **Beanstalk**.