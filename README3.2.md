Задача 1
Опишите основные преимущества применения на практике IaaC-паттернов.
Какой из принципов IaaC является основополагающим?

Ответ:

IaaC позволяет существенно сократить по времени цикл разработки ПО ускоряя процессы тестирования
 за счёт автоматизации разворачивания тестовых сред и доставки туда новых версий . Например, разработчики 
 устанавливают очередное обновление в систему контроля версий, которая самостоятельно подготавливает сборку для тестирования.
 Средствами IaaC могут автоматически создаваться тестовые среды в необходимом количестве (допустим для разных операционных систем) и заливаться туда нужные сборки. После выполнения тестирования среды могут уничтожаться. Аналогично, после тестирования при слиянии веток в основную (**master**) гипотетически может осуществляться автоматическое разворачиваение новой версии (**Continuous Deployment**). Подход "инфраструктура как код" также может существенно упростить масштабирование имеющейся инфраструктуры, например, 
 напрмиер: используюя скрипт автоматически создать дополнительные сервера с нужными ресурсами и развёрнутом в них нужные пакеты ПО.

Основополгающий принцип IaaC- "идемпотентность", благодаря которому при неизменности входных данных (набора команд,
 скриптов) гарантируется неизменность выходных (результата выполнения набора команд, скриптов). То есть при многократной
 выполнении одного и того же кода результат его выполнения не меняется.

---

Задача 2
Чем Ansible выгодно отличается от других систем управление конфигурациями?
Какой, на ваш взгляд, метод работы систем конфигурации более надёжный — push или pull?

Ответ:
Основное преимущество 'Ansible' - независимость от интеграционных компонентов и  агентless архитектура: Ansible не требует установки агентов на управляемые узлы.
Для работы Ansible достаточно существующей в управляемой среде SSH инфраструктуры, когда для других аналогичных программы 
 требуется предварительная установка в управляемую среду своих агентов\ модулей.

Метод push,
 когда центральный сервер инициирует и отправляет изменения конфигурации на узлы, может быть надежным, 
если правильно настроен и защищен.  Он позволяет быстро внедрять изменения и контролировать процесс обновления конфигурации.

Метод pull,
 когда узлы самостоятельно скачивают и применяют измененную конфигурацию, также имеет свои преимущества.
 Он может быть более надежным в случае, когда узел не всегда доступен или связь с центральным сервером ограничена.

Более надёжным способом работы кажется "push", так как при данной схеме имеется только один источник изменений - 
главный сервер, который может помимо отправки изменений на управляемые среды вести учёт обновлений (кто получил обновление,
 а кто по каким-то причинал нет). При работе по схеме "pull" инициатором изменений являются сами управляемые среды, которые
 могут потерять связь с главным сервером и  остаться без обновлений, а при восстановлении связи
 попытаться получить последние изменения без предыдущих, что может привести к проблемам с установкой обновлениий. 
 Так же  при этом нет централизованой информации   о статусе обновлений как может быть в случае "push".
 
 
 
##  задача 3

Установить на личный компьютер:


VirtualBox,
Vagrant,
Terraform версии 1.5.Х (1.6.х может вызывать проблемы с яндекс-облаком),
Ansible.
Приложите вывод команд установленных версий каждой из программ.
 
