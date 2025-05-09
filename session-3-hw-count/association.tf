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