
### Cloud vars

variable "token" {
  description = "Yandex Cloud OAuth token"
  type        = string
}

variable "cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Yandex Cloud Folder ID"
  type        = string
}

variable "default_zone" {
  description = "Default zone for Yandex Cloud resources"
  type        = string
}

### Variables for VPC

variable "VPC_name" {
  type        = string
  default     = "my-vpc"
}

### Variables for Public subnet

variable "public_subnet_name" {
  type        = string
  default     = "public"
}

variable "public_v4_cidr_blocks" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
}

variable "subnet_zone" {
  type        = string
  default     = "ru-central1"
}

variable "public_subnet_zones" {
  type    = list(string)
  default = ["ru-central1-a", "ru-central1-b",  "ru-central1-d"]
}


### Variables for Private subnet

variable "private_subnet_name" {
  type        = string
  default     = "private"
}

variable "private_v4_cidr_blocks" {
  type        = list(string)
  default     = ["192.168.20.0/24"]
}

variable "private_subnet_zones" {
  type    = list(string)
  default = ["ru-central1-a", "ru-central1-b"]
}


#### Variables for MySQL cluster

variable "cluster_name" {
  type      = string
  default   = "my-cluster"
}

variable "cluster_env" {
  type = string
  description = "Environment type: PRODUCTION or PRESTABLE"
  default     = "PRESTABLE"
}

variable "deletion_protection" {
  type        = bool
  default     = "false"
}

variable "resource_preset_id" {
  type        = string
  default     = "b1.medium"
}

variable "disk_type" {
  type        = string
  default     = "network-ssd"
}

variable "disk_size" {
  type        = number
  default     = 20
}

variable "version_mysql" {
  type                      = string
  default                   = "8.0"
}

variable "ha" {
  type                      = bool
  description               = "If this is a multiple instance deployment, choose `true` to deploy 2 instances"
  default                   = true
}

variable "hours" {
  type                     = number
  default                  = 23
}

variable "minutes" {
  type                    = number
  default                 = 59
}


### variables for database

variable "database_name" {
  type        = string
  default     = "netology_db"
}

variable "size" {
  type        = number
  default     = 2
}

variable "group_count" {
  type        = number
  default     = 1
}

variable "storage_type_id" {
  type        = string
  description = "ssd or hdd"
  default     = "hdd"
}

variable "user_name" {
  type        = string
  default     = "elfxf"
}


variable "user_password" {
  type        = string
  sensitive   = true
  default     = "12345elfxf"
}

variable "user_roles" {
  type        = list(string)
  default     = ["ALL"]
}

### variables for k8s cluster

variable "k8s_service_account_name" {
  type        = string
  default     = "elfxf"
}

variable "k8s_cluster_name" {
  type        = string
  default     = "k8s-cluster"
}

variable "region" {
  type        = string
  default     = "ru-central1"
}




### Variables for KMS

variable "kms_key_name"  {
  type        = string
  default     = "kms-key"
}

variable "kms_key_description" {
  type        = string
  default     = "symmetric key for object storage"
}

variable "default_algorithm" {
  type        = string
  default     = "AES_128"
}

variable "prevent_destroy" {
  type        = bool
  default     = true
}


### Variables for NAT instance

variable "nat_name" {
  type        = string
  default     = "nat-instance"
}

variable "nat_cores" {
  type        = number
  default     = 2
}

variable "nat_memory" {
  type        = number
  default     = 2
}

variable "nat_disk_image_id" {
  type        = string
  default     = "fd80mrhj8fl2oe87o4e1"
}

variable "nat" {
  type        = bool
  default     = true
}

variable "nat_primary_v4_address" {
  type        = string
  default     = "192.168.10.3"
}


### Variables for public_vm

variable "public_vm_name" {
  type        = string
  default     = "public-vm"
}

variable "public_vm_platform" {
  type        = string
  default     = "standard-v1"
}

variable "public_vm_core" { 
  type        = number
  default     = "4"
}

variable "public_vm_memory" {
  type        = number
  default     = "8"
}

variable "public_vm_core_fraction" {
  description = "guaranteed vCPU, for yandex cloud - 20, 50 or 100 "
  type        = number
  default     = "20"
}

variable "public_vm_disk_size" {
  type        = number
  default     = "50"
}

variable "public_vm_image_id" {
  type        = string
  default     = "fd893ak78u3rh37q3ekn"
}

variable "scheduling_policy" {
  type        = bool
  default     = "true"
}

