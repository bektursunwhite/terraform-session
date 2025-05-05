resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpc-session3"
  }
}
resource "aws_subnet" "first_pub_subnet" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "pub-subnet1"
  }
}

resource "aws_subnet" "second_pub_subnet" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "pub-subnet2"
  }
}

resource "aws_subnet" "third_pub_subnet" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1c"
  tags = {
    Name = "pub-subnet3"
  }
}



resource "aws_subnet" "first_pri_subnet" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "pri-subnet1"
  }
}

resource "aws_subnet" "second_pri_subnet" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "pri-subnet2"
  }
}

resource "aws_subnet" "third_pri_subnet" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "us-east-1c"
  tags = {
    Name = "pri-subnet3"
  }
}





resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "terraform-session-igw"
  }
}








resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id 
  }
  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table" "private_route_table" {
    vpc_id = aws_vpc.main.id
    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
  }
    tags = { 
        Name = "private-route_table"
    }
}






resource "aws_eip" "elastic_ip" {
  tags = {
  Name = "Elastic-IP"
  } 
}

resource "aws_nat_gateway" "nat_gw" {
   allocation_id = aws_eip.elastic_ip.id
   subnet_id = aws_subnet.first_pri_subnet.id 
   tags = { 
    Name = "NAT-gw"
   }

   depends_on = [aws_internet_gateway.igw]
}




resource "aws_route_table_association" "private-sub1" {
  subnet_id      = aws_subnet.first_pri_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private-sub2" {
  subnet_id      = aws_subnet.second_pri_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private-sub3" {
  subnet_id      = aws_subnet.third_pri_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "public-sub1" {
  subnet_id      = aws_subnet.first_pub_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public-sub2" {
  subnet_id      = aws_subnet.second_pub_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public-sub3" {
  subnet_id      = aws_subnet.third_pub_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}