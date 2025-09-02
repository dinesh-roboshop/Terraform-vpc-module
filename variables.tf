variable "cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
}
variable "enable_dns_hostnames" {
  type        = bool
  default     = "true"
}
variable "project_name" {
  type        = string
}
variable "environment" {
  type        = string
}

variable "vpc_tags" {
  type        = map 
  default = {
    resource = "vpc"
  }
}

variable "igw_tags" {
  type        = map 
  default = {
    resource = "igw"
  }
}
variable "common_tags" {
  type        = map
  default     = {
   env = "dev"
   terraform = "true"
   project = "roboshop"  
  
  }
}

variable "public_subnet_cidr" {
  type        = list 
  validation {
    condition = length(var.public_subnet_cidr) == 2
    error_message = "Please input only 2 public subnet CIDRs"

  }
}

variable "public_subnet_tags" {
  default     = {}
}

variable "private_subnet_cidr" {
  type        = list 
  validation {
    condition = length(var.private_subnet_cidr) == 2
    error_message = "Please input only 2 private subnet CIDRs"

  }
}

variable "private_subnet_tags" {
  default     = {}
}

variable "database_subnet_cidr" {
  type        = list 
  validation {
    condition = length(var.database_subnet_cidr) == 2
    error_message = "Please input only 2 database subnet CIDRs"

  }
}

variable "database_subnet_tags" {
  default     = {}
}

variable "natgw_tags" {
  default     = {}
}
variable "database_rt_tags" {
 default = {}
}

variable "private_rt_tags" {
 default = {}
}

variable "public_rt_tags" {
 default = {}
}
