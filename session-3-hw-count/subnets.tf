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