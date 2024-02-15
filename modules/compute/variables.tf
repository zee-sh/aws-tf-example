
variable "vpc_subnet_id" {
  type        = string
  description = "VPC Subnet ID to create the instance in"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "instance_name" {
  type        = string
  description = "EC2 instance name"
  default     = ""
}

variable "private_ip" {
  type        = string
  description = "Private IP to associate with the instance"
  default     = null
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address with the instance"
  type        = bool
}

variable "key_name" {
  description = "Key name of the Key Pair to use for the instance"
  type        = string
}

variable "instance_security_group_id" {
  type        = string
  description = "Security Group ID to attach to instance"
}
