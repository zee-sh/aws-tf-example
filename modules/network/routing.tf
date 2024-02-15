
# --- Route Tables ---
# --- Public route tables ---
resource "aws_route_table" "public" {
  count  = length(aws_subnet.public)
  vpc_id = aws_vpc.workload_vpc.id

  tags = {
    "Name"     = "public-route-table"
    "isPublic" = "true"
  }
}

# --- Private route tables ---
resource "aws_route_table" "private" {
  count  = length(aws_subnet.private)
  vpc_id = aws_vpc.workload_vpc.id

  tags = {
    "Name"     = "private-route-table"
    "isPublic" = "true"
  }
}

# --- Route Table Associations ---
resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = lookup(element(aws_subnet.public, count.index), "id", null)
  route_table_id = lookup(element(aws_route_table.public, count.index), "id", null)
}

resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.public)
  subnet_id      = lookup(element(aws_subnet.private, count.index), "id", null)
  route_table_id = lookup(element(aws_route_table.private, count.index), "id", null)
}



# --- Routes ---
# Default route towards nat gateway for private subnets
resource "aws_route" "private_to_nat" {
  count                  = length(aws_subnet.public)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ngw[count.index].id
  route_table_id         = aws_route_table.private[count.index].id
}

# Default route towards igw
resource "aws_route" "public_to_igw" {
  count                  = length(aws_subnet.public)
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
  route_table_id         = aws_route_table.public[count.index].id
}
