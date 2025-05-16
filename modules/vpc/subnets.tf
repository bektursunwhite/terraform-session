resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnets_cidrs)
  vpc_id = aws_vpc.main.id
  cidr_block =var.public_subnets_cidrs [count.index]
  availability_zone =var.azs [count.index]

  tags = {
    Name = "Public subnet ${count.index + 1 }"
  }
}


resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnets_cidrs)
  vpc_id = aws_vpc.main.id
  cidr_block = var.private_subnets_cidrs [count.index]
  availability_zone = var.azs [count.index]

  tags = {
    Name = "Private subnet ${count.index + 1}"
  }
}



resource "aws_route_table_association" "public_subnet_associate" {
 count = length(aws_subnet.public_subnets)
 subnet_id      = aws_subnet.public_subnets[count.index].id
 route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_subnet_associate" {
  count = length(aws_subnet.private_subnets)
  subnet_id = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}



resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id 
  }
  tags = {
    Name = "public Route Table"
  }
}


resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id
  route { 
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
  }
  tags = { 
    Name = "Private Route Table"
  }
}