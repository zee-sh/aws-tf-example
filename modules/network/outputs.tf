output "vpc_id" {
  value       = aws_vpc.workload_vpc.id
  description = "ID of the VPC"
}

output "vpc_arn" {
  value       = aws_vpc.workload_vpc.arn
  description = "ARN of the VPC"
}

output "vpc_cidr_block" {
  value       = aws_vpc.workload_vpc.cidr_block
  description = "Primary IPv4 CIDR block of the VPC"
}

output "public_subnet_ids" {
  description = "IDs of the created public subnets"
  value       = aws_subnet.public[*].id
}

output "public_subnet_arns" {
  description = "ARNs of the created public subnets"
  value       = aws_subnet.public[*].arn
}

output "private_subnet_ids" {
  description = "IDs of the created private subnets"
  value       = aws_subnet.private[*].id
}

output "private_subnet_arns" {
  description = "ARNs of the created private subnets"
  value       = aws_subnet.private[*].arn
}
