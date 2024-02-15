

# EC2 instances
resource "aws_instance" "ec2_instance" {
  ami                         = data.aws_ami.amazon_linux.id
  key_name                    = var.key_name
  subnet_id                   = var.vpc_subnet_id
  instance_type               = var.instance_type
  private_ip                  = var.private_ip
  associate_public_ip_address = var.associate_public_ip_address

  vpc_security_group_ids = [var.instance_security_group_id]

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  root_block_device {
    encrypted = true
  }

  tags = {
    Name = var.instance_name
  }
}
