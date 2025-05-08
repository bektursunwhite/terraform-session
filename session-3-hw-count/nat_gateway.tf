resource "aws_eip" "elastic_ip" {
  tags = {
  Name = "Elastic-IP for VPC"
  } 
}

resource "aws_nat_gateway" "nat_gw" {
   allocation_id = aws_eip.elastic_ip.id
   subnet_id = aws_subnet.private_subnets.id
   tags = { 
    Name = "NAT-gw"
   }

   depends_on = [aws_internet_gateway.igw]
}