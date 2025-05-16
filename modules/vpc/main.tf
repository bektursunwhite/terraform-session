resource "aws_vpc" "main" {
 cidr_block = var.main_cidr
 
 tags = {
   Name = "${var.env}-vpc"
   Environment = "${var.env}"
 }
}