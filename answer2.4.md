Инструкция к заданию
Склонируйте репозиторий с исходным кодом Terraform.  ( git clone https://github.com/hashicorp/terraform)
Создайте файл для ответов на задания в своём репозитории, после выполнения прикрепите ссылку на .md-файл с ответами в личном кабинете.
Любые вопросы по решению задач задавайте в чате учебной группы.


В клонированном репозитории:

1. Найдите полный хеш и комментарий коммита, хеш которого начинается на aefea.  (git show aefea)

commit aefead2207ef7e2aa5dc81a34aedf0cad4c32545
Author: Alisdair McDiarmid <alisdair@users.noreply.github.com>
Date:   Thu Jun 18 10:29:58 2020 -0400
    Update CHANGELOG.md
diff --git a/CHANGELOG.md b/CHANGELOG.md
index 86d70e3e0d..588d807b17 100644
--- a/CHANGELOG.md
+++ b/CHANGELOG.md
@@ -27,6 +27,7 @@ BUG FIXES:
 * backend/s3: Prefer AWS shared configuration over EC2 metadata credentials by default ([#25134](https://github.com/hashicorp/terraform/issues/25134))
 * backend/s3: Prefer ECS credentials over EC2 metadata credentials by default ([#25134](https://github.com/hashicorp/terraform/issues/25134))
 * backend/s3: Remove hardcoded AWS Provider messaging ([#25134](https://github.com/hashicorp/terraform/issues/25134))
+* command: Fix bug with global `-v`/`-version`/`--version` flags introduced in 0.13.0beta2 [GH-25277]
 * command/0.13upgrade: Fix `0.13upgrade` usage help text to include options ([#25127](https://github.com/hashicorp/terraform/issues/25127))
 * command/0.13upgrade: Do not add source for builtin provider ([#25215](https://github.com/hashicorp/terraform/issues/25215))
 * command/apply: Fix bug which caused Terraform to silently exit on Windows when using absolute plan path ([#25233](https://github.com/hashicorp/terraform/issues/25233))


Ответьте на вопросы.
2.Какому тегу соответствует коммит 85024d3? (git describe --exact-match 85024d3100126de36331c6982bfaac02cdab9e76)
v0.12.23

3.Сколько родителей у коммита b8d720? Напишите их хеши. git rev-list --parents -1 b8d720
3 Родителя
b8d720f8340221f2146e4e4870bf2ee0bc48f2d5 
56cd7859e05c36c06b56d013b55a252d0bb7e158 
9ea88f22fc6269854151c571162c5bcf958bee2b

4.Перечислите хеши и комментарии всех коммитов, которые были сделаны между тегами v0.12.23 и v0.12.24. (git log --oneline "v0.12.23^"..."v0.12.24")

b14b74c493 [Website] vmc provider links
3f235065b9 Update CHANGELOG.md
6ae64e247b registry: Fix panic when server is unreachable
5c619ca1ba website: Remove links to the getting started guide's old location
06275647e2 Update CHANGELOG.md
d5f9411f51 command: Fix bug when using terraform login on Windows
4b6d06cc5d Update CHANGELOG.md
dd01a35078 Update CHANGELOG.md
225466bc3e Cleanup after v0.12.23 release


5.Найдите коммит, в котором была создана функция func providerSource, её определение в коде выглядит так: func providerSource(...) (вместо троеточия перечислены аргументы).
-git grep --name-only "func providerSource("
  нашли фаил с функцией  - provider_source.go 
-ищем коммиты с этим фаилом
 git log -L :providerSource:provider_source.go 
 самый первый коммит с этим файлом и будет коммит создания фнкции 

8c928e83589d90a031f811fae52a81be7153e82f


6.Найдите все коммиты, в которых была изменена функция globalPluginDirs.
- ищем фаил с этой функцией
  git grep --name-only "func globalPluginDirs("
  plugins.go
- ищем коммиты с этим файлом git log -q -L :globalPluginDirs:plugins.go


78b12205587fe839f10d946ea3fdc06719decb05
52dbf94834cb970b510f2fba853a5b49ad9b1a46
41ab0aef7a0fe030e84018973a64135b11abcd70
66ebff90cdfaa6938f26f908c7ebad8d547fea17
8364383c359a6b738a436d1b7745ccdce178df47


7. Кто автор функции synchronizedWriters?  (git log -S"func synchronizedWriters(")

Функция была удалена из репозитория  - James Bardin

а была создана - 
Author: Martin Atkins <mart@degeneration.co.uk>
Date:   Wed May 3 16:25:41 2017 -0700

