resource "aws_route_table_association" "public_subnet_associate" {
 count = length(var.public_subnets_cidrs)
 subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
 route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_subnet_associate" {
  count = length(var.private_subnets_cidrs)
  subnet_id = element(aws_subnet.private_subnets[*].id, count.index)
  route_table_id = aws_route_table.private_route_table.id
}