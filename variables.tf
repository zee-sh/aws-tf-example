variable "region" {
  type        = string
  default     = "eu-west-1"
  description = "AWS Region"
}

variable "azs" {
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b"]
  description = "List of AZs"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "CIDRs for Public Subnets"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "CIDRs for Private Subnets"
}

variable "public_instance_type" {
  type        = string
  description = "Public EC2 Instance Type"
}

variable "private_instance_type" {
  type        = string
  description = "Private EC2 Instance Type"
}

variable "public_instance_name" {
  type        = string
  description = "Public EC2 Instance Name"
}

variable "private_instance_name" {
  type        = string
  description = "Private EC2 Instance Name"
}

variable "ssh_public_key_path" {
  type        = string
  description = "Path to SSH public key directory"
}

variable "public_instance_private_ip" {
  type        = string
  description = "Private IP for the Public Instance"
}

variable "ip_to_access_public_instance" {
  type        = string
  description = "Whitelisted IP for accessing public instance"
}

variable "tags" {
  type        = map(string)
  description = "Add Default Tags for All Resources"
  default = {
    ManagedBy = "OpenTofu"
  }
}
