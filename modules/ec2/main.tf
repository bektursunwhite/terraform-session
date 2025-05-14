resource "aws_instance" "first_ec2" {
                                         //meta argument
    ami = var.ami
    instance_type = var.instance_type   
    tags = {
      Name = "${var.env}-instance"
      Environment = var.env
    }
    vpc_security_group_ids = var.vpc_security_group_ids 

}
