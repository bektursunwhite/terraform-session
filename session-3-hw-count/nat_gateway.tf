resource "aws_eip" "elastic_ip" {
  tags = {
  Name = "Elastic-IP for VPC"
  } 
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id     = aws_subnet.public_subnets[0].id

  tags = {
    Name = "session3-nat-gw"
  }

  depends_on = [aws_internet_gateway.igw]
}