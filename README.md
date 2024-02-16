# aws-tf-example
This repository contains terraform code to deploy an AWS Environment with the following details

- VPC with one or more AZs
- Each AZ with one or more private and public subnets
- Each AZ with its own NAT Gateway
- A Public Instance that can only be accessed (ssh) via an IP specified in the variables
- A Private Instance that can only be accessed (ssh) via the Public Instance
- The Public Instance works as a bastion host and ssh-agent forwarding can be used to access the Private instance through it - https://repost.aws/knowledge-center/ec2-linux-private-subnet-bastion-host
- Both the Public and Private instance (via Nat Gateway) have access to the Internet

### Instructions
Example variables provided in terraform-tfvars-example will create VPC in EU-West-1 (Ireland) region with two AZs with each AZ having a private and public subnet and redundant NAT Gateways. A public instance and a private instance with internet access. Public Instance can only be accessed via SSH from a single IP specified. Private Instance can only be accessed via SSH from Public Instance

Clone the repo

```sh
git clone git@github.com:zee-sh/aws-tf-example.git
cd aws-tf-example
cp terraform-tfvars-example terraform.tfvars
```

Update the variable "ip_to_access_public_instance" in terraform.tfvars to the IP that will be whitelisted for SSH access to Public Instance and then use opentofu to build the environment. If required also update variable "ssh_public_key_path" to the path you want to use to store the ssh key file 

```sh
tofu init
tofu plan
tofu apply
```

Once the environment is ready, find the IP of EC2 Public Instance using AWS Console or CLI and SSH to it using the ssh key that was generated and stored in the path specified above

```sh
ssh -i "aws-tf-example-key-pair" ec2-user@PUBLIC_IP_OF_EC2_PUBLIC_INSTANCE
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.32.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.35.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_key_pair"></a> [aws\_key\_pair](#module\_aws\_key\_pair) | cloudposse/key-pair/aws | 0.20.0 |
| <a name="module_compute_private"></a> [compute\_private](#module\_compute\_private) | ./modules/compute | n/a |
| <a name="module_compute_public"></a> [compute\_public](#module\_compute\_public) | ./modules/compute | n/a |
| <a name="module_network"></a> [network](#module\_network) | ./modules/network | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_security_group.private_instance_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.public_instance_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azs"></a> [azs](#input\_azs) | List of AZs | `list(string)` | <pre>[<br>  "eu-west-1a",<br>  "eu-west-1b"<br>]</pre> | no |
| <a name="input_ip_to_access_public_instance"></a> [ip\_to\_access\_public\_instance](#input\_ip\_to\_access\_public\_instance) | Whitelisted IP for accessing public instance | `string` | n/a | yes |
| <a name="input_private_instance_name"></a> [private\_instance\_name](#input\_private\_instance\_name) | Private EC2 Instance Name | `string` | n/a | yes |
| <a name="input_private_instance_type"></a> [private\_instance\_type](#input\_private\_instance\_type) | Private EC2 Instance Type | `string` | n/a | yes |
| <a name="input_private_subnet_cidrs"></a> [private\_subnet\_cidrs](#input\_private\_subnet\_cidrs) | CIDRs for Private Subnets | `list(string)` | n/a | yes |
| <a name="input_public_instance_name"></a> [public\_instance\_name](#input\_public\_instance\_name) | Public EC2 Instance Name | `string` | n/a | yes |
| <a name="input_public_instance_private_ip"></a> [public\_instance\_private\_ip](#input\_public\_instance\_private\_ip) | Private IP for the Public Instance | `string` | n/a | yes |
| <a name="input_public_instance_type"></a> [public\_instance\_type](#input\_public\_instance\_type) | Public EC2 Instance Type | `string` | n/a | yes |
| <a name="input_public_subnet_cidrs"></a> [public\_subnet\_cidrs](#input\_public\_subnet\_cidrs) | CIDRs for Public Subnets | `list(string)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | `"eu-west-1"` | no |
| <a name="input_ssh_public_key_path"></a> [ssh\_public\_key\_path](#input\_ssh\_public\_key\_path) | Path to SSH public key directory | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Add Default Tags for All Resources | `map(string)` | <pre>{<br>  "ManagedBy": "OpenTofu"<br>}</pre> | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | VPC CIDR | `string` | n/a | yes |

## Outputs

No outputs.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.32.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.35.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_key_pair"></a> [aws\_key\_pair](#module\_aws\_key\_pair) | cloudposse/key-pair/aws | 0.20.0 |
| <a name="module_compute_private"></a> [compute\_private](#module\_compute\_private) | ./modules/compute | n/a |
| <a name="module_compute_public"></a> [compute\_public](#module\_compute\_public) | ./modules/compute | n/a |
| <a name="module_network"></a> [network](#module\_network) | ./modules/network | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_security_group.private_instance_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.public_instance_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azs"></a> [azs](#input\_azs) | List of AZs | `list(string)` | <pre>[<br>  "eu-west-1a",<br>  "eu-west-1b"<br>]</pre> | no |
| <a name="input_ip_to_access_public_instance"></a> [ip\_to\_access\_public\_instance](#input\_ip\_to\_access\_public\_instance) | Whitelisted IP for accessing public instance | `string` | n/a | yes |
| <a name="input_private_instance_name"></a> [private\_instance\_name](#input\_private\_instance\_name) | Private EC2 Instance Name | `string` | n/a | yes |
| <a name="input_private_instance_type"></a> [private\_instance\_type](#input\_private\_instance\_type) | Private EC2 Instance Type | `string` | n/a | yes |
| <a name="input_private_subnet_cidrs"></a> [private\_subnet\_cidrs](#input\_private\_subnet\_cidrs) | CIDRs for Private Subnets | `list(string)` | n/a | yes |
| <a name="input_public_instance_name"></a> [public\_instance\_name](#input\_public\_instance\_name) | Public EC2 Instance Name | `string` | n/a | yes |
| <a name="input_public_instance_private_ip"></a> [public\_instance\_private\_ip](#input\_public\_instance\_private\_ip) | Private IP for the Public Instance | `string` | n/a | yes |
| <a name="input_public_instance_type"></a> [public\_instance\_type](#input\_public\_instance\_type) | Public EC2 Instance Type | `string` | n/a | yes |
| <a name="input_public_subnet_cidrs"></a> [public\_subnet\_cidrs](#input\_public\_subnet\_cidrs) | CIDRs for Public Subnets | `list(string)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | `"eu-west-1"` | no |
| <a name="input_ssh_public_key_path"></a> [ssh\_public\_key\_path](#input\_ssh\_public\_key\_path) | Path to SSH public key directory | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Add Default Tags for All Resources | `map(string)` | <pre>{<br>  "ManagedBy": "OpenTofu"<br>}</pre> | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | VPC CIDR | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
