# Домашнее задание к занятию «Жизненный цикл ПО»

## Подготовка к выполнению
1. Используя docker скачал образ JIRA и установил ее локально 
2. Создал доски Kanban и Scrum:

![img_1.png](img/task1.png)

## Решение основной части

Создал статусы для доски Kanban:

![img_1.png](img/statuses.png)

Создаю два Workflows согласно заданию:

![img_1.png](img/wf_scemes.png)

Workflow для типов задач Bug:

![img_1.png](img/wf_bug.png)

Workflow для всех остальных типов задач:

![img_1.png](img/wf_other.png)

Создаю задачу с типом Bug:

![img_1.png](img/bug1.png)

Довел задачу до состояния Done:

![img_1.png](img/bug_done.png)
![img_1.png](img/bug_done_board.png)

Создал задачу с типом Epic и две задачи с типом Task, привязанные к Epic,
Довел задачи до состояния Done:

![img_1.png](img/task_openwasdone2.png)

Вернул задачи обратно в состояние Open:
![img_1.png](img/task_openwasdone2.png)


Перехожу в Scrum проект, создаю задачи с эпиком и планирую спринт:
![img_1.png](img/scrum task1.png)
![img_1.png](img/create sprint2.png)


Довожу задачи до состояния выполнения и закрываю спринт:
![img_1.png](img/sprintdone.png)




## Выгруженные схемы Workflow:

* [bug workflow](https://github.com/Elfxf85/devops-netology/blob/main/09-CI-01-intro/Workflows/Bug.xml)
* [other workflow](https://github.com/Elfxf85/devops-netology/blob/main/09-CI-01-intro/Workflows/Other.xml)