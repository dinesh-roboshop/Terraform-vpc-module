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
variable "common_tags" {
  type        = map
  default     = {
   env = "dev"
   terraform = "true"
   project = "roboshop"  
  
  }
}