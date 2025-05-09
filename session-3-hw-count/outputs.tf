output "vpc_id" {
  value = aws_vpc.main.id
  description = "id of main vpc"
}

output "public_subnet_ids" {
  value = [for subnet in aws_subnet.public_subnets : subnet.id]
  description = "public subnets id"
}

output "private_subnet_ids" {
  value = [for subnet in aws_subnet.private_subnets: subnet.id]
  description = "private subnets id"
}