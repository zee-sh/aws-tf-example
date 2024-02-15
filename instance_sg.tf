
resource "aws_security_group" "public_instance_sg" {
  name        = "public-instance-sg"
  description = "Allow SSH access from a single specified IP only "
  vpc_id      = module.network.vpc_id

  ingress {
    description = "SSH ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.ip_to_access_public_instance}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "private_instance_sg" {
  name        = "private-instance-sg"
  description = "Allow SSH access only from EC2 Instance in Public Subnet "
  vpc_id      = module.network.vpc_id

  ingress {
    description = "SSH ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.public_instance_private_ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
