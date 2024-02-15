output "id" {
  description = "ID of the instance"
  value       = aws_instance.ec2_instance.id
}

output "arn" {
  description = "ARN of the instance"
  value       = aws_instance.ec2_instance.arn
}

output "key_name" {
  description = "Name of the SSH key pair provisioned on the instance"
  value       = var.key_name
}
