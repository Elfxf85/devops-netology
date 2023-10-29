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
 
 sudo pip3 install ansible[azure]
 
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
elfxf@Valtorn:/usr/local/bin$ sudo apt-get update && sudo apt-get install vagrant
Hit:1 http://security.ubuntu.com/ubuntu jammy-security InRelease
Hit:2 https://apt.releases.hashicorp.com jammy InRelease
Hit:3 http://archive.ubuntu.com/ubuntu jammy InRelease
Hit:4 http://archive.ubuntu.com/ubuntu jammy-updates InRelease
Hit:5 https://ppa.launchpadcontent.net/ansible/ansible/ubuntu jammy InRelease
Hit:6 http://archive.ubuntu.com/ubuntu jammy-backports InRelease
Reading package lists... Done
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following NEW packages will be installed:
  vagrant
0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.
Need to get 0 B/150 MB of archives.
After this operation, 383 MB of additional disk space will be used.
Selecting previously unselected package vagrant.
(Reading database ... 76808 files and directories currently installed.)
Preparing to unpack .../vagrant_2.4.0-1_amd64.deb ...
Unpacking vagrant (2.4.0-1) ...
Setting up vagrant (2.4.0-1) ...
elfxf@Valtorn:/usr/local/bin$ vagrant -v
Vagrant 2.4.0
```
Terraform версии 1.5.Х
```console
elfxf@Valtorn:~$ terraform -v
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

```console
elfxf@server1:~/test/vagrant$ sudo vagrant up
Bringing machine 'server1.netology' up with 'virtualbox' provider...
==> server1.netology: Importing base box 'bento/ubuntu-20.04'...
==> server1.netology: Matching MAC address for NAT networking...
==> server1.netology: Checking if box 'bento/ubuntu-20.04' version '202309.09.0' is up to date...
==> server1.netology: Setting the name of the VM: server1.netology
==> server1.netology: Clearing any previously set network interfaces...
==> server1.netology: Preparing network interfaces based on configuration...
    server1.netology: Adapter 1: nat
    server1.netology: Adapter 2: hostonly
==> server1.netology: Forwarding ports...
    server1.netology: 22 (guest) => 20011 (host) (adapter 1)
    server1.netology: 22 (guest) => 2222 (host) (adapter 1)
==> server1.netology: Running 'pre-boot' VM customizations...
==> server1.netology: Booting VM...
==> server1.netology: Waiting for machine to boot. This may take a few minutes...
    server1.netology: SSH address: 127.0.0.1:2222
    server1.netology: SSH username: elfxf
    server1.netology: SSH auth method: private key
    server1.netology: Warning: Connection reset. Retrying...
    server1.netology: 
    server1.netology: Vagrant insecure key detected. Vagrant will automatically replace
    server1.netology: this with a newly generated keypair for better security.
    server1.netology: 
    server1.netology: Inserting generated public key within guest...
    server1.netology: Removing insecure key from the guest if it's present...
    server1.netology: Key inserted! Disconnecting and reconnecting using new SSH key...
==> server1.netology: Machine booted and ready!
==> server1.netology: Checking for guest additions in VM...
==> server1.netology: Setting hostname...
==> server1.netology: Configuring and enabling network interfaces...
==> server1.netology: Mounting shared folders...
    server1.netology: /vagrant => /home/elfxf/test/vagrant
==> server1.netology: Running provisioner: ansible...
    server1.netology: Running ansible-playbook...

PLAY [nodes] *******************************************************************

TASK [Gathering Facts] *********************************************************
ok: [server1.netology]

TASK [Create directory for ssh-keys] *******************************************
ok: [server1.netology]

TASK [Adding rsa-key in /root/.ssh/authorized_keys] ****************************
changed: [server1.netology]

TASK [Checking DNS] ************************************************************
changed: [server1.netology]

TASK [Installing tools] ********************************************************
ok: [server1.netology] => (item=git)
ok: [server1.netology] => (item=curl)

TASK [Installing docker] *******************************************************
changed: [server1.netology]

TASK [Add the current user to docker group] ************************************
changed: [server1.netology]

PLAY RECAP *********************************************************************
server1.netology           : ok=7    changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

elfxf@server1:~$ docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
elfxf@server1:~$ 

```