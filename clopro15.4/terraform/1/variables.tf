
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

variable "subnet_name" {
  type        = string
  default     = "public"
}

variable "v4_cidr_blocks" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
}

variable "subnet_zone" {
  type        = string
  default     = "ru-central1-a"
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

variable "nat" {
  type        = bool
  default     = true
}

variable "nat_primary_v4_address" {
  type        = string
  default     = "192.168.10.254"
}