Ответ:
VirtualBox
```console
-- 
root@server1:~# apt install virtualbox
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
  cpp-12 dctrl-tools dkms gcc-12 libasan8 libdouble-conversion3 libgcc-12-dev libgsoap-2.8.117 liblzf1 libmd4c0
  libpcre2-16-0 libqt5core5a libqt5dbus5 libqt5gui5 libqt5network5 libqt5opengl5 libqt5printsupport5 libqt5svg5
  libqt5widgets5 libqt5x11extras5 libsdl1.2debian libtsan2 libxcb-xinerama0 libxcb-xinput0 qt5-gtk-platformtheme
  qttranslations5-l10n virtualbox-dkms virtualbox-qt
Suggested packages:
  gcc-12-locales cpp-12-doc debtags menu gcc-12-multilib gcc-12-doc qt5-image-formats-plugins qtwayland5 vde2
  virtualbox-guest-additions-iso
The following NEW packages will be installed:
  cpp-12 dctrl-tools dkms gcc-12 libasan8 libdouble-conversion3 libgcc-12-dev libgsoap-2.8.117 liblzf1 libmd4c0
  libpcre2-16-0 libqt5core5a libqt5dbus5 libqt5gui5 libqt5network5 libqt5opengl5 libqt5printsupport5 libqt5svg5
  libqt5widgets5 libqt5x11extras5 libsdl1.2debian libtsan2 libxcb-xinerama0 libxcb-xinput0 qt5-gtk-platformtheme
  qttranslations5-l10n virtualbox virtualbox-dkms virtualbox-qt
  ........
root@server1:~# vboxmanage -v
6.1.38_Ubuntur153438

```

Vagrant
```console
-- 
.........
Processing triggers for install-info (6.8-4build1) ...
Processing triggers for fontconfig (2.13.1-4.2ubuntu5) ...
Processing triggers for initramfs-tools (0.140ubuntu13.4) ...
update-initramfs: Generating /boot/initrd.img-6.2.0-35-generic
Processing triggers for hicolor-icon-theme (0.17-2) ...
Processing triggers for libc-bin (2.35-0ubuntu3.4) ...
Processing triggers for man-db (2.10.2-1) ...
Processing triggers for dbus (1.12.20-2ubuntu4.1) ...
root@server1:~# vagrant -v
Vagrant 2.2.19

```
Terraform версии 1.5.Х
```console
-- 
root@server1:/usr/local/bin# terraform -version
Terraform v1.5.7
on linux_amd64

Your version of Terraform is out of date! The latest version
is 1.6.2. You can update by downloading from https://www.terraform.io/downloads.html

```

Ansible
```console
-- 
elfxf@server1:~$ ansible --version
ansible 2.10.8
  config file = None
  configured module search path = ['/home/elfxf/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  executable location = /usr/bin/ansible
  python version = 3.10.12 (main, Jun 11 2023, 05:26:28) [GCC 11.4.0]

```


##  задача 4


Воспроизвести практическую часть лекции самостоятельно.

- Создать виртуальную машину.
- Зайти внутрь ВМ, убедиться, что Docker установлен с помощью команды `docker ps`



Ответ:
Unubtu desktop last version.
installed:
 
VirtualBox,
Vagrant,
Terraform версии 1.5.Х (
Ansible.


Bringing machine 'server1.netology' up with 'virtualbox' provider...
==> server1.netology: Checking if box 'bento/ubuntu-20.04' version '202309.09.0' is up to date...
==> server1.netology: Clearing any previously set forwarded ports...
==> server1.netology: Clearing any previously set network interfaces...
==> server1.netology: Preparing network interfaces based on configuration...
    server1.netology: Adapter 1: nat
    server1.netology: Adapter 2: hostonly
==> server1.netology: Forwarding ports...
    server1.netology: 22 (guest) => 20011 (host) (adapter 1)
    server1.netology: 22 (guest) => 2222 (host) (adapter 1)
==> server1.netology: Running 'pre-boot' VM customizations...
==> server1.netology: Booting VM...
There was an error while executing `VBoxManage`, a CLI used by Vagrant
for controlling VirtualBox. The command and stderr is shown below.

Command: ["startvm", "4bfc8f0a-c1af-40b8-bb08-af530e90fd4f", "--type", "headless"]

Stderr: VBoxManage: error: AMD-V is not available (VERR_SVM_NO_SVM)
VBoxManage: error: Details: code NS_ERROR_FAILURE (0x80004005), component ConsoleWrap, interface IConsole

root@server1:~# vboxmanage list vms
"server1.netology" {4bfc8f0a-c1af-40b8-bb08-af530e90fd4f}




https://www.comss.ru/page.php?id=7726 - не помогла