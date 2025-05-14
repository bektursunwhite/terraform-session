variable "instance_type" {
    description = "aws instance size or type"
    type = string
    default = "t2.micro" 
 }

 variable "env" {
   description = "environment"
   type = string
   default = "qa"
 }

 variable "ami" {
   description = "ami id "
   type = string
   default = "xyz"
 }

 variable "vpc_security_group_ids" {
   description = "security group ids"
   type = list(string)
   default = [ "xyz" ]
 }