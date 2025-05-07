
# resource "aws_security_group" "simple_sg" {
#     name = "simple_sg"
#     description = "for my terrafrom web-server"

# // Terraform dynamic

# ingress {                             
#     from_port        = 22  
#     to_port          = 22
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]   
#    }

# ingress {                        
#     from_port        = 80
#     to_port          = 80
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]  
#    }
  
# egress {                             
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]    
#   }
# }


# Creating Ec2 Instance:
resource "aws_instance" "first_ec2" {
                                         //meta argument
    ami = data.aws_ami.amazon_linux_2023.id 
    instance_type = var.instance_type   
    tags = {
      Name = "${var.env}-instance"
      Environment = var.env
    }
    vpc_security_group_ids = [aws_security_group.simple_sg.id]
    user_data = templatefile("userdata.sh", {environment = var.env })
}

resource "aws_security_group" "simple_sg" {

  name = "${var.env}-instance-sg"
  description = "Allow SSH and HTTP access"
 }




resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  count = length(var.ingress_ports)
  security_group_id = aws_security_group.simple_sg.id
  cidr_ipv4         = element (var.ingress_cidr, count.index)
  from_port         = element (var.ingress_ports,count.index)
  ip_protocol       = "tcp"
  to_port           = element (var.ingress_ports,count.index)

}

# count = 3 
# count.index = 0, 1, 2

# element = ( [ 45, 67, 23, 14, 57, 15, 17 ], 4 ) 
#  > 57


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.simple_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}