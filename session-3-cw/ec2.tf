


// Reference to Resource
// Syntax: first_label.second_label.attribute
// Example: aws_security_group.simple.sg.id

// Reference to Input variable
// Syntax: var.variable_name
// Example: var.instance_type

resource "aws_security_group" "simple_sg" {
    name = "simple_sg"
    description = "for my terrafrom web-server"

ingress {                             
    from_port        = 22  
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]   
   }

ingress {                        
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]  
   }
  
egress {                             
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]    
  }
}


# Creating Ec2 Instance:
resource "aws_instance" "first_ec2" {
    ami = "ami-0f88e80871fd81e91" 
    instance_type = var.instance_type   
    tags = {
      Name = "${var.env}-instance"
      Name2 = format("%s-instance", var.env     )
      Environment = var.env
    }
    vpc_security_group_ids = [aws_security_group.simple_sg.id]
}
 