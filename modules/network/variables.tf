variable "region" {
  type        = string
  default     = "eu-west-1"
  description = "AWS Region"
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["eu-west-1a", "eu-west-1b"]
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/20"
  description = "CIDR for VPC"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDRs"
  default     = ["10.0.1.0/26", "10.0.1.64/26"]
}


variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private Subnet CIDRs"
  default     = ["10.0.1.128/26", "10.0.1.192/26"]
}
