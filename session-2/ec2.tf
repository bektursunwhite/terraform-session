# resource "aws_instance" "first_ec2" {
#   ami           = "ami-07b0c09aab6e66ee9"
#   instance_type = "t2.micro"
#   tags = {
#     Name        = "testing"
#     Environment = "dev"
#   }
# }

# resource "aws_instance" "second_ec2" {
#   ami           = "ami-07b0c09aab6e66ee9"
#   instance_type = "t2.micro"
#   tags = {
#     Name        = "test1"
#     Environment = "dev"
#   }
# }

# resource "aws_security_group" "simple_sg" {
#   name = "simple-sg"
#   description = "This is a test sg"

# ingress {
#     from_port        = 22
#     to_port          = 22
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }
  
# egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }
# }








# ######## ---- Interpolation
# ###### block && argument


# # Terraform has two main blocks (resource vs data resource)
# # Resource Block = create and manage
# # Resource Block has two lables = first_label, second_label
# # FIRST_LABEL = indicates the resource that you want to create or manage, defined by HashiCorp
# # SECOND_LABEL  = indicates the logical name or logical ID for your Terraform resource, unique within your working directory, defined by the Author
# ##### Argument = configuration of your resource, key = value