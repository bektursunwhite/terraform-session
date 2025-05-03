### Creating AWS Ec2 Instance through terraform  
### Install httpd package, enable it and run "Session 2 homework is complete!" 
### Parameters: Instance type: t2.micro -- AMI: AWS Linux 2023 -- tag: Key = Name; Value = my-terraform-web-server

# Creating Security Group:

resource "aws_security_group" "simple_sg" {
    name = "simple_sg"
    description = "for my terrafrom web-server"

ingress {                              // Inbound rule 1
    from_port        = 22  
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]   // Anywhere
   }

ingress {                              // Inbound Rule 2
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]   // Anywhere
   }
  
egress {                               // Outbound rule
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]    
  }
}


# Creating Ec2 Instance:
resource "aws_instance" "first_ec2" {
    ami = "ami-07b0c09aab6e66ee9"                          // Indicating id of region's AMI
    instance_type = "t2.micro"        
    key_name = "mymacpubkey"                               // Indicating the name of key pair 
    security_groups = [aws_security_group.simple_sg.name]  // Indicating security group with no string
    ### user_data for the script
    user_data = <<-EOF
              #!/bin/bash
              dnf update -y
              dnf install httpd -y
              systemctl enable httpd
              systemctl start httpd
              echo "<html><body><h1>Session-2 homework is complete!</h1></body></html>" > /var/www/html/index.html
              EOF
    
    tags = {
      name = "My-terraform-web-server"
    }
}
