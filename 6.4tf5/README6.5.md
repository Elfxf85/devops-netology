# Домашнее задание к занятию «Использование Terraform в команде»

### Задание 1

1. Возьмите код:
- из [ДЗ к лекции 4](https://github.com/netology-code/ter-homeworks/tree/main/04/src),
- из [демо к лекции 4](https://github.com/netology-code/ter-homeworks/tree/main/04/demonstration1).
2. Проверьте код с помощью tflint и checkov. Вам не нужно инициализировать этот проект.
3. Перечислите, какие **типы** ошибок обнаружены в проекте (без дублей).

### Решение 1

1-2. С помощью docker контейнера tflint проверяю первый код :
docker run --rm -v "$(pwd):/tflint" ghcr.io/terraform-linters/tflint:v0.46.0 /tflint

![task_1_1](img/task1_1.png)

С помощью checkov проверяю ошибки во втором коде:

docker pull bridgecrew/checkov
docker run --rm --tty --volume $(pwd):/tf --workdir /tf bridgecrew/checkov \
--download-external-modules true --directory /tf

![task_1_2](img/task1_2.png)

3. Обнаружены следующие ошибки:
- Не был инициализирован проект, соответственно нет установленного Terraform провайдера,
 -есть объявленные, но неиспользуемые переменные,
 
 - в модуле test-vm присутствует ссылка на ветку main без указания конкретного коммита. 
  Check: CKV_TF_1: "Ensure Terraform module sources use a commit hash"
        FAILED for resource: test-vm
что делает код уязвимым для атаки по цепочке сборок. Поэтому рекомендуется использовать URL-адреса Git с хеш-версией фиксации, чтобы гарантировать неизменность и согласованность.  


### Задание 2

1. Возьмите ваш GitHub-репозиторий с **выполненным ДЗ 4** в ветке 'terraform-04' и сделайте из него ветку 'terraform-05'.
2. Повторите демонстрацию лекции: настройте YDB, S3 bucket, yandex service account, права доступа и мигрируйте state проекта в S3 с блокировками. Предоставьте скриншоты процесса в качестве ответа.
3. Закоммитьте в ветку 'terraform-05' все изменения.
4. Откройте в проекте terraform console, а в другом окне из этой же директории попробуйте запустить terraform apply.
5. Пришлите ответ об ошибке доступа к state.
6. Принудительно разблокируйте state. Пришлите команду и вывод.

### Решение 2

1. Сделал копию репозитория прошлого ДЗ.
2. Создал S3 bucket, yandex service account, назначил права доступа, YDB:
![task_2_1](img/task2_1.png)
![task_2_2](img/task2_2.png)
![task_2_3](img/task2_3.png)
![task_2_5](img/task2_5.png)
![task_2_6](img/task2_6.png)

3. Закоммитил изменения в ветку terraform-05. [Ссылка](https://github.com/Elfxf85/devops-netology/tree/terraform-05/6.4tf5/src).

4. Открываю terraform console, а в другом окне из этой же директории запускаю terraform apply.

5. Ответ об ошибке доступа к state:
![task_2_7](img/task2_7.png)

6. Принудительно разблокирую state:
![task_2_8](img/task2_8.png)

### Задание 3

1. Сделайте в GitHub из ветки 'terraform-05' новую ветку 'terraform-hotfix'.
2. Проверьте код с помощью tflint и checkov, исправьте все предупреждения и ошибки в 'terraform-hotfix', сделайте коммит.
3. Откройте новый pull request 'terraform-hotfix' --> 'terraform-05'. 
4. Вставьте в комментарий PR результат анализа tflint и checkov, план изменений инфраструктуры из вывода команды terraform plan.
5. Пришлите ссылку на PR для ревью. Вливать код в 'terraform-05' не нужно.

### Решение 3

1. В GitHub из ветки 'terraform-05' создал новую ветку 'terraform-hotfix'.

2. Проверил код с помощью tflint и checkov, исправил все предупреждения и ошибки в 'terraform-hotfix', сделал коммит:

3. Создал новый pull request 'terraform-hotfix' --> 'terraform-05'.

4. Добавил в него комментарий с результатом работы tflint и checkov.

5. Ссылка на PR для ревью:

https://github.com/Elfxf85/devops-netology/pull/1/files

------