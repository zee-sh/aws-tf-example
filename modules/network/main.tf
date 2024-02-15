resource "aws_vpc" "workload_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    "Name" = "workload-vpc"
  }
}

resource "aws_default_security_group" "default_egress" {
  vpc_id = aws_vpc.workload_vpc.id
}

# --- Public Subnets ---
resource "aws_subnet" "public" {
  count             = length(var.azs)
  vpc_id            = aws_vpc.workload_vpc.id
  cidr_block        = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    "Name"     = "public-subnet-${count.index + 1}"
    "isPublic" = "true"
  }
}

# --- Private Subnets ---
resource "aws_subnet" "private" {
  count             = length(var.azs)
  vpc_id            = aws_vpc.workload_vpc.id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    "Name"     = "private-subnet-${count.index + 1}"
    "isPublic" = "false"
  }
}

# --- EIP ---
resource "aws_eip" "nat" {
  count  = length(var.azs)
  domain = "vpc"

  tags = {
    "Name"    = "eip-natgw-${count.index + 1}",
    "VpcName" = "workload-vpc"
  }
}

# --- Internet Gateway ---
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.workload_vpc.id

  tags = {
    "Name"    = "igw-workload-vpc",
    "VpcName" = "workload-vpc"
  }
}

# --- NAT Gateway ---
resource "aws_nat_gateway" "ngw" {
  count         = length(aws_subnet.public)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = {
    "Name"    = "natgw-${count.index + 1}",
    "VpcName" = "workload-vpc"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}
