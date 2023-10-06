# devops-netology
devops-netology


В созданной gfgrt terraform  будут игнорироваться
Папки  вида  .terraform/ будут игнорироваться с содержимым
**/.terraform/*

Будут игнорироваться для коммита в репозитории следующие фаилы 
# .tfstate files
*.tfstate   - имеющие расширение
*.tfstate.*   - имеющие вид такои и любое расширение
# Crash log files
crash.log
crash.*.log

*.tfvars
*.tfvars.json    - jnon такого вида

а так же такие файлы 
override.tf
override.tf.json
*_override.tf
*_override.tf.json
.terraformrc 
terraform.rc

#---- New line
#test line 2