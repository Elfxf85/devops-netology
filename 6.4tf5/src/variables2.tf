variable "ipaddress" {
  description = "ip address"
  type        = string
  default = "192.168.0.1"
  validation {
    condition     = can(regex("^((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\\.){3}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])$", var.ipaddress))
    error_message = "Incorrect IP address"
  }
}

variable "ipaddress_list" {
  description = "ip address list"
  type        = list(string)
  default     = ["192.168.0.1", "1.1.1.1", "127.0.0.1"]
  validation {
    condition = alltrue([for i in var.ipaddress_list: can(regex("^((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\\.){3}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])$", i))])
    error_message = "Incorrect ip address list"
  }
}