
module "aws_key_pair" {
  source              = "cloudposse/key-pair/aws"
  version             = "0.20.0"
  name                = "aws-tf-example-key-pair"
  ssh_public_key_path = var.ssh_public_key_path
  generate_ssh_key    = true
}


module "network" {
  source               = "./modules/network"
  vpc_cidr             = var.vpc_cidr
  azs                  = var.azs
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}


module "compute_public" {
  source                      = "./modules/compute"
  vpc_subnet_id               = module.network.public_subnet_ids[0]
  private_ip                  = var.public_instance_private_ip
  instance_type               = var.public_instance_type
  instance_name               = var.public_instance_name
  key_name                    = module.aws_key_pair.key_name
  instance_security_group_id  = aws_security_group.public_instance_sg.id
  associate_public_ip_address = true

  depends_on = [module.network]

}

module "compute_private" {
  source                      = "./modules/compute"
  vpc_subnet_id               = module.network.private_subnet_ids[0]
  instance_type               = var.private_instance_type
  instance_name               = var.private_instance_name
  key_name                    = module.aws_key_pair.key_name
  instance_security_group_id  = aws_security_group.private_instance_sg.id
  associate_public_ip_address = false

  depends_on = [module.compute_public]
}
